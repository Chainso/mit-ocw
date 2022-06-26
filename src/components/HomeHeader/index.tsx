import React, { ReactElement, useEffect, useState } from 'react';
import {
  StyleSheet,
  Pressable,
  Text,
  View,
  SafeAreaView
} from 'react-native';
import CheckBox from 'react-native-check-box'

import { FontAwesome, Ionicons } from '@expo/vector-icons';
import { Menu, MenuItem, MenuDivider } from 'react-native-material-menu';
import { useAppSelector } from '../../redux/hooks';
import { selectAggregations } from '../../redux/features/courses/coursesSlice';
import { Aggregations, Bucket, BucketContainer } from '../../redux/features/courses/types';

interface HomeHeaderProps {
  searchButtonCallback: Function
};

type FilterOption = {
  title: string,
  field: string
};

export default function HomeHeader({ searchButtonCallback }: HomeHeaderProps) {
  const aggregations = useAppSelector(selectAggregations);

  const onSearchButtonPress = () => {
    console.log('Search button pressed');
    searchButtonCallback();
  };

  const filter: Record<string, Set<string>> = {};
  const filterOptions: FilterOption[] = [
    {
      title: 'Level',
      field: 'level'
    },
    /**{
      title: 'Topics',
      field: 'topics'
    },
    {
      title: 'Features',
      field: 'course_feature_tags'
    },
    {
      title: 'Departments',
      field: 'department_name'
    }*/
  ];


  type CheckboxChecks = Record<string, Record<string, boolean>>;
  const [checkboxes, setChecked] = useState<CheckboxChecks>({});
  const [menu, setMenu] = useState<ReactElement<any, any>[]>([]);

  const toggleChecked = (filterOption: FilterOption, bucket: Bucket) => () => setChecked((state) => {
    return {
      ...state,
      [filterOption.field]: {
        ...state[filterOption.field],
        [bucket.key]: !state[filterOption.field][bucket.key]
      }
    };
  });

  const [filterVisible, setFilterVisible] = useState(false);
  const hideFilterMenu = () => setFilterVisible(false);
  const showFilterMenu = () => setFilterVisible(true);

  const menuItemOnPress = (field: string, bucket: Bucket) => () => {
    if (!filter[field]) {
      filter[field] = new Set();
    }

    if (filter[field].has(bucket.key)) {
      filter[field].delete(bucket.key);
    } else {
      filter[field].add(bucket.key);
    }
    console.log(`Pressed ${field}: ${bucket.key}`);
    console.log(filter);
  };

  const createMenuItem = (filterOption: FilterOption, bucket: Bucket) => {
    checkboxes[filterOption.field][bucket.key] = false;

    return (
      <MenuItem
        key={bucket.key}
        onPress={menuItemOnPress(filterOption.field, bucket)}>
        <CheckBox
          onClick={toggleChecked(filterOption, bucket)}
          style={{ flex: 1, padding: 10 }}
          isChecked={checkboxes[filterOption.field][bucket.key]}
          rightText={bucket.key} />
      </MenuItem>
    );
  };

  const createMenuSection = (filterOption: FilterOption) => {
    checkboxes[filterOption.field] = {};
    const aggregation = aggregations[filterOption.field as keyof Aggregations];

    return (
      <View>
        <Text>{filterOption.title}</Text>
        {aggregation.buckets.map((bucket: Bucket) => createMenuItem(filterOption, bucket))}
      </View>
    );
  };

  const createMenu = (filterOptions: FilterOption[]) => {
    const filters = filterOptions.map((filterOption: FilterOption, index: number) => {
      return (
        <View key={index}>
          {index === 0 ? null : <MenuDivider />}
          {createMenuSection(filterOption)}
        </View>
      );
    });

    setChecked(checkboxes);
    setMenu(filters);
  };

  useEffect(() => {
    createMenu(filterOptions);
  }, []);

  const menuAnchor = (
    <View style={styles.headerRightSide}>
      <Ionicons onPress={showFilterMenu} name="filter" size={styles.searchButton.height - 5} />
    </View>
  );

  return (
    <SafeAreaView style={styles.header}>
      <Pressable
        style={styles.searchButton}
        onPress={onSearchButtonPress}>
        <FontAwesome name="search" style={styles.searchButtonIcon} />
        <Text style={styles.searchButtonText}>
          Search course
        </Text>
      </Pressable>
      <Menu
        visible={filterVisible}
        anchor={menuAnchor}
        onRequestClose={hideFilterMenu}>
        {menu}
      </Menu>
    </SafeAreaView >
  );
}

const styles = StyleSheet.create({
  header: {
    width: '100%',
    flexDirection: 'row',
    marginBottom: 10,
    marginHorizontal: 10,
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
  },
  headerRightSide: {
    flexDirection: 'row',
    justifyContent: 'flex-end',
    width: '30%'
  }
});
