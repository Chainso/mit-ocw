import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mit_ocw/bloc/course_bloc/course_bloc.dart';
import 'package:mit_ocw/bloc/lecture_bloc/lecture_bloc.dart';
import 'package:mit_ocw/features/course/data/watch_history_repository.dart';
import 'package:mit_ocw/features/course/domain/lecture.dart';
import 'package:mit_ocw/features/course/presentation/courses/course_header.dart';
import 'package:mit_ocw/routes.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class CourseLecturesScreen extends StatelessWidget {
  final String coursenum;

  const CourseLecturesScreen({super.key, required this.coursenum});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseBloc, CourseState>(
      builder: (context, courseState) {
        if (courseState is! CourseLoadedState) {
          return const Expanded(
            child: Center(
              child: Text("Unexpected error occurred, please try again later")
            )
          );
        }

        CourseLoadedState loadedCourse = courseState;

        final courseRun = loadedCourse.course;

        return BlocBuilder<LectureBloc, LectureListState>(
          builder: (context, lectureListState) {
            switch (lectureListState) {
              case LectureListLoadingState _:
                return const Expanded(
                  child: Center(
                    child: CircularProgressIndicator()
                  )
                );
              case LectureListErrorState _:
                return const Expanded(
                  child: Center(
                    child: Text(
                      "Error loading lectures, please try again",
                      style: TextStyle(color: Colors.white)
                    )
                  )
                );
              case LectureListLoadedState loadedLectures:
                return Scaffold(
                  backgroundColor: Colors.black,
                  body: Column(
                    children: [
                      CourseHeader(courseTitle: courseRun.course.title),
                      Expanded(
                        child: _buildLectureList(context, loadedLectures.lectures),
                      ),
                    ],
                  ),
                );
            }
          },
        );
      },
    );
  }

  Widget _buildLectureList(BuildContext context, List<Lecture> lectures) {
    return FutureBuilder(
      future: context.read<WatchHistoryRepository>().getWatchHistoryForCourse(coursenum),
      builder: (context, snapshot) {
        return ScrollablePositionedList.builder(
          itemCount: lectures.length,
          itemBuilder: (context, index) {
            final lecture = lectures[index];

            Widget lectureImage = ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                lecture.imageSrc ?? 'https://via.placeholder.com/120x68',
                width: 120,
                height: 68,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                return Container(
                    color: Colors.grey[800],
                    child: const Icon(Icons.error, color: Colors.white),
                    );
                },
              ),
            );

            if (snapshot.hasData) {
              // Show red bar as a % of watched
              final fullWatchHistory = snapshot.data!;
              final watchHistory = fullWatchHistory[lecture.key];

              if (watchHistory != null) {
                final watchedPercent = watchHistory.position / watchHistory.lectureLength;

                if (watchedPercent > 0) {
                  // Gray bar for full length, red bar for watched %
                  final watchedBar = Container(
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: watchedPercent,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  );

                  lectureImage = Stack(
                    children: [
                    lectureImage,
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: watchedBar,
                      ),
                    ],
                  );
                }
              }
            }

            return InkWell(
              onTap: () {
                CourseLectureScreenRoute(
                  coursenum: coursenum,
                  lectureKey: lecture.key,
                  lectureNumber: index + 1
                ).go(context);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Row(
                  children: [
                    lectureImage,
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        lecture.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }
    );
  }
}
