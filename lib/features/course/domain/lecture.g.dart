// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lecture.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Lecture _$LectureFromJson(Map<String, dynamic> json) => Lecture(
      runId: json['run_id'] as String,
      runTitle: json['run_title'] as String,
      runSlug: json['run_slug'] as String,
      runDepartmentSlug: json['run_department_slug'] as String,
      semester: $enumDecode(_$SemesterEnumMap, json['semester']),
      year: (json['year'] as num).toInt(),
      topics:
          (json['topics'] as List<dynamic>).map((e) => e as String).toList(),
      key: json['key'] as String,
      uid: json['uid'],
      resourceRelations: ResourceRelations.fromJson(
          json['resource_relations'] as Map<String, dynamic>),
      title: json['title'] as String,
      shortDescription: json['short_description'] as String?,
      url: json['url'] as String,
      shortUrl: json['short_url'],
      section: json['section'],
      sectionSlug: json['section_slug'],
      fileType: $enumDecodeNullable(_$FileTypeEnumMap, json['file_type']),
      contentType: $enumDecode(_$ContentTypeEnumMap, json['content_type']),
      content: json['content'] as String,
      contentTitle: json['content_title'] as String,
      contentAuthor: json['content_author'],
      contentLanguage: json['content_language'],
      courseId: json['course_id'] as String,
      coursenum: json['coursenum'] as String,
      imageSrc: json['image_src'] as String?,
      resourceType: (json['resource_type'] as List<dynamic>)
          .map((e) => $enumDecode(_$CourseFeatureTagEnumMap, e))
          .toList(),
      objectType: $enumDecode(_$ObjectTypeEnumMap, json['object_type']),
    );

Map<String, dynamic> _$LectureToJson(Lecture instance) => <String, dynamic>{
      'run_id': instance.runId,
      'run_title': instance.runTitle,
      'run_slug': instance.runSlug,
      'run_department_slug': instance.runDepartmentSlug,
      'semester': _$SemesterEnumMap[instance.semester]!,
      'year': instance.year,
      'topics': instance.topics,
      'key': instance.key,
      'uid': instance.uid,
      'resource_relations': instance.resourceRelations,
      'title': instance.title,
      'short_description': instance.shortDescription,
      'url': instance.url,
      'short_url': instance.shortUrl,
      'section': instance.section,
      'section_slug': instance.sectionSlug,
      'file_type': _$FileTypeEnumMap[instance.fileType],
      'content_type': _$ContentTypeEnumMap[instance.contentType]!,
      'content': instance.content,
      'content_title': instance.contentTitle,
      'content_author': instance.contentAuthor,
      'content_language': instance.contentLanguage,
      'course_id': instance.courseId,
      'coursenum': instance.coursenum,
      'image_src': instance.imageSrc,
      'resource_type': instance.resourceType
          .map((e) => _$CourseFeatureTagEnumMap[e]!)
          .toList(),
      'object_type': _$ObjectTypeEnumMap[instance.objectType]!,
    };

const _$SemesterEnumMap = {
  Semester.FALL: 'Fall',
  Semester.JANUARY_IAP: 'January IAP',
  Semester.SPRING: 'Spring',
  Semester.SUMMER: 'Summer',
};

const _$FileTypeEnumMap = {
  FileType.EMPTY: '',
  FileType.VIDEO_MP4: 'video/mp4',
};

const _$ContentTypeEnumMap = {
  ContentType.VIDEO: 'video',
};

const _$CourseFeatureTagEnumMap = {
  CourseFeatureTag.ACTIVITY_ASSIGNMENTS: 'Activity Assignments',
  CourseFeatureTag.ACTIVITY_ASSIGNMENTS_WITH_EXAMPLES:
      'Activity Assignments with Examples',
  CourseFeatureTag.COURSE_INTRODUCTION: 'Course Introduction',
  CourseFeatureTag.DEMONSTRATION_AUDIO: 'Demonstration Audio',
  CourseFeatureTag.DEMONSTRATION_VIDEOS: 'Demonstration Videos',
  CourseFeatureTag.DESIGN_ASSIGNMENTS: 'Design Assignments',
  CourseFeatureTag.DESIGN_ASSIGNMENTS_WITH_EXAMPLES:
      'Design Assignments with Examples',
  CourseFeatureTag.EXAMS: 'Exams',
  CourseFeatureTag.EXAMS_WITH_SOLUTIONS: 'Exams with Solutions',
  CourseFeatureTag.EXAM_MATERIALS: 'Exam Materials',
  CourseFeatureTag.IMAGE_GALLERY: 'Image Gallery',
  CourseFeatureTag.INSTRUCTOR_INSIGHTS: 'Instructor Insights',
  CourseFeatureTag.LABS: 'Labs',
  CourseFeatureTag.LECTURE_AUDIO: 'Lecture Audio',
  CourseFeatureTag.LECTURE_NOTES: 'Lecture Notes',
  CourseFeatureTag.LECTURE_VIDEOS: 'Lecture Videos',
  CourseFeatureTag.MEDIA_ASSIGNMENTS: 'Media Assignments',
  CourseFeatureTag.MEDIA_ASSIGNMENTS_WITH_EXAMPLES:
      'Media Assignments with Examples',
  CourseFeatureTag.MUSIC: 'Music',
  CourseFeatureTag.ONLINE_TEXTBOOK: 'Online Textbook',
  CourseFeatureTag.OTHER_AUDIO: 'Other Audio',
  CourseFeatureTag.OTHER_VIDEO: 'Other Video',
  CourseFeatureTag.PRESENTATION_ASSIGNMENTS: 'Presentation Assignments',
  CourseFeatureTag.PRESENTATION_ASSIGNMENTS_WITH_EXAMPLES:
      'Presentation Assignments with Examples',
  CourseFeatureTag.PROBLEM_SETS: 'Problem Sets',
  CourseFeatureTag.PROBLEM_SETS_WITH_SOLUTIONS: 'Problem Sets with Solutions',
  CourseFeatureTag.PROGRAMMING_ASSIGNMENTS: 'Programming Assignments',
  CourseFeatureTag.PROGRAMMING_ASSIGNMENTS_WITH_EXAMPLES:
      'Programming Assignments with Examples',
  CourseFeatureTag.PROJECTS: 'Projects',
  CourseFeatureTag.PROJECTS_WITH_EXAMPLES: 'Projects with Examples',
  CourseFeatureTag.READINGS: 'Readings',
  CourseFeatureTag.RECITATION_VIDEOS: 'Recitation Videos',
  CourseFeatureTag.SIMULATIONS: 'Simulations',
  CourseFeatureTag.SIMULATION_VIDEOS: 'Simulation Videos',
  CourseFeatureTag.TOOLS: 'Tools',
  CourseFeatureTag.TUTORIAL_VIDEOS: 'Tutorial Videos',
  CourseFeatureTag.VIDEOS: 'Videos',
  CourseFeatureTag.VIDEO_MATERIALS: 'Video Materials',
  CourseFeatureTag.WORKSHOP_VIDEOS: 'Workshop Videos',
  CourseFeatureTag.WRITTEN_ASSIGNMENTS: 'Written Assignments',
  CourseFeatureTag.WRITTEN_ASSIGNMENTS_WITH_EXAMPLES:
      'Written Assignments with Examples',
};

const _$ObjectTypeEnumMap = {
  ObjectType.COURSE: 'course',
  ObjectType.RESOURCEFILE: 'resourcefile',
};

ResourceRelations _$ResourceRelationsFromJson(Map<String, dynamic> json) =>
    ResourceRelations(
      name: $enumDecode(_$ObjectTypeEnumMap, json['name']),
      parent: json['parent'] as String,
    );

Map<String, dynamic> _$ResourceRelationsToJson(ResourceRelations instance) =>
    <String, dynamic>{
      'name': _$ObjectTypeEnumMap[instance.name]!,
      'parent': instance.parent,
    };

LectureFile _$LectureFileFromJson(Map<String, dynamic> json) => LectureFile(
      title: json['title'] as String,
      description: json['description'] as String,
      file: json['file'],
      learningResourceTypes: (json['learning_resource_types'] as List<dynamic>)
          .map((e) => $enumDecode(_$CourseFeatureTagEnumMap, e))
          .toList(),
      resourceType: json['resource_type'] as String,
      fileType: json['file_type'] as String,
      youtubeKey: json['youtube_key'] as String,
      captionsFile: json['captions_file'] as String,
      transcriptFile: json['transcript_file'] as String,
      thumbnailFile: json['thumbnail_file'] as String,
      archiveUrl: json['archive_url'] as String,
    );

Map<String, dynamic> _$LectureFileToJson(LectureFile instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'file': instance.file,
      'learning_resource_types': instance.learningResourceTypes
          .map((e) => _$CourseFeatureTagEnumMap[e]!)
          .toList(),
      'resource_type': instance.resourceType,
      'file_type': instance.fileType,
      'youtube_key': instance.youtubeKey,
      'captions_file': instance.captionsFile,
      'transcript_file': instance.transcriptFile,
      'thumbnail_file': instance.thumbnailFile,
      'archive_url': instance.archiveUrl,
    };
