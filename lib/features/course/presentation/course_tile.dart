import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:mit_ocw/config/ocw_config.dart';
import 'package:mit_ocw/features/course/domain/course.dart';
import 'package:mit_ocw/routes.dart';

class CourseTile extends StatefulWidget {
  const CourseTile({super.key, required this.courseRun});

  final FullCourseRun courseRun;

  @override
  State<CourseTile> createState() => _CourseTileState();
}

class _CourseTileState extends State<CourseTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: GestureDetector(
        onTap: () {
          CourseHomeRoute(courseId: widget.courseRun.course.id).go(context);
        },
        child: Column(
          children: <Widget>[
            Image.network(ocwUrl + widget.courseRun.course.imageSrc),
            ListTile(
              title: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        Text(
                          widget.courseRun.course.title,
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
              subtitle: MarkdownBody(data: widget.courseRun.course.shortDescription),
            )
          ]
        ),
      ),
    );
  }
}
