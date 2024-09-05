// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'elastic_search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ElasticSearchQuery _$ElasticSearchQueryFromJson(Map<String, dynamic> json) =>
    ElasticSearchQuery(
      index: json['index'] as String?,
      type: json['type'] as String?,
      query: json['query'] as Map<String, dynamic>? ?? const {"match_all": {}},
      fields:
          (json['fields'] as List<dynamic>?)?.map((e) => e as Object).toList(),
      source: json['source'],
      suggest: json['suggest'] as Map<String, dynamic>?,
      sort: (json['sort'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
      aggregations: json['aggregations'] as Map<String, dynamic>?,
      scroll: json['scroll'] == null
          ? null
          : Duration(microseconds: (json['scroll'] as num).toInt()),
      trackTotalHits: json['track_total_hits'] as bool?,
      from: (json['from'] as num?)?.toInt(),
      size: (json['size'] as num?)?.toInt(),
      minScore: (json['minScore'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ElasticSearchQueryToJson(ElasticSearchQuery instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('index', instance.index);
  writeNotNull('type', instance.type);
  val['query'] = instance.query;
  writeNotNull('fields', instance.fields);
  writeNotNull('source', instance.source);
  writeNotNull('suggest', instance.suggest);
  writeNotNull('sort', instance.sort);
  writeNotNull('aggregations', instance.aggregations);
  writeNotNull('scroll', instance.scroll?.inMicroseconds);
  writeNotNull('track_total_hits', instance.trackTotalHits);
  writeNotNull('from', instance.from);
  writeNotNull('size', instance.size);
  writeNotNull('minScore', instance.minScore);
  return val;
}
