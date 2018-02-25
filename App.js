import React, { Component } from 'react';
import { Platform, StyleSheet, Text, View, Button } from 'react-native';
import MyCustomModule from './components/MyCustomModule';

type Props = {};
export default class App extends Component<Props> {
  state = {
    name: ''
  };

  render() {
    return (
      <View style={styles.container}>
        <Text style={styles.welcome}>Welcome to React Native!</Text>
        <Text style={styles.instructions}>{this.state.name}</Text>
        <Button
          title="Say Hello"
          onPress={() =>
            MyCustomModule.hello('Anh Tuan Nguyen', name =>
              this.setState({ name })
            )
          }
        />
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF'
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5
  }
});
