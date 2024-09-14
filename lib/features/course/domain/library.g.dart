// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'library.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Library _$LibraryFromJson(Map<String, dynamic> json) => Library(
      courses:
          (json['courses'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$LibraryToJson(Library instance) => <String, dynamic>{
      'courses': instance.courses,
    };
