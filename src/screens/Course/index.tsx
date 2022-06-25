import React, { useEffect } from 'react';
import {
  StyleSheet,
  Text,
  SafeAreaView,
  View,
  Image
} from 'react-native';
import { useDeviceOrientation } from '@react-native-community/hooks';
import { FlatGrid } from 'react-native-super-grid';
import axios from 'axios';
import * as cheerio from 'cheerio';

import { useAppDispatch, useAppSelector } from '../../redux/hooks';
import { selectCourse, setCourse } from '../../redux/features/courses/coursesSlice';
import OCWApi from '../../constants/ocw-api';
import { backgroundGray, textGray } from '../../utils/colours';
import { Entypo } from '@expo/vector-icons';
import {
  CourseFeatureTags,
  LectureVideo
} from '../../redux/features/courses/types';


export default function CourseScreen({ navigation, route }) {
  const { courseId } = route.params;
  const { landscape } = useDeviceOrientation();

  const dispatch = useAppDispatch();
  const course = useAppSelector(selectCourse(courseId));

  const courseRun = course.course.runs[0];
  const courseLevel = courseRun?.level?.[0]?.charAt(0);

  type ArrayInfoPiece = {
    displayText: string,
    count: number,
    style: any
  };

  interface ArrayInfoPieceContainer {
    item: ArrayInfoPiece
  };

  const onInit = () => {
    const featureTagSet = new Set(course.course.course_feature_tags);
    console.log(featureTagSet);
    console.log(CourseFeatureTags.LECTURE_VIDEOS);
    if (featureTagSet.has(CourseFeatureTags.LECTURE_VIDEOS) && !course.features?.lectureVideos) {
      parseVideos();
    }
  };

  const parseVideos = () => {
    console.log('Got lec');
    const doc = cheerio.load(course.page || '');
    const videoSelector = doc('.video-link', '#course-content-section');
    const videos = videoSelector.toArray();

    course.features.lectureVideos = videos.map((videoTag): LectureVideo => {
      const video = doc(videoTag);

      const videoPage = video.attr('href');
      const thumbnail = doc('img', video).attr('src');
      const videoTitle = doc('.video-title', video).text();

      return {
        title: videoTitle,
        thumbnail: thumbnail,
        pageUrl: videoPage
      };
    });

    console.log(course.features.lectureVideos);
  };

  useEffect(() => {
    if (course.page) {
      onInit();
    } else {
      axios.get('https://ocw.mit.edu/courses/15-s12-blockchain-and-money-fall-2018/video_galleries/video-lectures/')
        .then((page) => {
          console.log('Got page');
          course.page = page.data;
          dispatch(setCourse(course));
          onInit();
        });
    }
  }, []);

  const createArrayInfoPiece = (data: string[], style: any): ArrayInfoPiece => {
    return {
      displayText: data[0],
      count: data.length,
      style: [styles.arrayInfoPieceItem, style]
    };
  }

  const renderArrayInfoPiece = ({ item }: ArrayInfoPieceContainer) => {
    const extras = (
      item.count > 1
        ? (
          <View style={styles.extrasContainer}>
            <Entypo style={styles.extrasIcon} name="circle-with-plus" />
            <Text>{item.count - 1}</Text>
          </View>
        )
        : null
    );

    return (
      <View style={styles.arrayInfoPieceContainer}>
        <Text style={item.style}>{item.displayText}</Text>
        {extras}
      </View>
    );
  }

  const instructorPiece = createArrayInfoPiece(
    courseRun.instructors, styles.instructor
  );
  const departmentPiece = createArrayInfoPiece(
    course.course.department_name, styles.department
  );
  const topicPiece = createArrayInfoPiece(
    course.course.topics, styles.department
  );
  const arrayInfo = [instructorPiece, departmentPiece, topicPiece];

  return (
    <View style={[styles.container, landscape ? styles.landscape : styles.portrait]}>
      <Image
        style={styles.image}
        source={{ uri: OCWApi.URL + course.course.image_src }}
      />
      <SafeAreaView style={styles.information}>
        <View style={styles.titleBar}>
          <Text style={styles.titleBarText}>{course.course.title}</Text>
          <View style={styles.courseInfo}>
            <Text style={[styles.titleBarText, styles.courseInfoText]}>{course.course.coursenum}</Text>
            <Text style={[styles.titleBarText, styles.courseInfoText, styles.levelDelimiter]}>|</Text>
            <Text style={[styles.titleBarText, styles.courseInfoText]}>{courseLevel}</Text>
          </View>
        </View>
        <View style={styles.arrayInfoContainer}>
          <FlatGrid
            style={styles.arrayInfoGrid}
            data={arrayInfo}
            renderItem={renderArrayInfoPiece}
          />
        </View>
      </SafeAreaView>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    width: '100%',
    marginTop: 25
  },
  landscape: {
    height: '50%',
  },
  portrait: {
    height: '90%'
  },
  image: {
    width: '100%',
    aspectRatio: 3 / 2,
    resizeMode: 'cover'
  },
  information: {
    marginHorizontal: 10
  },
  titleBar: {
    marginVertical: 10,
    flexDirection: 'row',
    justifyContent: 'space-between'
  },
  titleBarText: {
    fontWeight: 'bold',
    fontSize: 16,
  },
  courseInfo: {
    flexDirection: 'row'
  },
  courseInfoText: {
    color: '#a31f34',
    textTransform: 'uppercase'
  },
  levelDelimiter: {
    marginHorizontal: 5
  },
  titleDelimiter: {
    marginHorizontal: 5
  },
  arrayInfoContainer: {
    flexDirection: 'row'
  },
  arrayInfoGrid: {
    marginLeft: -10
  },
  arrayInfoPieceContainer: {
    flex: 1,
    flexDirection: 'row',
    justifyContent: 'flex-start',
    alignItems: 'center'
  },
  arrayInfoPieceItem: {
    margin: 5
  },
  extrasContainer: {
    flex: 1,
    flexDirection: 'row',
    alignItems: 'center'
  },
  extrasIcon: {
    marginHorizontal: 5
  },
  instructor: {
    color: textGray
  },
  department: {
    backgroundColor: backgroundGray,
    fontWeight: 'bold',
    paddingHorizontal: 4
  },
});