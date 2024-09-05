import 'package:json_annotation/json_annotation.dart';

part "elastic_search.g.dart";

@JsonSerializable()
class ElasticSearchQuery {
  @JsonKey(name: "index", includeIfNull: false)
  String? index;
  @JsonKey(name: "type", includeIfNull: false)
  String? type;
  @JsonKey(name: "query")
  Map query;
  @JsonKey(name: "fields", includeIfNull: false)
  List<Object>? fields;
  @JsonKey(name: "source", includeIfNull: false)
  dynamic source;
  @JsonKey(name: "suggest", includeIfNull: false)
  Map? suggest;
  @JsonKey(name: "sort", includeIfNull: false)
  List<Map>? sort;
  @JsonKey(name: "aggregations", includeIfNull: false)
  Map? aggregations;
  @JsonKey(name: "scroll", includeIfNull: false)
  Duration? scroll;
  @JsonKey(name: "track_total_hits", includeIfNull: false)
  bool? trackTotalHits;
  @JsonKey(name: "from", includeIfNull: false)
  int? from;
  @JsonKey(name: "size", includeIfNull: false)
  int? size;
  @JsonKey(name: "minScore", includeIfNull: false)
  double? minScore;

  ElasticSearchQuery({
    this.index,
    this.type,
    this.query = const {"match_all": {}},
    this.fields,
    this.source,
    this.suggest,
    this.sort,
    this.aggregations,
    this.scroll,
    this.trackTotalHits,
    this.from,
    this.size,
    this.minScore,
  });

  factory ElasticSearchQuery.fromJson(Map<String, dynamic> json) =>
      _$ElasticSearchQueryFromJson(json);

  Map<String, dynamic> toJson() => _$ElasticSearchQueryToJson(this);
}
