import React, { Component } from 'react';
import {
  AppRegistry,
  StyleSheet,
  Text,
  View
} from 'react-native';

import Login from './src/pages/Login'

export default class TabdMobile extends Component {
  state = {
      logged_in: false
  }

  render() {
    if (this.state.logged_in) {
      return <Login />;
    } else {
      // TODO: create root component
      // return <Root />
      return <Login />;
    }
  }
}

AppRegistry.registerComponent('TabdMobile', () => TabdMobile);
