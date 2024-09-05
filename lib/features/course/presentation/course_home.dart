import 'dart:developer';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_archive/flutter_archive.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:mit_ocw/bloc/course_bloc/course_bloc.dart';
import 'package:mit_ocw/config/ocw_config.dart';
import 'package:mit_ocw/features/course/domain/course.dart';
import 'package:mit_ocw/features/course/service/course_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as path;

class CourseDownload {
  CourseDownload({
    required this.id,
    required this.status,
    required this.progress,
    required this.downloadDirectory,
  });

  final String id;
  DownloadTaskStatus status;
  int progress;
  final Directory downloadDirectory;

  @override
  String toString() {
    return """
      CourseDownload(
      Id: $id
      Status: $status
      Progress: $progress
      downloadDirectory: $downloadDirectory
    )""";
  }
}

const courseDownloadPort = "course_download_port";

class CourseHomeScreen extends StatefulWidget {
  const CourseHomeScreen({super.key, required this.courseId});

  final int courseId;

  @override
  State<CourseHomeScreen> createState() => _CourseHomeScreenState();
}

class _CourseHomeScreenState extends State<CourseHomeScreen> {
  CourseDownload? _courseDownload;
  final ReceivePort _port = ReceivePort();

  @override
  void initState() {
    super.initState();

    IsolateNameServer.registerPortWithName(_port.sendPort, courseDownloadPort);
    _port.listen((dynamic data) {
      try {
        print("Got download callback");
        log("Got download callback as log");
        String id = data[0];
        DownloadTaskStatus status = DownloadTaskStatus.fromInt(data[1]);
        int progress = data[2];
        print(data);
        print(progress);

        if (_courseDownload == null) {
          log("Course download is null");
          return;
        }

        if (_courseDownload!.id != id) {
          log("Course download id does not match");
          return;
        }

        // log("Download callback: $id, $status, $progress");
        //
        print("Print for download at $progress%");
        // log("Log for download at $progress%");
        setState(() {
          if (_courseDownload == null) {
            log("Course download is null in set state");
            return;
          }

          print("Updating progress from ${_courseDownload!.progress} to $progress%");
          _courseDownload!.status = status;
          _courseDownload!.progress = progress;
          print(_courseDownload!);
        });

        if (status == DownloadTaskStatus.complete) {
          log("Download complete");

          FlutterDownloader.loadTasks().then((List<DownloadTask>? tasks) {
            if (tasks == null) {
              log("Could not load tasks");
              return;
            }

            final DownloadTask task = tasks.firstWhere((taskEle) => taskEle.taskId == id);

            final String filePath = "${task.savedDir}/${task.filename}";

            print("File path: $filePath");

            final courseZip = File(filePath);
            final unzipDestination = Directory(path.join(
              _courseDownload!.downloadDirectory.path,
              path.basenameWithoutExtension(filePath)
            ));

            if (!unzipDestination.existsSync()) {
              unzipDestination.createSync(recursive: true);
            }

            try {
              print("About to unzip from ${courseZip.path} to ${unzipDestination.path}");
              ZipFile.extractToDirectory(
                zipFile: courseZip,
                destinationDir: unzipDestination,
                onExtracting: (zipEntry, progress) {
                  log('progress: ${progress.toStringAsFixed(1)}%');
                  log('name: ${zipEntry.name}');
                  log('isDirectory: ${zipEntry.isDirectory}');
                  log(
                    'modificationDate: ${zipEntry.modificationDate!.toLocal().toIso8601String()}');
                  log('uncompressedSize: ${zipEntry.uncompressedSize}');
                  log('compressedSize: ${zipEntry.compressedSize}');
                  log('compressionMethod: ${zipEntry.compressionMethod}');
                  log('crc: ${zipEntry.crc}');
                  return ZipFileOperation.includeItem;
                },
              ).then((dynamic data) {
                log("Unzipped: ${unzipDestination.path}");
                print(data);
                courseZip.delete();
              });
            } catch (e) {
              log("Could not unzip file");
              log(e.toString());
            }
          });
        }
      } catch (e) {
        log("Could not parse download callback");
        log(e.toString());
      }
    });

    FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping(courseDownloadPort);
    super.dispose();
  }

  @pragma('vm:entry-point')
  static void downloadCallback(String id, int status, int progress) {
    print("Download callback");
    log("Download callback as log");
    print("Sending:");
    print(progress);
    IsolateNameServer.lookupPortByName(courseDownloadPort)
      ?.send([id, status, progress]);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseBloc, CourseListState>(
      builder: (context, state) {
        if (state is CourseListErrorState) {
          return Center(
            child: Text(state.error),
          );
        }

        if (state is CourseListLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is CourseListLoadedState) {
          FullCourseRun courseRun = state.courses[widget.courseId]!;

          return Column(
            children: [
              Image.network(ocwUrl + courseRun.course.imageSrc),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        Text(
                          courseRun.course.title,
                          textAlign: TextAlign.left,
                          softWrap: true,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          courseRun.run.instructors.join(", "),
                          textAlign: TextAlign.left,
                          softWrap: true,
                          style: const TextStyle(fontWeight: FontWeight.bold)
                        ),
                      ],
                    ),
                  ),
                  const Expanded(
                    flex: 1,
                    child: Column(),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        Text(
                          "${courseRun.course.coursenum} | ${courseRun.run.level?[0].name.characters.first.toUpperCase()}",
                          textAlign: TextAlign.left,
                          softWrap: true,
                          style: const TextStyle(
                            color: Color.fromRGBO(163, 31, 52, 1),
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          courseRun.course.departmentName.join(", "),
                          textAlign: TextAlign.left,
                          softWrap: true,
                          style: const TextStyle(fontWeight: FontWeight.bold)
                        ),
                      ],
                    ),

                  ),

                ],
              ),
              FloatingActionButton.extended(
                onPressed: () async {
                  if (!await Permission.storage.isGranted) {
                    final downloadPermissions = await Permission.storage.request();
                    if (downloadPermissions != PermissionStatus.granted) {
                      log("Not granted download permissions");
                      setState(() {
                        _courseDownload = CourseDownload(
                          id: "0",
                          status: DownloadTaskStatus.undefined,
                          progress: -2,
                          downloadDirectory: Directory(""),
                        );
                      });
                      return;
                    }
                  }

                  // String? courseDirPath = await FilePicker.platform.getDirectoryPath();
                  //
                  // if (courseDirPath == null) {
                  //   // User canceled the picker
                  //   log("Could not get unzip directory");
                  //   return;
                  // }
                  //
                  // Directory courseDir = Directory(courseDirPath);
                  Directory courseDir = (await getDownloadsDirectory())!;
                  Directory zipDownloadDir = (await getDownloadsDirectory())!;

                  print("Zip download dir: ${zipDownloadDir.path}");

                  final courseDownloadFileId = CourseService.getCourseDirName(courseRun.course);
                  final courseDownloadFileName = "$courseDownloadFileId.zip";
                  final courseDownloadLinkRelative = "${courseRun.run.slug}/$courseDownloadFileName";
                  final courseDownloadLink = "$ocwUrl/$courseDownloadLinkRelative";

                  final downloadTaskId = await FlutterDownloader.enqueue(
                    url: courseDownloadLink,
                    savedDir: zipDownloadDir.path,
                    showNotification: true, // show download progress in status bar (for Android)
                    openFileFromNotification: true, // click on notification to open downloaded file (for Android)
                  );

                  if (downloadTaskId == null) {
                    log("Could not download course, failed to get task");
                    return;
                  }

                  setState(() {
                    _courseDownload = CourseDownload(
                      id: downloadTaskId,
                      status: DownloadTaskStatus.undefined,
                      progress: 0,
                      downloadDirectory: courseDir,
                    );
                  });
                },
                label: Text("Download Course${_courseDownload != null ? " ${_courseDownload!.progress}%" : ""}"),
                icon: const Icon(Icons.download),
              ),
              MarkdownBody(data: courseRun.course.fullDescription ?? courseRun.course.shortDescription),
            ]
          );
        }

        return const Center(
          child: Text("Course not found"),
        );
      },
    );
  }
}

