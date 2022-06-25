import React from 'react';
import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';
import { AntDesign, Ionicons } from '@expo/vector-icons';

import Home from '../screens/Home';
import Favourites from '../screens/Favourites';

export default function HomeTabNavigator() {
  const Tab = createBottomTabNavigator();

  return (
    <Tab.Navigator>
      <Tab.Screen
        name="Courses"
        component={Home}
        options={{
          tabBarIcon: ({ color }) => (
            <Ionicons name="school" color={color} size={iconStyle.size} />
          ),
          headerShown: false
        }} />

      <Tab.Screen
        name="Favourites"
        component={Favourites}
        options={{
          tabBarIcon: ({ color }) => (
            <AntDesign name="hearto" color={color} size={iconStyle.size} />
          ),
          headerShown: false
        }} />
    </Tab.Navigator>
  );
}

const iconStyle = {
  size: 25
};
