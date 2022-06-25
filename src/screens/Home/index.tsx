import React, { useEffect } from 'react';
import {
  StyleSheet,
  SafeAreaView,
  FlatList,
  Pressable,
  Text,
  View
} from 'react-native';

import { useAppDispatch, useAppSelector } from '../../redux/hooks';
import { getCourses } from '../../redux/features/courses/coursesSlice';
import { selectCourses } from '../../redux/features/courses/coursesSlice';
import CourseTile from '../../components/CourseTile';
import { FontAwesome } from '@expo/vector-icons';

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

  const ucor = courses.length > 0 ? [courses[0], courses[1]] : [];
  return (
    <SafeAreaView style={styles.container}>
      <View style={styles.header}>
        <Pressable
          style={styles.searchButton}
          onPress={onSearchButtonPress}>
          <FontAwesome name="search" style={styles.searchButtonIcon} />
          <Text style={styles.searchButtonText}>
            Search course
          </Text>
        </Pressable>
      </View>
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
    width: '100%',
    marginTop: 15
  },
  header: {
    width: '100%',
    flexDirection: 'row'
  },
  searchButton: {
    flexDirection: 'row',
    width: '70%',
    marginHorizontal: 10,
    borderRadius: 30,
    borderWidth: 1,
    height: 30,
    borderColor: 'grey',
    alignItems: 'center',
  },
  searchButtonIcon: {
    marginHorizontal: 10
  },
  searchButtonText: {
    color: 'grey',
    fontSize: 16
  }
});
