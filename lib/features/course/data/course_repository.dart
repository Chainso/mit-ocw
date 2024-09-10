import 'package:elastic_client/elastic_client.dart' as elastic;
import 'package:mit_ocw/config/ocw_config.dart';
import 'package:mit_ocw/features/course/domain/course.dart';

import 'package:dio/dio.dart';
import 'package:mit_ocw/features/course/domain/lecture.dart';
import 'package:mit_ocw/util/elastic_search.dart';

class CourseRepository {
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

  Future<List<FullCourseRun>> getCourses() async {
    print("Getting courses");
    print(_searchUrl);
    print(allCoursesQuery.toJson());

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

  Future<Course?> getCourse(String coursenum) async {
    ElasticSearchQuery courseQuery = ElasticSearchQuery(
      from: 0,
      size: 10,
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
      print("Course hits");
      print(hits);
      return hits.firstOrNull?.source;
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
    "size": 1000,
    "post_filter": {
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
    "query": {
      "bool": {
        "should": [
          {
            "bool": {
              "filter": {
                "bool": {
                  "must": [
                    {
                      "term": {
                        "object_type": "course"
                      }
                    }
                  ]
                }
              }
            }
          }
        ]
      }
    },
    "aggs": {
      "agg_filter_audience": {
        "filter": {
          "bool": {
            "should": [
              {
                "bool": {
                  "filter": {
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
                  }
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
          }
        }
      },
      "agg_filter_certification": {
        "filter": {
          "bool": {
            "should": [
              {
                "bool": {
                  "filter": {
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
                  }
                }
              }
            ]
          }
        },
        "aggs": {
          "certification": {
            "terms": {
              "field": "certification",
              "size": 10000
            }
          }
        }
      },
      "agg_filter_type": {
        "filter": {
          "bool": {
            "should": [
              {
                "bool": {
                  "filter": {
                    "bool": {
                      "must": [
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
                  }
                }
              }
            ]
          }
        },
        "aggs": {
          "type": {
            "terms": {
              "field": "object_type.keyword",
              "size": 10000
            }
          }
        }
      },
      "agg_filter_offered_by": {
        "filter": {
          "bool": {
            "should": [
              {
                "bool": {
                  "filter": {
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
                        }
                      ]
                    }
                  }
                }
              }
            ]
          }
        },
        "aggs": {
          "offered_by": {
            "terms": {
              "field": "offered_by",
              "size": 10000
            }
          }
        }
      },
      "agg_filter_topics": {
        "filter": {
          "bool": {
            "should": [
              {
                "bool": {
                  "filter": {
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
                  }
                }
              }
            ]
          }
        },
        "aggs": {
          "topics": {
            "terms": {
              "field": "topics",
              "size": 10000
            }
          }
        }
      },
      "agg_filter_department_name": {
        "filter": {
          "bool": {
            "should": [
              {
                "bool": {
                  "filter": {
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
                  }
                }
              }
            ]
          }
        },
        "aggs": {
          "department_name": {
            "terms": {
              "field": "department_name",
              "size": 10000
            }
          }
        }
      },
      "agg_filter_level": {
        "filter": {
          "bool": {
            "should": [
              {
                "bool": {
                  "filter": {
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
                  }
                }
              }
            ]
          }
        },
        "aggs": {
          "level": {
            "nested": {
              "path": "runs"
            },
            "aggs": {
              "level": {
                "terms": {
                  "field": "runs.level",
                  "size": 10000
                },
                "aggs": {
                  "courses": {
                    "reverse_nested": {}
                  }
                }
              }
            }
          }
        }
      },
      "agg_filter_course_feature_tags": {
        "filter": {
          "bool": {
            "should": [
              {
                "bool": {
                  "filter": {
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
                  }
                }
              }
            ]
          }
        },
        "aggs": {
          "course_feature_tags": {
            "terms": {
              "field": "course_feature_tags",
              "size": 10000
            }
          }
        }
      },
      "agg_filter_resource_type": {
        "filter": {
          "bool": {
            "should": [
              {
                "bool": {
                  "filter": {
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
                  }
                }
              }
            ]
          }
        },
        "aggs": {
          "resource_type": {
            "terms": {
              "field": "resource_type",
              "size": 10000
            }
          }
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
