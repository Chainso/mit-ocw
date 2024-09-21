import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mit_ocw/features/course/data/pagination.dart';
import 'package:mit_ocw/features/course/data/watch_history_repository.dart';
import 'package:mit_ocw/features/course/domain/course.dart';
import 'package:mit_ocw/features/course/presentation/home/course_tile.dart';
import 'package:mit_ocw/features/persistence/database.dart';

class CategorySection<CURSOR> extends StatefulWidget {
  final String category;
  final PaginatedQuery<CURSOR, FullCourseRun> categoryFetcher;
  final CURSOR initialPageKey;
  final bool withHistory;

  const CategorySection({
    super.key,
    required this.category,
    required this.categoryFetcher,
    required this.initialPageKey,
    required this.withHistory
  });

  @override
  State<StatefulWidget> createState() => _CategorySectionState<CURSOR>();
}

class _CategorySectionState<CURSOR> extends State<CategorySection<CURSOR>> {
  static const _pageSize = 4;
  late PagingController<CURSOR, CourseRunWithLatestLectureWatchHistory> _pagingController;

  @override
  void initState() {
    super.initState();
    _pagingController = PagingController(firstPageKey: widget.initialPageKey);

    final fetcherWithWatchHistory = wrapFetcherWithWatchHistory();
    fetcherWithWatchHistory.addListenerToPagingController(_pagingController, _pageSize);
  }

  PaginatedQuery<CURSOR, CourseRunWithLatestLectureWatchHistory> wrapFetcherWithWatchHistory() {
    final watchHistoryRepository = context.read<WatchHistoryRepository>();

    return PaginatedQuery(
      fetchPage: (cursor, pageSize) async {
        final page = await widget.categoryFetcher.fetchPage(cursor, pageSize);
        
        Map<String, LectureWatchHistoryData?> watchHistories = {};

        if (widget.withHistory) {
          final coursenums = page.items.map((courseRun) => courseRun.item.course.coursenum).toList();
          watchHistories = await watchHistoryRepository.getLatestWatchedLectureForCourses(coursenums);
        }

        final courseRunsWithWatchHistory = page.items.map((courseRunPagedItem) {
          return courseRunPagedItem.map((courseRun) {
            final latestLectureWatchHistory = watchHistories[courseRun.course.coursenum];
            return CourseRunWithLatestLectureWatchHistory(
              courseRun: courseRun,
              latestLectureWatchHistory: latestLectureWatchHistory,
            );
          });
        }).toList();

        return PaginatedResults(
          items: courseRunsWithWatchHistory,
          hasPrevious: page.hasPrevious,
          hasNext: page.hasNext,
        );
      },
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 600;
        final itemHeight = isWide ? 300.0 : 160.0; // Reduced mobile height
        final itemWidth = isWide ? 250.0 : 133.0; // Reduced mobile width

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16, isWide ? 32 : 24, 16, 12),
              child: Text(
                widget.category,
                style: TextStyle(
                  color: Colors.white, // White text for category names
                  fontSize: isWide ? 28 : 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: itemHeight,
              child: PagedListView<CURSOR, CourseRunWithLatestLectureWatchHistory>(
                pagingController: _pagingController,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                builderDelegate: PagedChildBuilderDelegate<CourseRunWithLatestLectureWatchHistory>(
                  itemBuilder: (context, item, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: SizedBox(
                        width: itemWidth,
                        child: CourseTile(courseRunWithHistory: item),
                      ),
                    );
                  }
                )
              ),
            ),
            SizedBox(height: isWide ? 32 : 24),
          ],
        );
      },
    );
  }
}
