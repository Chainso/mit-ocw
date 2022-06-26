import {
  createSlice,
  PayloadAction,
  Draft,
  ActionReducerMapBuilder,
  createAsyncThunk
} from '@reduxjs/toolkit';
import axios from 'axios';
import { keys } from 'ts-transformer-keys';

import OCWApi from '../../../constants/ocw-api';
import { RootState } from '../../store';
import { makeAsyncCallThunk } from '../../utils';
import { Aggregations, Course, CourseInfo } from './types';

export type CourseState = {
  courses: CourseInfo[],
  courseDict: Record<number, CourseInfo>,
  aggregations: Aggregations
};

const makeBucketContainer = () => {
  return {
    buckets: []
  };
};

const initialCourseState: CourseState = {
  courses: [],
  courseDict: {},
  aggregations: {
    topics: makeBucketContainer(),
    offered_by: makeBucketContainer(),
    audience: makeBucketContainer(),
    certification: makeBucketContainer(),
    department_name: makeBucketContainer(),
    level: makeBucketContainer(),
    course_feature_tags: makeBucketContainer(),
    resource_type: makeBucketContainer()
  }
};

export const makeAsyncCall = makeAsyncCallThunk('courses/makeAsyncCall');
export const getCourses = createAsyncThunk('courses/getCourses', async () => {
  return await axios.post(OCWApi.API_URL + OCWApi.SEARCH.URL, OCWApi.SEARCH.BODY)
    .then((courses) => courses.data);
});

export const coursesSlice = createSlice({
  name: 'courses',
  initialState: initialCourseState,
  reducers: {
    setCourse: (state, action: PayloadAction<CourseInfo>) => {
      const course = state.courseDict[action.payload.course.id];
      Object.assign(course, action.payload);
    }
  },
  extraReducers: (builder: ActionReducerMapBuilder<CourseState>) => {
    builder
      .addCase(getCourses.fulfilled,
        (state: Draft<CourseState>,
          coursesJson: PayloadAction<any>) => {
          const courses = coursesJson.payload.hits.hits.map((course: any): Course => course._source);

          state.aggregations = coursesJson.payload.aggregations;

          state.courses = courses.filter((course: Course) => {
            return course.runs.length > 0;
          }).map((course: Course): CourseInfo => {
            return {
              course: course,
              features: {}
            };
          });

          state.courseDict = state.courses.reduce((curDict: Record<number, CourseInfo>, courseInfo: CourseInfo) => {
            curDict[courseInfo.course.id] = courseInfo;
            return curDict;
          }, {});
        });
  }
});

export const { setCourse } = coursesSlice.actions;
export const selectCourses = (state: RootState) => state.courses.courses;
export const selectCourseDict = (state: RootState) => state.courses.courseDict;
export const selectCourse = (id: number) => (state: RootState) => { return { ...state.courses.courseDict[id] } };
export const selectAggregations = (state: RootState) => state.courses.aggregations;

export default coursesSlice.reducer;