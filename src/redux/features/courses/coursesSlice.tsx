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
import { Course } from './types';

export type CourseState = {
  courses: Course[]
}

const initialCoursesState: CourseState = {
  courses: []
}

export const makeAsyncCall = makeAsyncCallThunk('courses/makeAsyncCall');
export const getCourses = createAsyncThunk('courses/getCourses', async () => {
  return await axios.post(OCWApi.SEARCH.URL, OCWApi.SEARCH.BODY)
    .then((courses) => {
      return courses.data.hits.hits;
    });
});

export const coursesSlice = createSlice({
  name: 'courses',
  initialState: initialCoursesState,
  reducers: {},
  extraReducers: (builder: ActionReducerMapBuilder<CourseState>) => {
    builder
      .addCase(getCourses.fulfilled,
        (state: Draft<CourseState>,
          courses: PayloadAction<Course[]>): void => {
          state.courses = courses.payload;
        });
  }
});

export const selectCourses = (state: RootState) => state.courses.courses;

export default coursesSlice.reducer;