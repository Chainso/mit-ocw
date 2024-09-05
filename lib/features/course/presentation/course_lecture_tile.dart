import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:mit_ocw/config/ocw_config.dart';
import 'package:mit_ocw/features/course/domain/course.dart';
import 'package:mit_ocw/features/course/domain/lecture.dart';
import 'package:mit_ocw/routes.dart';

class LectureTile extends StatefulWidget {
  const LectureTile({
    super.key,
    required this.courseRun,
    required this.lecture,
    required this.onTap,
  });

  final FullCourseRun courseRun;
  final Lecture lecture;
  final VoidCallback onTap;

  @override
  State<LectureTile> createState() => _LectureTileState();
}

class _LectureTileState extends State<LectureTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: widget.onTap,
        child: Column(
          children: <Widget>[
            Image.network(widget.lecture.imageSrc!),
            ListTile(
              title: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        Text(
                          widget.lecture.title,
                          textAlign: TextAlign.left,
                          softWrap: true,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget.courseRun.run.instructors.join(", "),
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
                          "${widget.courseRun.course.coursenum} | ${widget.courseRun.run.level?[0].name.characters.first.toUpperCase()}",
                          textAlign: TextAlign.left,
                          softWrap: true,
                          style: const TextStyle(
                            color: Color.fromRGBO(163, 31, 52, 1),
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          widget.courseRun.course.departmentName.join(", "),
                          textAlign: TextAlign.left,
                          softWrap: true,
                          style: const TextStyle(fontWeight: FontWeight.bold)
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              subtitle: widget.lecture.shortDescription != null ? MarkdownBody(data: widget.lecture.shortDescription!) : null,
            )
          ]
        ),
      ),
    );
  }
}
