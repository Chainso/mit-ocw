import 'package:mit_ocw/features/course/domain/course.dart';

class CourseService {
  static getCourseDirName(Course course) {
    final courseRun = course.runs[0];
    final courseDirName = "${course.coursenum}-${courseRun.semester.name}-${courseRun.year}".toLowerCase();

    return courseDirName;
  }
}
