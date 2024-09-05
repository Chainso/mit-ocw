import 'package:json_annotation/json_annotation.dart';
import 'package:mit_ocw/features/course/domain/course.dart';

part "lecture.g.dart";

@JsonSerializable()
class Lecture {
    @JsonKey(name: "run_id")
    String runId;
    @JsonKey(name: "run_title")
    String runTitle;
    @JsonKey(name: "run_slug")
    String runSlug;
    @JsonKey(name: "run_department_slug")
    String runDepartmentSlug;
    @JsonKey(name: "semester")
    Semester semester;
    @JsonKey(name: "year")
    int year;
    @JsonKey(name: "topics")
    List<String> topics;
    @JsonKey(name: "key")
    String key;
    @JsonKey(name: "uid")
    dynamic uid;
    @JsonKey(name: "resource_relations")
    ResourceRelations resourceRelations;
    @JsonKey(name: "title")
    String title;
    @JsonKey(name: "short_description")
    String? shortDescription;
    @JsonKey(name: "url")
    String url;
    @JsonKey(name: "short_url")
    dynamic shortUrl;
    @JsonKey(name: "section")
    dynamic section;
    @JsonKey(name: "section_slug")
    dynamic sectionSlug;
    @JsonKey(name: "file_type")
    FileType? fileType;
    @JsonKey(name: "content_type")
    ContentType contentType;
    @JsonKey(name: "content")
    String content;
    @JsonKey(name: "content_title")
    String contentTitle;
    @JsonKey(name: "content_author")
    dynamic contentAuthor;
    @JsonKey(name: "content_language")
    dynamic contentLanguage;
    @JsonKey(name: "course_id")
    String courseId;
    @JsonKey(name: "coursenum")
    String coursenum;
    @JsonKey(name: "image_src")
    String? imageSrc;
    @JsonKey(name: "resource_type")
    List<CourseFeatureTag> resourceType;
    @JsonKey(name: "object_type")
    ObjectType objectType;

    Lecture({
        required this.runId,
        required this.runTitle,
        required this.runSlug,
        required this.runDepartmentSlug,
        required this.semester,
        required this.year,
        required this.topics,
        required this.key,
        required this.uid,
        required this.resourceRelations,
        required this.title,
        required this.shortDescription,
        required this.url,
        required this.shortUrl,
        required this.section,
        required this.sectionSlug,
        required this.fileType,
        required this.contentType,
        required this.content,
        required this.contentTitle,
        required this.contentAuthor,
        required this.contentLanguage,
        required this.courseId,
        required this.coursenum,
        required this.imageSrc,
        required this.resourceType,
        required this.objectType,
    });

    factory Lecture.fromJson(Map<String, dynamic> json) => _$LectureFromJson(json);
    factory Lecture.fromJsonModel(Object? json) => _$LectureFromJson(json as Map<String, dynamic>);

    Map<String, dynamic> toJson() => _$LectureToJson(this);
}

enum ContentType {
    @JsonValue("video")
    VIDEO
}

enum FileType {
    @JsonValue("")
    EMPTY,
    @JsonValue("video/mp4")
    VIDEO_MP4
}

@JsonSerializable()
class ResourceRelations {
    @JsonKey(name: "name")
    ObjectType name;
    @JsonKey(name: "parent")
    String parent;

    ResourceRelations({
        required this.name,
        required this.parent,
    });

    factory ResourceRelations.fromJson(Map<String, dynamic> json) => _$ResourceRelationsFromJson(json);

    Map<String, dynamic> toJson() => _$ResourceRelationsToJson(this);
}

@JsonSerializable()
class LectureFile {
    @JsonKey(name: "title")
    String title;
    @JsonKey(name: "description")
    String description;
    @JsonKey(name: "file")
    dynamic file;
    @JsonKey(name: "learning_resource_types")
    List<CourseFeatureTag> learningResourceTypes;
    @JsonKey(name: "resource_type")
    String resourceType;
    @JsonKey(name: "file_type")
    String fileType;
    @JsonKey(name: "youtube_key")
    String youtubeKey;
    @JsonKey(name: "captions_file")
    String captionsFile;
    @JsonKey(name: "transcript_file")
    String transcriptFile;
    @JsonKey(name: "thumbnail_file")
    String thumbnailFile;
    @JsonKey(name: "archive_url")
    String archiveUrl;

    LectureFile({
        required this.title,
        required this.description,
        required this.file,
        required this.learningResourceTypes,
        required this.resourceType,
        required this.fileType,
        required this.youtubeKey,
        required this.captionsFile,
        required this.transcriptFile,
        required this.thumbnailFile,
        required this.archiveUrl,
    });

    factory LectureFile.fromJson(Map<String, dynamic> json) => _$LectureFileFromJson(json);

    Map<String, dynamic> toJson() => _$LectureFileToJson(this);
}
