export type CourseInfo = {
  course: Course,
  features: CourseFeatures
  page?: string,
};

export type Course = {
  'id': number,
  'course_id': string,
  'coursenum': string,
  'short_description': string,
  'full_description': string,
  'platform': string,
  'title': string,
  'image_src': string,
  'topics': Array<string>,
  'published': boolean,
  'offered_by': Array<string>,
  'runs': Array<CourseRun>,
  'created': Date,
  'default_search_priority': number,
  'minimum_price': string,
  'audience': Array<string>
  'certification': Array<string>,
  'department_name': Array<string>
  'department_slug': Array<string>,
  'course_feature_tags': Array<CourseFeatureTags>
  'department_course_numbers': Array<CourseDepartmentCourseNumber>
  'object_type': string,
  'resource_relations': CourseResourceRelation
};


export type CourseRun = {
  'end_date': Date,
  'short_description': string,
  'run_id': string,
  'year': number,
  'level': Array<CourseLevels>,
  'enrollment_end': Date,
  'language': string,
  'best_start_date': Date,
  'published': boolean,
  'availability': string,
  'offered_by': Array<string>,
  'title': string,
  'image_src': string,
  'instructors': Array<string>
  'enrollment_start': Date,
  'full_description': string,
  'best_end_date': Date,
  'semester': Array<string>,
  'id': number,
  'prices': Array<CoursePrice>
  'slug': string,
  'start_date': Date
};

export type CoursePrice = {
  mode: string,
  price: string
};

export type CourseDepartmentCourseNumber = {
  'coursenum': string,
  'sort_coursenum': string,
  'department': string,
  'primary': boolean
};

export type CourseResourceRelation = {
  name: string
};

export enum CourseLevels {
  UNDERGRADUATE = 'Undergraduate',
  GRADUATE = 'Graduate'
}

export enum CourseFeatureTags {
  LECTURE_NOTES = 'Lecture Notes',
  LECTURE_VIDEOS = 'Lecture Videos'
}

export type CourseFeatures = {
  lectureVideos?: LectureVideo[]
};

export type LectureVideo = {
  title?: string,
  thumbnail?: string,
  pageUrl?: string
};

export type Aggregations = {
  topics: BucketContainer,
  offered_by: BucketContainer,
  audience: BucketContainer,
  certification: BucketContainer,
  department_name: BucketContainer,
  level: BucketContainer,
  course_feature_tags: BucketContainer,
  resource_type: BucketContainer
};

export type BucketContainer = {
  doc_count_error_upper_bound?: number,
  sum_other_doc_count?: number,
  buckets: Bucket[]
};

export type Bucket = {
  key: string,
  doc_count: number
};
