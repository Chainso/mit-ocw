import 'package:flutter/material.dart';
import 'package:mit_ocw/features/course/data/course_repository.dart';
import 'package:mit_ocw/features/course/domain/course.dart';
import 'package:mit_ocw/features/course/presentation/course_tile.dart';
import 'package:go_router/go_router.dart';
import 'package:mit_ocw/routes.dart';

class SearchScreen extends StatefulWidget {
  final String? initialQuery;

  const SearchScreen({Key? key, this.initialQuery}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final TextEditingController _searchController;
  List<Course> _searchResults = [];
  bool _isLoading = false;
  final CourseRepository _courseRepository = CourseRepository();

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.initialQuery);
    if (widget.initialQuery != null) {
      _performSearch();
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final results = await _courseRepository.searchCourses(_searchController.text);
      setState(() {
        _searchResults = results;
        _isLoading = false;
      });
    } catch (e) {
      print('Error searching courses: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Courses'),
        backgroundColor: Colors.red.shade900,
      ),
      backgroundColor: const Color(0xFF121212),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search courses...',
                hintStyle: TextStyle(color: Colors.grey[400]),
                filled: true,
                fillColor: Colors.grey[800],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear, color: Colors.grey),
                  onPressed: () {
                    _searchController.clear();
                    setState(() {
                      _searchResults.clear();
                    });
                  },
                ),
              ),
              onSubmitted: (_) => _performSearch(),
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : LayoutBuilder(
                    builder: (context, constraints) {
                      final isWide = constraints.maxWidth > 600;
                      final itemHeight = isWide ? 300.0 : 167.0;
                      final itemWidth = isWide ? 250.0 : 133.0;

                      return ListView.builder(
                        itemCount: (_searchResults.length / 3).ceil(),
                        itemBuilder: (context, rowIndex) {
                          final startIndex = rowIndex * 3;
                          final endIndex = (startIndex + 3 < _searchResults.length)
                              ? startIndex + 3
                              : _searchResults.length;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: itemHeight,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  itemCount: endIndex - startIndex,
                                  itemBuilder: (context, index) {
                                    final course = _searchResults[startIndex + index];
                                    final courseRun = FullCourseRun.fromCourse(course);
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 16),
                                      child: SizedBox(
                                        width: itemWidth,
                                        child: CourseTile(courseRun: courseRun),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(height: isWide ? 32 : 24),
                            ],
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}