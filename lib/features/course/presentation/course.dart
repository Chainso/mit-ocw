import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:mit_ocw/config/ocw_config.dart';
import 'package:mit_ocw/features/course/domain/course.dart';

class CourseWidget extends StatefulWidget {
  const CourseWidget({super.key, required this.course});

  final Course course;

  @override
  State<CourseWidget> createState() => _CourseWidgetState();
}

class _CourseWidgetState extends State<CourseWidget> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: <Widget>[
          Image.network(ocwUrl + widget.course.imageSrc),
          ListTile(
            title: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Text(
                        widget.course.title,
                        textAlign: TextAlign.left,
                        softWrap: true,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                          widget.course.runs[0].instructors.join(", "),
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
                  flex: 2,
                  child: Column(
                    children: [
                      Text(
                        "${widget.course.coursenum} | ${widget.course.runs[0].level?[0].name.characters.first.toUpperCase()}",
                        textAlign: TextAlign.left,
                        softWrap: true,
                        style: const TextStyle(
                          color: Color.fromRGBO(163, 31, 52, 1),
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                          widget.course.departmentName.join(", "),
                          textAlign: TextAlign.left,
                          softWrap: true,
                          style: const TextStyle(fontWeight: FontWeight.bold)
                      ),
                    ],
                  ),
                ),
              ],
            ),
            subtitle: MarkdownBody(data: widget.course.shortDescription),
          )
        ]
      ) 
    );
  }
}
