import React, { Component } from 'react';
import { Platform, StyleSheet, Text, View, Button } from 'react-native';
import MyCustomModule from './components/MyCustomModule';

type Props = {};
export default class App extends Component<Props> {
  state = {
    name: '',
    ping: 'ping'
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
        <Button
          title="Person info"
          onPress={() =>
            MyCustomModule.personInfo(
              'Anh Tuan',
              'Nguyen',
              29,
              300.012,
              true,
              [1, 'two', 'three'],
              {
                key: 'Key',
                value: 'Value',
                latitude: 21.001382,
                longitude: 105.806933
              },
              data => console.log('data', data)
            )
          }
        />
        <Button
          title="async/await"
          onPress={() =>
            MyCustomModule.pingPong(false)
              .then(data => console.log('pong', data))
              .catch(e => console.log('pong rejected', e))
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
