import React from 'react';
import {
  StyleSheet,
  Text,
  SafeAreaView,
  View,
  Image
} from 'react-native';
import { useDeviceOrientation } from '@react-native-community/hooks';
import { FlatGrid } from 'react-native-super-grid';

import OCWApi from '../../constants/ocw-api';
import { backgroundGray, textGray } from '../../utils/colours';
import { Entypo } from '@expo/vector-icons';


export default function CourseScreen({ navigation, route }) {
  const { course } = route.params;
  const { landscape } = useDeviceOrientation();

  const courseRun = course.runs[0];
  const courseLevel = courseRun?.level?.[0]?.charAt(0);

  type ArrayInfoPiece = {
    displayText: string,
    count: number,
    style: any
  };

  interface ArrayInfoPieceContainer {
    item: ArrayInfoPiece
  };

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
    course.department_name, styles.department
  );
  const topicPiece = createArrayInfoPiece(
    course.topics, styles.department
  );
  const arrayInfo = [instructorPiece, departmentPiece, topicPiece];

  return (
    <View style={[styles.container, landscape ? styles.landscape : styles.portrait]}>
      <Image
        style={styles.image}
        source={{ uri: OCWApi.URL + course.image_src }}
      />
      <SafeAreaView style={styles.information}>
        <View style={styles.titleBar}>
          <Text style={styles.titleBarText}>{course.title}</Text>
          <View style={styles.courseInfo}>
            <Text style={[styles.titleBarText, styles.courseInfoText]}>{course.coursenum}</Text>
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