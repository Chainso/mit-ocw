import {
  createSlice,
  PayloadAction,
  Draft,
  ActionReducerMapBuilder,
  createAsyncThunk
} from '@reduxjs/toolkit';
import axios from 'axios';

import OCWApi from '../../../constants/ocw-api';
import { RootState } from '../../store';
import { makeAsyncCallThunk } from '../../utils';
import { Course, CourseInfo } from './types';

export type CourseState = {
  courses: CourseInfo[],
  courseDict: Record<number, CourseInfo>
};

const initialCourseState: CourseState = {
  courses: [],
  courseDict: {}
};

export const makeAsyncCall = makeAsyncCallThunk('courses/makeAsyncCall');
export const getCourses = createAsyncThunk('courses/getCourses', async () => {
  return await axios.post(OCWApi.API_URL + OCWApi.SEARCH.URL, OCWApi.SEARCH.BODY)
    .then((courses) => courses.data.hits.hits.map((course: any): Course => course._source));
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
          courses: PayloadAction<Course[]>): CourseState => {
          const courseList = courses.payload.filter((course: Course) => {
            return course.runs.length > 0;
          }).map((course: Course): CourseInfo => {
            return {
              course: course,
              features: {}
            };
          });

          const courseDict = courseList.reduce((curDict: Record<number, CourseInfo>, courseInfo: CourseInfo) => {
            curDict[courseInfo.course.id] = courseInfo;
            return curDict;
          }, {});

          return {
            courses: courseList,
            courseDict: courseDict
          };
        });
  }
});

export const { setCourse } = coursesSlice.actions;
export const selectCourses = (state: RootState) => state.courses.courses;
export const selectCourseDict = (state: RootState) => state.courses.courseDict;
export const selectCourse = (id: number) => (state: RootState) => { return { ...state.courses.courseDict[id] } };

export default coursesSlice.reducer;