import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mit_ocw/bloc/course_bloc/course_bloc.dart';
import 'package:mit_ocw/bloc/lecture_bloc/lecture_bloc.dart';
import 'package:mit_ocw/features/course/data/watch_history_repository.dart';
import 'package:mit_ocw/features/course/domain/lecture.dart';
import 'package:mit_ocw/features/persistence/database.dart';

class CourseLectureList extends StatelessWidget {
  final Function(Lecture, int)? onLectureSelected;

  const CourseLectureList({
    super.key,
    this.onLectureSelected
  });

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

        final courseRun = courseState.course;

        return BlocBuilder<LectureBloc, LectureListState>(
          builder: (context, lectureListState) {
            switch (lectureListState) {
              case LectureListLoadingState _:
                return const SliverToBoxAdapter(
                  child: Expanded(
                    child: Center(
                      child: CircularProgressIndicator()
                    )
                  )
                );
              case LectureListErrorState _:
                return const SliverToBoxAdapter(
                  child: Expanded(
                    child: Center(
                      child: Text(
                        "Error loading lectures, please try again",
                      )
                    )
                  )
                );
              case LectureListLoadedState _:
                if (lectureListState.lectures.isEmpty) {
                  return const SliverToBoxAdapter(
                    child: Expanded(
                      child: Center(
                        child: Text("No lectures found for this course")
                      )
                    )
                  );
                }

                return FutureBuilder(
                  future: context.read<WatchHistoryRepository>().getWatchHistoryForCourse(courseRun.course.coursenum),
                  builder: (context, snapshot) {
                    return _buildLectures(context, snapshot, lectureListState.lectures);
                  }
                );
            }
          }
        );
      }
    );
  }

  SliverList _buildLectures(
    BuildContext context,
    AsyncSnapshot<Map<String, LectureWatchHistoryData>> snapshot,
    List<Lecture> lectures
  ) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return _buildLecture(context, snapshot, lectures[index], index);
        },
        childCount: lectures.length,
      ),
    );

  }

  Widget _buildLecture(
    BuildContext context,
    AsyncSnapshot<Map<String, LectureWatchHistoryData>> snapshot,
    Lecture lecture,
    int index
  ) {
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
        if (onLectureSelected != null) {
          onLectureSelected!(lecture, index);
        }
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
  }
}
