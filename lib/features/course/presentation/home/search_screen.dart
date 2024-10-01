import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:mit_ocw/features/course/data/course_repository.dart';
import 'package:mit_ocw/features/course/domain/course.dart';
import 'package:mit_ocw/features/course/presentation/home/focused_course_list.dart';
import 'package:mit_ocw/features/course/presentation/home/home_header.dart';

class SearchScreen extends StatefulWidget {
  final String? initialQuery;

  const SearchScreen({super.key, this.initialQuery});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final Logger logger = Logger();
  List<FullCourseRun> _searchResults = [];
  bool _isLoading = false;
  String? _currentQuery;

  @override
  void initState() {
    super.initState();
    if (widget.initialQuery != null) {
      _performSearch(widget.initialQuery!);
    }
  }

  void _performSearch(String query) async {
    setState(() {
      _isLoading = true;
      _currentQuery = query;
    });

    try {
      final repository = context.read<CourseRepository>();
      final results = await repository.searchCourses(query);
      setState(() {
        _searchResults = results;
        _isLoading = false;
      });
    } catch (e) {
      logger.e("Error searching courses: $e", error: e);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HomeHeader(onSearch: _performSearch),
        Expanded(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _buildSearchResultsList(),
        ),
      ],
    );
  }

  Widget _buildSearchResultsList() {
    if (_currentQuery == null) {
      return const Center(child: Text('Start searching for courses', style: TextStyle(color: Colors.white)));
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            _searchResults.isEmpty
                ? 'No results for "$_currentQuery"'
                : 'Search results for "$_currentQuery"',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: FocusedCourseList(courses: _searchResults),
        ),
      ],
    );
  }
}
