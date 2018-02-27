import React, { Component } from 'react';
import {
  Platform,
  StyleSheet,
  Text,
  View,
  Button,
  ScrollView,
  Switch,
  NativeEventEmitter,
  TextInput
} from 'react-native';
import MyCustomModule from './components/MyCustomModule';

type Props = {};
const myCustomModuleEmitter = new NativeEventEmitter(MyCustomModule);
export default class App extends Component<Props> {
  state = {
    data: '',
    ping: true,
    delay: '0'
  };

  componentDidMount() {
    this.subscription = myCustomModuleEmitter.addListener(
      'addEvent',
      reminder => this.setState({ data: JSON.stringify(reminder) })
    );
  }

  componentWillUnmount() {
    this.subscription.remove();
  }

  render() {
    return (
      <View style={styles.container}>
        <Text style={styles.welcome}>AGILETECH</Text>
        <ScrollView
          style={{
            width: '100%',
            backgroundColor: '#ccc',
            padding: 10
          }}
        >
          <Text style={styles.instructions}>{this.state.data}</Text>
        </ScrollView>
        <View style={{ flex: 1 }}>
          <Button
            title="Say Hello"
            onPress={() =>
              MyCustomModule.hello('Anh Tuan Nguyen', data =>
                this.setState({ data })
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
                data => this.setState({ data: JSON.stringify(data) })
              )
            }
          />
          <View
            style={{
              flexDirection: 'row',
              justifyContent: 'flex-start',
              alignItems: 'center'
            }}
          >
            <View
              style={{
                flexDirection: 'row',
                justifyContent: 'flex-start',
                alignItems: 'center'
              }}
            >
              <Text>PingPong state: </Text>
              <Switch
                value={this.state.ping}
                onValueChange={ping => this.setState({ ping })}
              />
            </View>
            <View
              style={{
                flexDirection: 'row',
                justifyContent: 'flex-start',
                alignItems: 'center',
                marginLeft: 10
              }}
            >
              <Text>Delay(s): </Text>
              <TextInput
                placeholder="Time to delay execute promise"
                value={this.state.delay}
                onChangeText={delay => this.setState({ delay })}
                underlineColorAndroid="transparent"
                style={{
                  height: 40,
                  width: 40,
                  backgroundColor: '#ccc',
                  textAlign: 'center',
                  marginLeft: 10
                }}
              />
            </View>
          </View>
          <Button
            title="async/await"
            onPress={() => {
              console.log('1) before promise');
              MyCustomModule.pingPong(
                this.state.ping,
                parseInt(this.state.delay)
              )
                .then(data =>
                  this.setState({ data: JSON.stringify(data) }, () =>
                    console.log('2) promise resolved')
                  )
                )
                .catch(data =>
                  this.setState({ data: data.message }, () =>
                    console.log('2) promise rejected')
                  )
                );
              console.log('3) after promise');
            }}
          />
          <Button
            title="Add Event"
            onPress={() =>
              MyCustomModule.addEvent('addEvent', {
                location: 'Up@Vpbank, 89 Lang Ha',
                time: new Date().toISOString()
              })
            }
          />
        </View>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
    padding: 20
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
