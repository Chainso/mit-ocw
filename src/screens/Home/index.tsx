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
import HomeHeader from '../../components/HomeHeader';

export default function Home() {
  const dispatch = useAppDispatch();
  const courses = useAppSelector(selectCourses);

  useEffect(() => {
    if (courses.length === 0) {
      dispatch(getCourses());
    }
  }, []);

  const onSearchButtonPress = () => {
    console.log('Search button pressed');
  };

  return (
    <SafeAreaView style={styles.container}>
      <HomeHeader searchButtonCallback={onSearchButtonPress} />
      <FlatList
        data={courses}
        renderItem={({ item }) => <CourseTile course={item.course} />}
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
    width: '100%',
    marginTop: 15
  }
});
