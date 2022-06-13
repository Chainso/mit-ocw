import { createAsyncThunk } from '@reduxjs/toolkit';

export const makeAsyncCallThunk = (typePrefix: string, options?: any) => {
  return createAsyncThunk(
    typePrefix,
    async (func: Function, ...args: any) => {
      return await func(...args);
    },
    options
  );
};
