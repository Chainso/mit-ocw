import React, { useEffect } from 'react';
import { StatusBar } from 'expo-status-bar';
import {
  StyleSheet,
  Text,
  SafeAreaView
} from 'react-native';

import { useAppDispatch, useAppSelector } from '../../redux/hooks';
import { getCourses } from '../../redux/features/courses/coursesSlice';
import { selectCourses } from '../../redux/features/courses/coursesSlice';

export default function Home() {
  const dispatch = useAppDispatch();
  const courses = useAppSelector(selectCourses);

  useEffect(() => {
    if (courses.length === 0) {
      dispatch(getCourses());
    }
  }, []);
  console.log(courses)
  return (
    <SafeAreaView style={styles.container}>
      <Text>Open up App.tsx to ssstartss working on your app!</Text>
      <StatusBar style="auto" />
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
    alignItems: 'center',
    justifyContent: 'center',
  },
});
