import React, { useEffect } from 'react';
import {
  StyleSheet,
  Pressable,
  Text,
  View
} from 'react-native';

import { FontAwesome } from '@expo/vector-icons';

interface HomeHeaderProps {
  searchButtonCallback: Function
};

export default function HomeHeader({ searchButtonCallback }: HomeHeaderProps) {
  const onSearchButtonPress = () => {
    console.log('Search button pressed');
    searchButtonCallback();
  };

  return (
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
  );
}

const styles = StyleSheet.create({
  header: {
    width: '100%',
    flexDirection: 'row',
    marginBottom: 10
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
