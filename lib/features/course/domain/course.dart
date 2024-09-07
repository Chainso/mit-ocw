import 'package:json_annotation/json_annotation.dart';

part "course.g.dart";

@JsonSerializable(genericArgumentFactories: true)
class DocSearch<T> {
    @JsonKey(name: "took")
    int took;
    @JsonKey(name: "timed_out")
    bool timedOut;
    @JsonKey(name: "_shards")
    Shards shards;
    @JsonKey(name: "hits")
    Hits<T> hits;
    @JsonKey(name: "suggest")
    List<dynamic> suggest;

    DocSearch({
        required this.took,
        required this.timedOut,
        required this.shards,
        required this.hits,
        required this.suggest,
    });

    factory DocSearch.fromJson(
        Map<String, dynamic> json,
        T Function(Object? json) fromJsonT,
    ) => _$DocSearchFromJson(json, fromJsonT);

    Map<String, dynamic> toJson(Object Function(T) toJsonT) => _$DocSearchToJson(this, toJsonT);
}

@JsonSerializable(genericArgumentFactories: true)
class AggregationSearch<T> {
    @JsonKey(name: "took")
    int took;
    @JsonKey(name: "timed_out")
    bool timedOut;
    @JsonKey(name: "_shards")
    Shards shards;
    @JsonKey(name: "aggregations")
    T aggregations;
    @JsonKey(name: "suggest")
    List<dynamic> suggest;

    AggregationSearch({
        required this.took,
        required this.timedOut,
        required this.shards,
        required this.aggregations,
        required this.suggest,
    });

    factory AggregationSearch.fromJson(
        Map<String, dynamic> json,
        T Function(Object? json) fromJsonT,
    ) => _$AggregationSearchFromJson(json, fromJsonT);

    Map<String, dynamic> toJson(Object Function(T) toJsonT) => _$AggregationSearchToJson(this, toJsonT);
}

@JsonSerializable()
class CourseAggregations {
    @JsonKey(name: "type")
    AudienceClass type;
    @JsonKey(name: "topics")
    AudienceClass topics;
    @JsonKey(name: "offered_by")
    AudienceClass offeredBy;
    @JsonKey(name: "audience")
    AudienceClass audience;
    @JsonKey(name: "certification")
    AudienceClass certification;
    @JsonKey(name: "department_name")
    AudienceClass departmentName;
    @JsonKey(name: "level")
    LevelClass level;
    @JsonKey(name: "course_feature_tags")
    AudienceClass courseFeatureTags;
    @JsonKey(name: "resource_type")
    AudienceClass resourceType;

    CourseAggregations({
        required this.type,
        required this.topics,
        required this.offeredBy,
        required this.audience,
        required this.certification,
        required this.departmentName,
        required this.level,
        required this.courseFeatureTags,
        required this.resourceType,
    });

    factory CourseAggregations.fromJson(Map<String, dynamic> json) => _$CourseAggregationsFromJson(json);

    Map<String, dynamic> toJson() => _$CourseAggregationsToJson(this);
}

@JsonSerializable()
class AudienceClass {
    @JsonKey(name: "doc_count_error_upper_bound")
    int docCountErrorUpperBound;
    @JsonKey(name: "sum_other_doc_count")
    int sumOtherDocCount;
    @JsonKey(name: "buckets")
    List<Bucket> buckets;

    AudienceClass({
        required this.docCountErrorUpperBound,
        required this.sumOtherDocCount,
        required this.buckets,
    });

    factory AudienceClass.fromJson(Map<String, dynamic> json) => _$AudienceClassFromJson(json);

    Map<String, dynamic> toJson() => _$AudienceClassToJson(this);
}

@JsonSerializable()
class Bucket {
    @JsonKey(name: "key")
    String key;
    @JsonKey(name: "doc_count")
    int docCount;

    Bucket({
        required this.key,
        required this.docCount,
    });

    factory Bucket.fromJson(Map<String, dynamic> json) => _$BucketFromJson(json);

    Map<String, dynamic> toJson() => _$BucketToJson(this);
}

@JsonSerializable()
class LevelClass {
    @JsonKey(name: "buckets")
    List<Bucket> buckets;

    LevelClass({
        required this.buckets,
    });

    factory LevelClass.fromJson(Map<String, dynamic> json) => _$LevelClassFromJson(json);

    Map<String, dynamic> toJson() => _$LevelClassToJson(this);
}

@JsonSerializable(genericArgumentFactories: true)
class Hits<T> {
    @JsonKey(name: "total")
    int total;
    @JsonKey(name: "max_score")
    double? maxScore;
    @JsonKey(name: "hits")
    List<Hit<T>> hits;

    Hits({
        required this.total,
        required this.maxScore,
        required this.hits,
    });

    factory Hits.fromJson(
        Map<String, dynamic> json,
        T Function(Object? json) fromJsonT,
    ) => _$HitsFromJson(json, fromJsonT);


    Map<String, dynamic> toJson(Object? Function(T) toJsonT) => _$HitsToJson(this, toJsonT);
}

@JsonSerializable(genericArgumentFactories: true)
class Hit<T> {
    @JsonKey(name: "_index")
    String index;
    @JsonKey(name: "_type")
    Type type;
    @JsonKey(name: "_id")
    String id;
    @JsonKey(name: "_score")
    double score;
    @JsonKey(name: "_source")
    T source;

    Hit({
        required this.index,
        required this.type,
        required this.id,
        required this.score,
        required this.source,
    });

    factory Hit.fromJson(
        Map<String, dynamic> json,
        T Function(Object? json) fromJsonT,
    ) => _$HitFromJson<T>(json, fromJsonT);

    Map<String, dynamic> toJson(Object? Function(T) toJsonT) => _$HitToJson<T>(this, toJsonT);
}

@JsonSerializable()
class FullCourseRun {
    @JsonKey(name: "course")
    Course course;
    @JsonKey(name: "run")
    Run run;

    FullCourseRun({
        required this.course,
        required this.run,
    });

    factory FullCourseRun.fromCourse(Course course) => FullCourseRun(
      course: course,
      run: course.runs[0],
    );

    factory FullCourseRun.fromJson(Map<String, dynamic> json) => _$FullCourseRunFromJson(json);

    Map<String, dynamic> toJson() => _$FullCourseRunToJson(this);
}

@JsonSerializable()
class Course {
    @JsonKey(name: "id")
    int id;
    @JsonKey(name: "course_id")
    String courseId;
    @JsonKey(name: "coursenum")
    String coursenum;
    @JsonKey(name: "short_description")
    String shortDescription;
    @JsonKey(name: "full_description")
    String? fullDescription;
    @JsonKey(name: "platform")
    Platform platform;
    @JsonKey(name: "title")
    String title;
    @JsonKey(name: "image_src")
    String imageSrc;
    @JsonKey(name: "topics")
    List<String> topics;
    @JsonKey(name: "published")
    bool published;
    @JsonKey(name: "offered_by")
    List<OfferedBy> offeredBy;
    @JsonKey(name: "runs")
    List<Run> runs;
    @JsonKey(name: "created")
    DateTime created;
    @JsonKey(name: "default_search_priority")
    double defaultSearchPriority;
    @JsonKey(name: "minimum_price")
    String minimumPrice;
    @JsonKey(name: "audience")
    List<AudienceElement> audience;
    @JsonKey(name: "certification")
    List<dynamic> certification;
    @JsonKey(name: "department_name")
    List<String> departmentName;
    @JsonKey(name: "department_slug")
    String? departmentSlug;
    @JsonKey(name: "course_feature_tags")
    List<CourseFeatureTag> courseFeatureTags;
    @JsonKey(name: "department_course_numbers")
    List<DepartmentCourseNumber> departmentCourseNumbers;
    @JsonKey(name: "object_type")
    ObjectType objectType;
    @JsonKey(name: "resource_relations")
    ResourceRelations resourceRelations;

    Course({
        required this.id,
        required this.courseId,
        required this.coursenum,
        required this.shortDescription,
        required this.fullDescription,
        required this.platform,
        required this.title,
        required this.imageSrc,
        required this.topics,
        required this.published,
        required this.offeredBy,
        required this.runs,
        required this.created,
        required this.defaultSearchPriority,
        required this.minimumPrice,
        required this.audience,
        required this.certification,
        required this.departmentName,
        required this.departmentSlug,
        required this.courseFeatureTags,
        required this.departmentCourseNumbers,
        required this.objectType,
        required this.resourceRelations,
    });

    factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);
    factory Course.fromJsonModel(Object? json) => Course.fromJson(json as Map<String, dynamic>);

    Map<String, dynamic> toJson() => _$CourseToJson(this);
}

@JsonEnum()
enum AudienceElement {
    @JsonValue("Open Content")
    OPEN_CONTENT
}

@JsonEnum()
enum CourseFeatureTag {
    @JsonValue("Activity Assignments")
    ACTIVITY_ASSIGNMENTS,
    @JsonValue("Activity Assignments with Examples")
    ACTIVITY_ASSIGNMENTS_WITH_EXAMPLES,
    @JsonValue("Course Introduction")
    COURSE_INTRODUCTION,
    @JsonValue("Demonstration Audio")
    DEMONSTRATION_AUDIO,
    @JsonValue("Demonstration Videos")
    DEMONSTRATION_VIDEOS,
    @JsonValue("Design Assignments")
    DESIGN_ASSIGNMENTS,
    @JsonValue("Design Assignments with Examples")
    DESIGN_ASSIGNMENTS_WITH_EXAMPLES,
    @JsonValue("Exams")
    EXAMS,
    @JsonValue("Exams with Solutions")
    EXAMS_WITH_SOLUTIONS,
    @JsonValue("Exam Materials")
    EXAM_MATERIALS,
    @JsonValue("Image Gallery")
    IMAGE_GALLERY,
    @JsonValue("Instructor Insights")
    INSTRUCTOR_INSIGHTS,
    @JsonValue("Labs")
    LABS,
    @JsonValue("Lecture Audio")
    LECTURE_AUDIO,
    @JsonValue("Lecture Notes")
    LECTURE_NOTES,
    @JsonValue("Lecture Videos")
    LECTURE_VIDEOS,
    @JsonValue("Media Assignments")
    MEDIA_ASSIGNMENTS,
    @JsonValue("Media Assignments with Examples")
    MEDIA_ASSIGNMENTS_WITH_EXAMPLES,
    @JsonValue("Multiple Assignment Types")
    MULTIPLE_ASSIGNMENT_TYPES,
    @JsonValue("Music")
    MUSIC,
    @JsonValue("Online Textbook")
    ONLINE_TEXTBOOK,
    @JsonValue("Other Audio")
    OTHER_AUDIO,
    @JsonValue("Other Video")
    OTHER_VIDEO,
    @JsonValue("Presentation Assignments")
    PRESENTATION_ASSIGNMENTS,
    @JsonValue("Presentation Assignments with Examples")
    PRESENTATION_ASSIGNMENTS_WITH_EXAMPLES,
    @JsonValue("Problem Sets")
    PROBLEM_SETS,
    @JsonValue("Problem Sets with Solutions")
    PROBLEM_SETS_WITH_SOLUTIONS,
    @JsonValue("Programming Assignments")
    PROGRAMMING_ASSIGNMENTS,
    @JsonValue("Programming Assignments with Examples")
    PROGRAMMING_ASSIGNMENTS_WITH_EXAMPLES,
    @JsonValue("Projects")
    PROJECTS,
    @JsonValue("Projects with Examples")
    PROJECTS_WITH_EXAMPLES,
    @JsonValue("Readings")
    READINGS,
    @JsonValue("Recitation Videos")
    RECITATION_VIDEOS,
    @JsonValue("Simulations")
    SIMULATIONS,
    @JsonValue("Simulation Videos")
    SIMULATION_VIDEOS,
    @JsonValue("Tools")
    TOOLS,
    @JsonValue("Tutorial Videos")
    TUTORIAL_VIDEOS,
    @JsonValue("Videos")
    VIDEOS,
    @JsonValue("Video Materials")
    VIDEO_MATERIALS,
    @JsonValue("Workshop Videos")
    WORKSHOP_VIDEOS,
    @JsonValue("Written Assignments")
    WRITTEN_ASSIGNMENTS,
    @JsonValue("Written Assignments with Examples")
    WRITTEN_ASSIGNMENTS_WITH_EXAMPLES
}

extension CourseFeatureTagExtension on CourseFeatureTag {
  String toJson() => _$CourseFeatureTagEnumMap[this]!;
}

@JsonSerializable()
class DepartmentCourseNumber {
    @JsonKey(name: "coursenum")
    String coursenum;
    @JsonKey(name: "department")
    String? department;
    @JsonKey(name: "primary")
    bool primary;
    @JsonKey(name: "sort_coursenum")
    String sortCoursenum;

    DepartmentCourseNumber({
        required this.coursenum,
        required this.department,
        required this.primary,
        required this.sortCoursenum,
    });

    factory DepartmentCourseNumber.fromJson(Map<String, dynamic> json) => _$DepartmentCourseNumberFromJson(json);

    Map<String, dynamic> toJson() => _$DepartmentCourseNumberToJson(this);
}

enum ObjectType {
    @JsonValue("course")
    COURSE,
    @JsonValue("resourcefile")
    RESOURCEFILE
}

enum OfferedBy {
    @JsonValue("OCW")
    OCW
}

enum Platform {
    @JsonValue("ocw")
    OCW
}

@JsonSerializable()
class ResourceRelations {
    @JsonKey(name: "name")
    Name name;

    ResourceRelations({
        required this.name,
    });

    factory ResourceRelations.fromJson(Map<String, dynamic> json) => _$ResourceRelationsFromJson(json);

    Map<String, dynamic> toJson() => _$ResourceRelationsToJson(this);
}

enum Name {
    @JsonValue("resource")
    RESOURCE
}

@JsonSerializable()
class Run {
    @JsonKey(name: "id")
    int id;
    @JsonKey(name: "run_id")
    String runId;
    @JsonKey(name: "short_description")
    String shortDescription;
    @JsonKey(name: "full_description")
    String? fullDescription;
    @JsonKey(name: "language")
    dynamic language;
    @JsonKey(name: "semester")
    Semester semester;
    @JsonKey(name: "year")
    int year;
    @JsonKey(name: "level")
    List<LevelElement>? level;
    @JsonKey(name: "start_date")
    dynamic startDate;
    @JsonKey(name: "end_date")
    dynamic endDate;
    @JsonKey(name: "enrollment_start")
    dynamic enrollmentStart;
    @JsonKey(name: "enrollment_end")
    dynamic enrollmentEnd;
    @JsonKey(name: "best_start_date")
    DateTime bestStartDate;
    @JsonKey(name: "best_end_date")
    DateTime bestEndDate;
    @JsonKey(name: "title")
    String title;
    @JsonKey(name: "image_src")
    String imageSrc;
    @JsonKey(name: "prices")
    List<Price> prices;
    @JsonKey(name: "instructors")
    List<String> instructors;
    @JsonKey(name: "published")
    bool published;
    @JsonKey(name: "availability")
    Availability availability;
    @JsonKey(name: "offered_by")
    List<OfferedBy> offeredBy;
    @JsonKey(name: "slug")
    String slug;

    Run({
        required this.id,
        required this.runId,
        required this.shortDescription,
        required this.fullDescription,
        required this.language,
        required this.semester,
        required this.year,
        required this.level,
        required this.startDate,
        required this.endDate,
        required this.enrollmentStart,
        required this.enrollmentEnd,
        required this.bestStartDate,
        required this.bestEndDate,
        required this.title,
        required this.imageSrc,
        required this.prices,
        required this.instructors,
        required this.published,
        required this.availability,
        required this.offeredBy,
        required this.slug,
    });

    factory Run.fromJson(Map<String, dynamic> json) => _$RunFromJson(json);

    Map<String, dynamic> toJson() => _$RunToJson(this);
}

enum Availability {
    @JsonValue("Current")
    CURRENT
}

enum LevelElement {
    @JsonValue("Graduate")
    GRADUATE,
    @JsonValue("High School")
    HIGH_SCHOOL,
    @JsonValue("Non-Credit")
    NON_CREDIT,
    @JsonValue("Undergraduate")
    UNDERGRADUATE
}

@JsonSerializable()
class Price {
    @JsonKey(name: "price")
    String price;
    @JsonKey(name: "mode")
    Mode mode;

    Price({
        required this.price,
        required this.mode,
    });

    factory Price.fromJson(Map<String, dynamic> json) => _$PriceFromJson(json);

    Map<String, dynamic> toJson() => _$PriceToJson(this);
}

enum Mode {
    @JsonValue("audit")
    AUDIT
}

enum Semester {
    @JsonValue("Fall")
    FALL,
    @JsonValue("January IAP")
    JANUARY_IAP,
    @JsonValue("Spring")
    SPRING,
    @JsonValue("Summer")
    SUMMER
}

enum Type {
    @JsonValue("_doc")
    DOC
}

@JsonSerializable()
class Shards {
    @JsonKey(name: "total")
    int total;
    @JsonKey(name: "successful")
    int successful;
    @JsonKey(name: "skipped")
    int skipped;
    @JsonKey(name: "failed")
    int failed;

    Shards({
        required this.total,
        required this.successful,
        required this.skipped,
        required this.failed,
    });

    factory Shards.fromJson(Map<String, dynamic> json) => _$ShardsFromJson(json);

    Map<String, dynamic> toJson() => _$ShardsToJson(this);
}
