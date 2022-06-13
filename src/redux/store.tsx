import { configureStore, ThunkAction, Action } from '@reduxjs/toolkit';
import coursesReducer from './features/courses/coursesSlice';

export const store = configureStore({
  reducer: {
    courses: coursesReducer,
  },
});

export type AppDispatch = typeof store.dispatch;
export type RootState = ReturnType<typeof store.getState>;
export type AppThunk<ReturnType = void> = ThunkAction<
  ReturnType,
  RootState,
  unknown,
  Action<string>
>;
