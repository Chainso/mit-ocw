import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:logger/logger.dart';
import 'package:mit_ocw/features/course/data/watch_history_repository.dart';
import 'package:mit_ocw/features/course/domain/lecture.dart';

class LectureTile extends StatelessWidget {
  final Logger logger = Logger();

  LectureTile({
    super.key,
    required this.lecture,
    required this.onTap,
  });

  final Lecture lecture;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: FutureBuilder(
                future: context.read<WatchHistoryRepository>().getWatchHistory(lecture.coursenum, lecture.key),
                builder: (context, snapshot) {
                  logger.i("Got watch history for lecture ${lecture.title}");
                  logger.i(snapshot.data);
                  final imageBox = lecture.imageSrc != null
                    ? ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                        child: Image.network(
                          lecture.imageSrc ?? "https://placehold.co/600x400",
                          fit: BoxFit.cover,
                          width: double.infinity,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[800],
                              child: const Icon(Icons.error, color: Colors.white),
                            );
                          },
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                        ),
                        child: const Center(
                          child: Icon(Icons.play_circle_outline, color: Colors.white, size: 48),
                        ),
                      );

                  if (snapshot.hasData) {
                    // Show red bar as a % of watched
                    final watchHistory = snapshot.data!;

                    final watchedPercent = watchHistory.position / watchHistory.lectureLength;

                    // Gray bar for full length, red bar for watched %
                    final watchedBar = Container(
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: FractionallySizedBox(
                        widthFactor: watchedPercent,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    );

                    return Stack(
                      children: [
                        imageBox,
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: watchedBar,
                        ),
                      ],
                    );
                  } else {
                    return imageBox;
                  }
                }
              )
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lecture.title,
                    style: Theme.of(context).textTheme.titleMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (lecture.shortDescription != null)
                    MarkdownBody(
                      data: lecture.shortDescription!,
                      styleSheet: MarkdownStyleSheet(
                        p: Theme.of(context).textTheme.bodySmall,
                      ),
                      softLineBreak: true,
                      shrinkWrap: true,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
