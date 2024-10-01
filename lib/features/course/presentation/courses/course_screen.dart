import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mit_ocw/bloc/course_bloc/course_bloc.dart';
import 'package:mit_ocw/bloc/lecture_bloc/lecture_bloc.dart';
import 'package:mit_ocw/config/ocw_config.dart';
import 'package:mit_ocw/features/course/presentation/courses/course_header.dart';
import 'package:mit_ocw/features/course/presentation/courses/course_lecture_list.dart';
import 'package:mit_ocw/features/course/presentation/courses/course_overview_screen.dart';
import 'package:sliver_tools/sliver_tools.dart';

class CourseScreen extends StatelessWidget {
  final String coursenum;

  const CourseScreen({super.key, required this.coursenum});

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

        return DefaultTabController(
          length: 2,
          child: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverOverlapAbsorber(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: MultiSliver(
                  children: [
                    SliverPinnedHeader(
                      child: CourseHeader(courseTitle: courseRun.course.title),
                    ),
                    SliverAppBar(
                      expandedHeight: MediaQuery.of(context).size.height * 0.3,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.network(
                              ocwUrl + courseRun.course.imageSrc,
                              fit: BoxFit.cover,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withOpacity(0.7),
                                  ],
                                  stops: const [0.5, 1.0],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 16,
                              right: 16,
                              bottom: 16,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${courseRun.course.coursenum} | ${courseRun.course.created.year}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white.withOpacity(0.8),
                                      shadows: const [
                                        Shadow(
                                          offset: Offset(1.0, 1.0),
                                          blurRadius: 3.0,
                                          color: Color.fromARGB(255, 0, 0, 0),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    courseRun.run.instructors.join(", "),
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white.withOpacity(0.8),
                                      shadows: const [
                                        Shadow(
                                          offset: Offset(1.0, 1.0),
                                          blurRadius: 3.0,
                                          color: Color.fromARGB(255, 0, 0, 0),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SliverAppBar(
                      pinned: true,
                      forceElevated: true,
                      expandedHeight: 0,
                      collapsedHeight: 0,
                      toolbarHeight: 0,
                      bottom: TabBar.secondary(
                        indicator: UnderlineTabIndicator(
                          borderSide: BorderSide(
                            width: 2,
                            color: Colors.white,
                          ),
                        ),
                        tabs: [
                          Tab(icon: Icon(Icons.info), text: "Overview"),
                          Tab(icon: Icon(Icons.video_collection), text: "Lectures"),
                        ],
                      ),
                    ),
                  ]
                )
              )
            ],
            body: BlocBuilder<LectureBloc, LectureListState>(
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
                        )
                      )
                    );
                  case LectureListLoadedState _:
                    return Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: TabBarView(
                        children: [
                          _buildTab(
                            key: "overview",
                            slivers: [
                              CourseOverviewScreen(
                                courseRun: courseRun,
                                lectures: lectureListState.lectures,
                              )
                            ]
                          ),
                          _buildTab(
                            key: "lectures",
                            slivers: [
                              CourseLectureList(
                                courseRun: courseRun,
                                lectures: lectureListState.lectures,
                              )
                            ]
                          )
                        ],
                      )
                    );
                }
              }
            )
          )
        );
      },
    );
  }

  Widget _buildTab({
    required String key,
    required List<Widget> slivers
  }) {
    return Builder(
      builder: (context) {
        return SafeArea(
          child: Container(
            alignment: Alignment.centerLeft,
            child: CustomScrollView(
              key: PageStorageKey<String>(key),
              slivers: [
                SliverOverlapInjector(
                  handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                ),
                ...slivers
              ],
            ),
          ),
        );
      }
    );
  }
}
