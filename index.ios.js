import React, { Component } from 'react'
import {
  AppRegistry,
  StyleSheet,
  Text,
  View
} from 'react-native'

import Root from './src/pages/Root'

class Splash extends Component {
  render() {
    return <Text>Tabd</Text>
  }
}

AppRegistry.registerComponent('TabdMobile', () => Root)
