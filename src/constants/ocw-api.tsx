const OCWApi = {
  URL: 'https://ocw.mit.edu',
  API_URL: 'https://open.mit.edu',
  SEARCH: {
    URL: '/api/v0/search/',
    METHOD: 'POST',
    BODY: {
      "from": 0,
      "size": 10,
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
    }
  }
}

export default OCWApi;
