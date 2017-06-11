import React, { Component } from 'react';

import {
  Alert,
  Button,
  StyleSheet,
  Text,
  View,
  TextInput,
} from 'react-native';

const FormInput = (props) => {
  return (
    <TextInput
      style={styles.textInput}
      onChangeText={(text) => props.onChange(text)}
      value={props.value}
      secureTextEntry={!!props.isPassword}
      placeholder={props.placeholder}
    />
  );
}

export default class Login extends Component {
  constructor(props) {
    super(props);
    this.state = { username: null, password: null };
  }

  onChange = (field) => {
    return (text) => {
      this.setState({[field]: text})
    }
  }

  submitForm = () => {
    fetch('http://localhost:5000/login', {
      method: 'POST',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        'login-username': this.state.username,
        'login-password': this.state.password,
      })
    })
      .then((response) => {
        return response.json()
      })
      .then((responseJson) => {
        if (responseJson.verified) {
          this.props.onLogin(responseJson.username)
        } else {
          console.warn('Invalid login')
        }
      })
      .catch((error) => {
        console.error(error);
      });
  }

  render() {
    return (
      <View style={styles.loginForm}>
        <FormInput
          placeholder="Username"
          value={this.state.username}
          onChange={this.onChange("username")}
        />

        <FormInput
          placeholder="Password"
          value={this.state.password}
          isPassword={true}
          onChange={this.onChange("password")}
        />

        <Button
          onPress={this.submitForm}
          title="Sign in"
          color="#841584"
        />
      </View>
    );
  }
}

const styles = StyleSheet.create({
  textInput: {
    height: 40,
    borderColor: 'gray',
    borderWidth: 1,
    padding: 5,
    margin: 10
  },
  loginForm: {
    flex: 1,
    flexDirection: 'column',
    justifyContent: 'center',
    padding: 20
  }
});
