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
    Alert.alert(this.state.username + ', ' + this.state.password);
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
  // button: {
  //   alignItems: 'center',
  //   justifyContent: 'center',
  //   padding: 20
  // },
  // labelContainer: {
  //   marginBottom: 20
  // },
  // textLabel: {
  //   fontSize: 20,
  //   fontWeight: 'bold',
  //   fontFamily: 'Verdana',
  //   marginBottom: 10,
  //   color: '#595856'
  // },
  // scroll: {
  //   backgroundColor: '#E1D7D8',
  //   padding: 30,
  //   flexDirection: 'column'
  // },
  // alignRight: {
  //   alignSelf: 'flex-end'
  // },
  // label: {
  //   color: '#0d8898',
  //   fontSize: 20
  // }
});
