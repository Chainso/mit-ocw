import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:mit_ocw/features/course/domain/lecture.dart';

class LectureTile extends StatelessWidget {
  const LectureTile({
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
              child: lecture.imageSrc != null
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
                    ),
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
