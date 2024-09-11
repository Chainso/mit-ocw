import 'package:json_annotation/json_annotation.dart';

part "library.g.dart";

@JsonSerializable()
class Library {
  List<int> courses;

  Library({
    required this.courses
  });

  factory Library.fromJson(Map<String, dynamic> json) => _$LibraryFromJson(json);

  Map<String, dynamic> toJson() => _$LibraryToJson(this);
}
