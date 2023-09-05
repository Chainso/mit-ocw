import React from 'react';
import { Provider } from 'react-redux';
import { StatusBar } from 'expo-status-bar';

import { store } from './src/redux/store';
import Router from './src/routes/Router';
import { PaperProvider } from 'react-native-paper';

export default function App() {
  return (
    <Provider store={store}>
      <PaperProvider>
        <StatusBar style="auto" />
        <Router />
      </PaperProvider>
    </Provider>
  );
}
