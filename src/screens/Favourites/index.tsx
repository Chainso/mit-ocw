import React, { useEffect } from 'react';
import {
  StyleSheet,
  SafeAreaView,
  FlatList
} from 'react-native';

import { useAppDispatch, useAppSelector } from '../../redux/hooks';
import { getCourses } from '../../redux/features/courses/coursesSlice';
import { selectCourses } from '../../redux/features/courses/coursesSlice';
import CourseTile from '../../components/CourseTile';

export default function Favourites() {
  const dispatch = useAppDispatch();
  const courses = useAppSelector(selectCourses);

  useEffect(() => {
    if (courses.length === 0) {
      dispatch(getCourses());
    }
  }, []);

  const ucor = courses.length > 0 ? [courses[0], courses[1]] : [];
  return (
    <SafeAreaView style={styles.container}>
      <FlatList
        data={ucor}
        renderItem={({ item }) => <CourseTile course={item} />}
        showsVerticalScrollIndicator={false}
      />
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 20,
    backgroundColor: '#fff',
    width: '100%'
  },
});
