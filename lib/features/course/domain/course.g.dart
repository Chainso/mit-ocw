// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocSearch<T> _$DocSearchFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    DocSearch<T>(
      took: (json['took'] as num).toInt(),
      timedOut: json['timed_out'] as bool,
      shards: Shards.fromJson(json['_shards'] as Map<String, dynamic>),
      hits: Hits<T>.fromJson(
          json['hits'] as Map<String, dynamic>, (value) => fromJsonT(value)),
      suggest: json['suggest'] as List<dynamic>,
    );

Map<String, dynamic> _$DocSearchToJson<T>(
  DocSearch<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'took': instance.took,
      'timed_out': instance.timedOut,
      '_shards': instance.shards,
      'hits': instance.hits.toJson(
        (value) => toJsonT(value),
      ),
      'suggest': instance.suggest,
    };

AggregationSearch<T> _$AggregationSearchFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    AggregationSearch<T>(
      took: (json['took'] as num).toInt(),
      timedOut: json['timed_out'] as bool,
      shards: Shards.fromJson(json['_shards'] as Map<String, dynamic>),
      aggregations: fromJsonT(json['aggregations']),
      suggest: json['suggest'] as List<dynamic>,
    );

Map<String, dynamic> _$AggregationSearchToJson<T>(
  AggregationSearch<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'took': instance.took,
      'timed_out': instance.timedOut,
      '_shards': instance.shards,
      'aggregations': toJsonT(instance.aggregations),
      'suggest': instance.suggest,
    };

CourseAggregations _$CourseAggregationsFromJson(Map<String, dynamic> json) =>
    CourseAggregations(
      type: AudienceClass.fromJson(json['type'] as Map<String, dynamic>),
      topics: AudienceClass.fromJson(json['topics'] as Map<String, dynamic>),
      offeredBy:
          AudienceClass.fromJson(json['offered_by'] as Map<String, dynamic>),
      audience:
          AudienceClass.fromJson(json['audience'] as Map<String, dynamic>),
      certification:
          AudienceClass.fromJson(json['certification'] as Map<String, dynamic>),
      departmentName: AudienceClass.fromJson(
          json['department_name'] as Map<String, dynamic>),
      level: LevelClass.fromJson(json['level'] as Map<String, dynamic>),
      courseFeatureTags: AudienceClass.fromJson(
          json['course_feature_tags'] as Map<String, dynamic>),
      resourceType:
          AudienceClass.fromJson(json['resource_type'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CourseAggregationsToJson(CourseAggregations instance) =>
    <String, dynamic>{
      'type': instance.type,
      'topics': instance.topics,
      'offered_by': instance.offeredBy,
      'audience': instance.audience,
      'certification': instance.certification,
      'department_name': instance.departmentName,
      'level': instance.level,
      'course_feature_tags': instance.courseFeatureTags,
      'resource_type': instance.resourceType,
    };

AudienceClass _$AudienceClassFromJson(Map<String, dynamic> json) =>
    AudienceClass(
      docCountErrorUpperBound:
          (json['doc_count_error_upper_bound'] as num).toInt(),
      sumOtherDocCount: (json['sum_other_doc_count'] as num).toInt(),
      buckets: (json['buckets'] as List<dynamic>)
          .map((e) => Bucket.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AudienceClassToJson(AudienceClass instance) =>
    <String, dynamic>{
      'doc_count_error_upper_bound': instance.docCountErrorUpperBound,
      'sum_other_doc_count': instance.sumOtherDocCount,
      'buckets': instance.buckets,
    };

Bucket _$BucketFromJson(Map<String, dynamic> json) => Bucket(
      key: json['key'] as String,
      docCount: (json['doc_count'] as num).toInt(),
    );

Map<String, dynamic> _$BucketToJson(Bucket instance) => <String, dynamic>{
      'key': instance.key,
      'doc_count': instance.docCount,
    };

LevelClass _$LevelClassFromJson(Map<String, dynamic> json) => LevelClass(
      buckets: (json['buckets'] as List<dynamic>)
          .map((e) => Bucket.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LevelClassToJson(LevelClass instance) =>
    <String, dynamic>{
      'buckets': instance.buckets,
    };

Hits<T> _$HitsFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    Hits<T>(
      total: (json['total'] as num).toInt(),
      maxScore: (json['max_score'] as num?)?.toDouble(),
      hits: (json['hits'] as List<dynamic>)
          .map((e) => Hit<T>.fromJson(
              e as Map<String, dynamic>, (value) => fromJsonT(value)))
          .toList(),
    );

Map<String, dynamic> _$HitsToJson<T>(
  Hits<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'total': instance.total,
      'max_score': instance.maxScore,
      'hits': instance.hits
          .map((e) => e.toJson(
                (value) => toJsonT(value),
              ))
          .toList(),
    };

Hit<T> _$HitFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    Hit<T>(
      index: json['_index'] as String,
      type: $enumDecode(_$TypeEnumMap, json['_type']),
      id: json['_id'] as String,
      score: (json['_score'] as num).toDouble(),
      source: fromJsonT(json['_source']),
    );

Map<String, dynamic> _$HitToJson<T>(
  Hit<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      '_index': instance.index,
      '_type': _$TypeEnumMap[instance.type]!,
      '_id': instance.id,
      '_score': instance.score,
      '_source': toJsonT(instance.source),
    };

const _$TypeEnumMap = {
  Type.DOC: '_doc',
};

FullCourseRun _$FullCourseRunFromJson(Map<String, dynamic> json) =>
    FullCourseRun(
      course: Course.fromJson(json['course'] as Map<String, dynamic>),
      run: Run.fromJson(json['run'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FullCourseRunToJson(FullCourseRun instance) =>
    <String, dynamic>{
      'course': instance.course,
      'run': instance.run,
    };

Course _$CourseFromJson(Map<String, dynamic> json) => Course(
      id: (json['id'] as num).toInt(),
      courseId: json['course_id'] as String,
      coursenum: json['coursenum'] as String,
      shortDescription: json['short_description'] as String,
      fullDescription: json['full_description'] as String?,
      platform: $enumDecode(_$PlatformEnumMap, json['platform']),
      title: json['title'] as String,
      imageSrc: json['image_src'] as String,
      topics:
          (json['topics'] as List<dynamic>).map((e) => e as String).toList(),
      published: json['published'] as bool,
      offeredBy: (json['offered_by'] as List<dynamic>)
          .map((e) => $enumDecode(_$OfferedByEnumMap, e))
          .toList(),
      runs: (json['runs'] as List<dynamic>)
          .map((e) => Run.fromJson(e as Map<String, dynamic>))
          .toList(),
      created: DateTime.parse(json['created'] as String),
      defaultSearchPriority:
          (json['default_search_priority'] as num).toDouble(),
      minimumPrice: json['minimum_price'] as String,
      audience: (json['audience'] as List<dynamic>)
          .map((e) => $enumDecode(_$AudienceElementEnumMap, e))
          .toList(),
      certification: json['certification'] as List<dynamic>,
      departmentName: (json['department_name'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      departmentSlug: json['department_slug'] as String?,
      courseFeatureTags: (json['course_feature_tags'] as List<dynamic>)
          .map((e) => $enumDecode(_$CourseFeatureTagEnumMap, e))
          .toList(),
      departmentCourseNumbers: (json['department_course_numbers']
              as List<dynamic>)
          .map(
              (e) => DepartmentCourseNumber.fromJson(e as Map<String, dynamic>))
          .toList(),
      objectType: $enumDecode(_$ObjectTypeEnumMap, json['object_type']),
      resourceRelations: ResourceRelations.fromJson(
          json['resource_relations'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CourseToJson(Course instance) => <String, dynamic>{
      'id': instance.id,
      'course_id': instance.courseId,
      'coursenum': instance.coursenum,
      'short_description': instance.shortDescription,
      'full_description': instance.fullDescription,
      'platform': _$PlatformEnumMap[instance.platform]!,
      'title': instance.title,
      'image_src': instance.imageSrc,
      'topics': instance.topics,
      'published': instance.published,
      'offered_by':
          instance.offeredBy.map((e) => _$OfferedByEnumMap[e]!).toList(),
      'runs': instance.runs,
      'created': instance.created.toIso8601String(),
      'default_search_priority': instance.defaultSearchPriority,
      'minimum_price': instance.minimumPrice,
      'audience':
          instance.audience.map((e) => _$AudienceElementEnumMap[e]!).toList(),
      'certification': instance.certification,
      'department_name': instance.departmentName,
      'department_slug': instance.departmentSlug,
      'course_feature_tags': instance.courseFeatureTags
          .map((e) => _$CourseFeatureTagEnumMap[e]!)
          .toList(),
      'department_course_numbers': instance.departmentCourseNumbers,
      'object_type': _$ObjectTypeEnumMap[instance.objectType]!,
      'resource_relations': instance.resourceRelations,
    };

const _$PlatformEnumMap = {
  Platform.OCW: 'ocw',
};

const _$OfferedByEnumMap = {
  OfferedBy.OCW: 'OCW',
};

const _$AudienceElementEnumMap = {
  AudienceElement.OPEN_CONTENT: 'Open Content',
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
  CourseFeatureTag.MULTIPLE_ASSIGNMENT_TYPES: 'Multiple Assignment Types',
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

DepartmentCourseNumber _$DepartmentCourseNumberFromJson(
        Map<String, dynamic> json) =>
    DepartmentCourseNumber(
      coursenum: json['coursenum'] as String,
      department: json['department'] as String?,
      primary: json['primary'] as bool,
      sortCoursenum: json['sort_coursenum'] as String,
    );

Map<String, dynamic> _$DepartmentCourseNumberToJson(
        DepartmentCourseNumber instance) =>
    <String, dynamic>{
      'coursenum': instance.coursenum,
      'department': instance.department,
      'primary': instance.primary,
      'sort_coursenum': instance.sortCoursenum,
    };

ResourceRelations _$ResourceRelationsFromJson(Map<String, dynamic> json) =>
    ResourceRelations(
      name: $enumDecode(_$NameEnumMap, json['name']),
    );

Map<String, dynamic> _$ResourceRelationsToJson(ResourceRelations instance) =>
    <String, dynamic>{
      'name': _$NameEnumMap[instance.name]!,
    };

const _$NameEnumMap = {
  Name.RESOURCE: 'resource',
};

Run _$RunFromJson(Map<String, dynamic> json) => Run(
      id: (json['id'] as num).toInt(),
      runId: json['run_id'] as String,
      shortDescription: json['short_description'] as String,
      fullDescription: json['full_description'] as String?,
      language: json['language'],
      semester: $enumDecode(_$SemesterEnumMap, json['semester']),
      year: (json['year'] as num).toInt(),
      level: (json['level'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$LevelElementEnumMap, e))
          .toList(),
      startDate: json['start_date'],
      endDate: json['end_date'],
      enrollmentStart: json['enrollment_start'],
      enrollmentEnd: json['enrollment_end'],
      bestStartDate: DateTime.parse(json['best_start_date'] as String),
      bestEndDate: DateTime.parse(json['best_end_date'] as String),
      title: json['title'] as String,
      imageSrc: json['image_src'] as String,
      prices: (json['prices'] as List<dynamic>)
          .map((e) => Price.fromJson(e as Map<String, dynamic>))
          .toList(),
      instructors: (json['instructors'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      published: json['published'] as bool,
      availability: $enumDecode(_$AvailabilityEnumMap, json['availability']),
      offeredBy: (json['offered_by'] as List<dynamic>)
          .map((e) => $enumDecode(_$OfferedByEnumMap, e))
          .toList(),
      slug: json['slug'] as String,
    );

Map<String, dynamic> _$RunToJson(Run instance) => <String, dynamic>{
      'id': instance.id,
      'run_id': instance.runId,
      'short_description': instance.shortDescription,
      'full_description': instance.fullDescription,
      'language': instance.language,
      'semester': _$SemesterEnumMap[instance.semester]!,
      'year': instance.year,
      'level': instance.level?.map((e) => _$LevelElementEnumMap[e]!).toList(),
      'start_date': instance.startDate,
      'end_date': instance.endDate,
      'enrollment_start': instance.enrollmentStart,
      'enrollment_end': instance.enrollmentEnd,
      'best_start_date': instance.bestStartDate.toIso8601String(),
      'best_end_date': instance.bestEndDate.toIso8601String(),
      'title': instance.title,
      'image_src': instance.imageSrc,
      'prices': instance.prices,
      'instructors': instance.instructors,
      'published': instance.published,
      'availability': _$AvailabilityEnumMap[instance.availability]!,
      'offered_by':
          instance.offeredBy.map((e) => _$OfferedByEnumMap[e]!).toList(),
      'slug': instance.slug,
    };

const _$SemesterEnumMap = {
  Semester.FALL: 'Fall',
  Semester.JANUARY_IAP: 'January IAP',
  Semester.SPRING: 'Spring',
  Semester.SUMMER: 'Summer',
};

const _$LevelElementEnumMap = {
  LevelElement.GRADUATE: 'Graduate',
  LevelElement.HIGH_SCHOOL: 'High School',
  LevelElement.NON_CREDIT: 'Non-Credit',
  LevelElement.UNDERGRADUATE: 'Undergraduate',
};

const _$AvailabilityEnumMap = {
  Availability.CURRENT: 'Current',
};

Price _$PriceFromJson(Map<String, dynamic> json) => Price(
      price: json['price'] as String,
      mode: $enumDecode(_$ModeEnumMap, json['mode']),
    );

Map<String, dynamic> _$PriceToJson(Price instance) => <String, dynamic>{
      'price': instance.price,
      'mode': _$ModeEnumMap[instance.mode]!,
    };

const _$ModeEnumMap = {
  Mode.AUDIT: 'audit',
};

Shards _$ShardsFromJson(Map<String, dynamic> json) => Shards(
      total: (json['total'] as num).toInt(),
      successful: (json['successful'] as num).toInt(),
      skipped: (json['skipped'] as num).toInt(),
      failed: (json['failed'] as num).toInt(),
    );

Map<String, dynamic> _$ShardsToJson(Shards instance) => <String, dynamic>{
      'total': instance.total,
      'successful': instance.successful,
      'skipped': instance.skipped,
      'failed': instance.failed,
    };
