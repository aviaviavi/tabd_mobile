import React, { Component } from 'react';

import {
  Alert,
  Button,
  StyleSheet,
  Text,
  View,
  TextInput,
  Linking,
} from 'react-native';

import Login from './Login'

class Splash extends Component {
  render() {
    return <Text>Tabd</Text>
  }
}

export default class Root extends Component {

  state = {
    logged_in: null,
    username: null
  }

  componentWillMount() {
    fetch('http://localhost:5000/logged_in', {headers: {'Accept': '*/*'}})
      .then(response => {
        return response.json()
      }).then(responseJson => {
        console.log(responseJson)
        this.setState({
          logged_in: responseJson.verified,
          username: responseJson.username
        })
      })
      .catch(error => {
        console.error('error', error)
      })
  }

  componentDidMount() {
    Linking.getInitialURL().then((url) => {
      if (url) {
        console.log('Initial url is: ' + url);
      } else {
        console.log('no url')
      }
    }).catch(err => console.error('An error occurred', err));
  }

  onLogin(username) {
    this.setState({
      logged_in: true,
      username: username
    })
  }

  onLogout() {
    fetch('http://localhost:5000/logout')
      .then(response => {
        this.setState({
          logged_in: false,
          username: null
        })
      }).catch(err => {
        console.warn('logout failed', err)
      })
  }

  render() {
    switch (this.state.logged_in) {
    case null:
      return (
        <View style={styles.container}>
          <Splash />
        </View>
      )
      break
    case false:
      return <Login onLogin={this.onLogin.bind(this)} />
        break
    case true:
      return (
        <View style={styles.container}>
          <Text>Logged in as: {this.state.username}</Text>
          <Button
            title="Log Out"
            onPress={this.onLogout.bind(this)}
            />
        </View>
      )
      break
    default:
      throw new Error("wtf")
    }
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    flexDirection: 'column',
    justifyContent: 'center',
    padding: 20
  }
});
