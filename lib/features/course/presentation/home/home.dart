import 'package:collection/collection.dart' as collection;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mit_ocw/features/course/data/course_repository.dart';
import 'package:mit_ocw/features/course/data/pagination.dart';
import 'package:mit_ocw/features/course/data/watch_history_repository.dart';
import 'package:mit_ocw/features/course/presentation/home/category_section.dart';
import 'package:mit_ocw/features/course/domain/course.dart';
import 'package:mit_ocw/features/course/presentation/home/home_header.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: Column(
        children: [
          const HomeHeader(),
          FutureBuilder(
            future: _getAggregations(context),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return HomeScreenCategories(aggregationsQuery: StaticListPaginatedQuery<String>(items: []), error: snapshot.error);
              } else if (!snapshot.hasData) {
                return const Expanded(
                  child: Center(
                    child: CircularProgressIndicator()
                  )
                );
              } else {
                final departmentsAgg = snapshot.data!.departmentName.buckets;
                final departmentNames = departmentsAgg.map((bucket) => bucket.key).toList();
                departmentNames.sort();

                final departmentQuery = StaticListPaginatedQuery<String>(
                  items: departmentNames
                );

                return HomeScreenCategories(aggregationsQuery: departmentQuery);
              }
            },
          ),
        ],
      ),
    );
  }

  Future<CourseAggregations> _getAggregations(BuildContext context) async {
    return await context.read<CourseRepository>().getAggregations();
  }
}

class HomeScreenCategories extends StatefulWidget {
  final PaginatedQuery<int, String> aggregationsQuery;
  final Object? error;

  const HomeScreenCategories({super.key, required this.aggregationsQuery, this.error});

  @override
  State<HomeScreenCategories> createState() => _HomeScreenCategoriesState();
}

class _HomeScreenCategoriesState extends State<HomeScreenCategories> {
  static const _pageSize = 4;
  final PagingController<int, String> _pagingController = PagingController(firstPageKey: 0);

  @override
  @mustCallSuper
  void initState() {
    super.initState();

    widget.aggregationsQuery.addListenerToPagingController(_pagingController, _pageSize);
  }

  @override
  void dispose() {
    super.dispose();
    _pagingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: FutureBuilder(
              future: context.read<WatchHistoryRepository>().getLatestWatchedLectureByCourse(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return const SizedBox();
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const SizedBox();
                } else {
                  final watchHistory = snapshot.data!;
                  final historyCoursenums = watchHistory.map((entry) => entry.key).toList();
                  final courseOrdering = Map.fromEntries(historyCoursenums.mapIndexed((index, coursenum) => MapEntry(coursenum, index)));

                  return FutureBuilder(
                    future: context.read<CourseRepository>().getCoursesMap(historyCoursenums),
                    builder: (context, coursesSnapshot) {
                      if (coursesSnapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (coursesSnapshot.hasError) {
                        return const SizedBox();
                      } else if (!coursesSnapshot.hasData || coursesSnapshot.data!.isEmpty) {
                        return const SizedBox();
                      } else {
                        final courses = coursesSnapshot.data!.values.toList();
                        courses.sort((a, b) => courseOrdering[a.course.coursenum]!.compareTo(courseOrdering[b.course.coursenum]!));


                        final courseFetcher = StaticListPaginatedQuery<FullCourseRun>(items: courses);

                        return CategorySection<int>(
                          category: "Continue Watching",
                          categoryFetcher: courseFetcher,
                          initialPageKey: 0,
                          withHistory: true
                        );
                      }
                    }
                  );
                }
              }
            ),
          ),
          PagedSliverList<int, String>(
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<String>(
              itemBuilder: (context, item, index) {
                CourseRepository courseRepository = context.read<CourseRepository>();

                final departmentCoursesQuery = PaginatedQuery<int, FullCourseRun>(
                 fetchPage: (from, size) => courseRepository.getCoursesByDepartment(item, from, size)
                );

                return CategorySection<int>(
                 category: item,
                 categoryFetcher: departmentCoursesQuery,
                 initialPageKey: 0,
                 withHistory: false
                );
              }
            ),
          ),
        ]
      )
    );
  }
}
