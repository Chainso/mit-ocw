import 'package:elastic_client/elastic_client.dart' as elastic;
import 'package:logger/logger.dart';
import 'package:mit_ocw/config/ocw_config.dart';
import 'package:mit_ocw/features/course/data/pagination.dart';
import 'package:mit_ocw/features/course/domain/course.dart';

import 'package:dio/dio.dart';
import 'package:mit_ocw/features/course/domain/lecture.dart';
import 'package:mit_ocw/util/elastic_search.dart';

class CourseRepository {
  final Logger logger = Logger();
  final String _courseUrl = "$ocwApiUrl/courses";
  final String _searchUrl = "$ocwApiUrl/search/";
  final dio = Dio();

  final Map<dynamic, dynamic> ocwFilter = elastic.Query.bool(
    must: [
      elastic.Query.term("offered_by", ["OCW"]),
    ],
  );

  late final Map<dynamic, dynamic> courseFilter = elastic.Query.bool(
    must: [
      elastic.Query.term("object_type.keyword", ["course"]),
      elastic.Query.term("course_feature_tags", ["Lecture Videos"]),
      ocwFilter
    ],
  );

  late final Map<dynamic, dynamic> videoFilter = elastic.Query.bool(
    must: [
      elastic.Query.term("object_type.keyword", ["resourcefile"]),
      elastic.Query.term("content_type", ["video"])
    ],
  );

  late final Map<dynamic, dynamic> lectureVideoFilter = elastic.Query.bool(
    must: [
      videoFilter,
      elastic.Query.term("resource_type", ["Lecture Videos"]),
    ],
  );

  Future<CourseAggregations> getAggregations() async {
    final response = await dio.post(
      _searchUrl,
      data: searchRequest,
    );

    if (response.statusCode == 200) {
      print("Got aggregations response");
      print(response.data);
      final aggregationSearch = AggregationSearch<CourseAggregations>.fromJson(response.data, CourseAggregations.fromJsonModel);
      return aggregationSearch.aggregations;
    } else {
      throw Exception("Failed to query aggregations");
    }
  }

  Future<List<FullCourseRun>> getCourses() async {
    final response = await dio.post(
      _searchUrl,
      data: allCoursesQuery.toJson(),
    );

    if (response.statusCode == 200) {
      try {
      final courseSearch = DocSearch<Course>.fromJson(response.data, Course.fromJsonModel);
      final List<Course> courses = courseSearch.hits.hits.map((hit) => hit.source).toList();

        final coursesWithRuns = courses.where((course) => course.runs.isNotEmpty).toList();
        final List<FullCourseRun> fullCourseRuns = coursesWithRuns.map((course) => FullCourseRun.fromCourse(course)).toList();

        return fullCourseRuns;
      } catch (e) {
        print("Failed to parse courses");
        print(e);
        rethrow;
      }
    } else {
      throw Exception("Failed to query courses");
    }
  }

  Future<PaginatedResults<int, FullCourseRun>> getCoursesByDepartment(
    String department,
    int? from,
    int? size
  ) async {
    final startIndex = from ?? 0;

    ElasticSearchQuery courseQuery = ElasticSearchQuery(
      from: startIndex,
      size: size,
      query: elastic.Query.bool(
        must: [
          courseFilter,
          elastic.Query.term("department_name", [department]),
        ],
      ),
    );

    final response = await dio.post(
      _searchUrl,
      data: courseQuery.toJson(),
    );

    if (response.statusCode == 200) {
      final courseSearch = DocSearch<Course>.fromJson(response.data, Course.fromJsonModel);
      List<FullCourseRun> courses = courseSearch.hits.hits.map((hit) => FullCourseRun.fromCourse(hit.source)).toList();

      List<PagedItem<int, FullCourseRun>> pagedItems = List.generate(
        courses.length,
        (i) => PagedItem<int, FullCourseRun>(
          cursor: startIndex + i + 1,
          item: courses[i]
        )
      );
      
      print("Got courses for department $department $startIndex $size ${courseSearch.hits.total} ${pagedItems.length}");

      return PaginatedResults<int, FullCourseRun>(
        items: pagedItems,
        hasPrevious: startIndex > 0 && courseSearch.hits.total > 0,
        hasNext: size != null && startIndex + size < courseSearch.hits.total
      );
    } else {
      throw Exception('Failed to load courses for department $department');
    }
  }

  Future<FullCourseRun?> getCourse(String coursenum) async {
    ElasticSearchQuery courseQuery = ElasticSearchQuery(
      from: 0,
      size: 1,
      query: elastic.Query.bool(
        must: [
          courseFilter,
          elastic.Query.term("coursenum", [coursenum]),
        ],
      ),
    );

    final response = await dio.post(
      _searchUrl,
      data: courseQuery.toJson(),
    );

    if (response.statusCode == 200) {
      final courseSearch = DocSearch<Course>.fromJson(response.data, Course.fromJsonModel);
      List<Hit> hits = courseSearch.hits.hits;
      print("Single course hit for $coursenum");
      print(hits);

      if (hits.isEmpty) {
        return null;
      }

      return FullCourseRun.fromCourse(hits.first.source);
    } else {
      throw Exception('Failed to load course $coursenum');
    }
  }

  Future<List<Lecture>> getLectureVideos(String coursenum) async {
    ElasticSearchQuery courseQuery = ElasticSearchQuery(
      from: 0,
      size: 100,
      query: elastic.Query.bool(
        must: [
          lectureVideoFilter,
          elastic.Query.term("coursenum", [coursenum]),
        ],
      ),
    );

    print("Getting lectures for $coursenum");
    print(courseQuery.toJson());

    final response = await dio.post(
      _searchUrl,
      data: courseQuery.toJson(),
    );

    if (response.statusCode == 200) {
      print("Got lectures response");
      print(response.data);
      final lectureSearch = DocSearch<Lecture>.fromJson(response.data, Lecture.fromJsonModel);
      final lectures = lectureSearch.hits.hits.map((hit) => hit.source).toList();
      
      // Sort the lectures using the custom comparison function
      lectures.sort(compareLectures);
      
      print("Sorted Lectures");
      print(lectures);
      return lectures;
    } else {
      throw Exception('Failed to load course $coursenum');
    }
  }

  Future<List<FullCourseRun>> searchCourses(String searchText) async {
    Map<String, dynamic> courseQuery = searchCourseQuery(searchText);

    print("Searching for $searchText");
    print(courseQuery);

    final response = await dio.post(
      _searchUrl,
      data: courseQuery,
    );

    if (response.statusCode == 200) {
      print("Got search response");
      print(response.data);
      final courseSearch = DocSearch<Course>.fromJson(response.data, Course.fromJsonModel);
      return courseSearch.hits.hits.map((hit) => FullCourseRun.fromCourse(hit.source)).toList();
    } else {
      throw Exception('Failed to load course using search string $searchText');
    }
  }

  Map<String, dynamic> searchCourseQuery(String searchText) {
    return {
      "from": 0,
      "size": 100,
      "query": {
        "bool": {
          "must": [courseFilter],
          "should": [
            {
              "bool": {
                "filter": {
                  "bool": {
                    "must": [
                      {"term": {"object_type": "course"}},
                      {
                        "bool": {
                          "should": [
                            {
                              "multi_match": {
                                "query": searchText,
                                "fields": [
                                  "title.english^3",
                                  "short_description.english^2",
                                  "full_description.english",
                                  "topics",
                                  "platform",
                                  "course_id",
                                  "offered_by",
                                  "department_name",
                                  "course_feature_tags"
                                ]
                              }
                            },
                            {
                              "wildcard": {
                                "coursenum": {
                                  "value": "$searchText*",
                                  "boost": 100
                                }
                              }
                            },
                            {
                              "nested": {
                                "path": "runs",
                                "query": {
                                  "multi_match": {
                                    "query": searchText,
                                    "fields": [
                                      "runs.year",
                                      "runs.semester",
                                      "runs.level",
                                      "runs.instructors^5",
                                      "department_name"
                                    ]
                                  }
                                }
                              }
                            },
                            {
                              "has_child": {
                                "type": "resourcefile",
                                "query": {
                                  "multi_match": {
                                    "query": searchText,
                                    "fields": [
                                      "content",
                                      "title.english^3",
                                      "short_description.english^2",
                                      "department_name",
                                      "resource_type"
                                    ]
                                  }
                                },
                                "score_mode": "avg"
                              }
                            }
                          ]
                        }
                      }
                    ]
                  }
                },
                "should": [
                  {
                    "multi_match": {
                      "query": searchText,
                      "fields": [
                        "title.english^3",
                        "short_description.english^2",
                        "full_description.english",
                        "topics",
                        "platform",
                        "course_id",
                        "offered_by",
                        "department_name",
                        "course_feature_tags"
                      ]
                    }
                  },
                  {
                    "wildcard": {
                      "coursenum": {
                        "value": "$searchText*",
                        "boost": 100
                      }
                    }
                  },
                  {
                    "nested": {
                      "path": "runs",
                      "query": {
                        "multi_match": {
                          "query": searchText,
                          "fields": [
                            "runs.year",
                            "runs.semester",
                            "runs.level",
                            "runs.instructors^5",
                            "department_name"
                          ]
                        }
                      }
                    }
                  },
                  {
                    "has_child": {
                      "type": "resourcefile",
                      "query": {
                        "multi_match": {
                          "query": searchText,
                          "fields": [
                            "content",
                            "title.english^3",
                            "short_description.english^2",
                            "department_name",
                            "resource_type"
                          ]
                        }
                      },
                      "score_mode": "avg"
                    }
                  }
                ]
              }
            }
          ]
        }
      }
    };
  }
  
  late final ElasticSearchQuery allCoursesQuery = ElasticSearchQuery(
    from: 0,
    size: 100,
    query: courseFilter
  );

  final Map<String, dynamic> searchRequest = {
    "from": 0,
    "size": 0,
    "query": {
      "bool": {
        "must": [
          {
            "bool": {
              "should": [
                {
                  "term": {
                    "object_type.keyword": "course"
                  }
                }
              ]
            }
          },
          {
            "bool": {
              "should": [
                {
                  "term": {
                    "offered_by": "OCW"
                  }
                }
              ]
            }
          }
        ]
      }
    },
    "aggs": {
      "audience": {
        "terms": {
          "field": "audience",
          "size": 10000
        }
      },
      "certification": {
        "terms": {
          "field": "certification",
          "size": 10000
        }
      },
      "type": {
        "terms": {
          "field": "object_type.keyword",
          "size": 10000
        }
      },
      "offered_by": {
        "terms": {
          "field": "offered_by",
          "size": 10000
        }
      },
      "topics": {
        "terms": {
          "field": "topics",
          "size": 10000
        }
      },
      "department_name": {
        "terms": {
          "field": "department_name",
          "size": 10000
        }
      },
      "level": {
        "nested": {
          "path": "runs"
        },
        "aggs": {
          "level": {
            "terms": {
              "field": "runs.level",
              "size": 10000
            }
          }
        }
      },
      "course_feature_tags": {
        "terms": {
          "field": "course_feature_tags",
          "size": 10000
        }
      },
      "resource_type": {
        "terms": {
          "field": "resource_type",
          "size": 10000
        }
      }
    }
  };
}

int compareLectures(Lecture a, Lecture b) {
  // Step 1: Extract lecture numbers
  final numA = extractLectureNumber(a.title);
  final numB = extractLectureNumber(b.title);
  if (numA != null && numB != null) {
    return numA.compareTo(numB);
  }

  // Step 2: Fall back to alphabetical sorting
  return a.title.compareTo(b.title);
}

int? extractLectureNumber(String title) {
  final patterns = [
    RegExp(r'^Lecture (\d+)', caseSensitive: false),
    RegExp(r'^(\d+)\.\s', caseSensitive: false),
    RegExp(r'Lec[.\s-]*(\d+)', caseSensitive: false),
  ];

  for (final pattern in patterns) {
    final match = pattern.firstMatch(title);
    if (match != null) {
      return int.tryParse(match.group(1)!);
    }
  }

  return null;
}
