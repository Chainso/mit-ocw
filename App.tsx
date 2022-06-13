import React, { useEffect } from 'react';
import { Provider } from 'react-redux';

import Home from './src/screens/Home/Home';
import { store } from './src/redux/store';

export default function App() {
  return (
    <React.StrictMode>
      <Provider store={store}>
        <Home />
      </Provider>
    </React.StrictMode>
  );
}
