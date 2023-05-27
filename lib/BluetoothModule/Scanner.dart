import 'package:flutter/cupertino.dart';
import 'package:crypto_app/widgets/chart/discovered_device_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:permission_handler/permission_handler.dart';



class BluetoothScanner{
  Map<BluetoothDevice, int> currentDevicesMap = {};
  List<BluetoothDevice> pairedDevicesList = [];
  List<BluetoothDevice> discoveredDevicesList = [];

  //get list of discovered devices
  void scanDevices() async {
    List<BluetoothDevice> devices = await FlutterBlue.instance.startScan(timeout: Duration(seconds: 4));
    for (BluetoothDevice device in currentDevicesMap.keys) {
      if(!devices.contains(device)){
        currentDevicesMap.remove(device);
      }
    }
    for (BluetoothDevice device in devices) {
      if(!currentDevicesMap.containsKey(device)){
        currentDevicesMap[device] = 1;
      }
      else {
        currentDevicesMap[device] = currentDevicesMap[device]! + 1;
      }
    }
  }

  List<Widget> getWidgets() {
    List<Widget> widgets = [];

    ThemeData theme = ThemeData(
      primarySwatch: Colors.blue,
      brightness: Brightness.light,
      primaryColor: Colors.lightBlue[800],
      primaryColorBrightness: Brightness.dark,
      primaryColorLight: Colors.lightBlue[400],
      primaryColorDark: Colors.lightBlue[900],
      canvasColor: Colors.white,
      scaffoldBackgroundColor: Colors.white,
      bottomAppBarColor: Colors.white,
      cardColor: Colors.white,
      dividerColor: Colors.grey[400],
    );

    const IconData icon = Icons.favorite;

    for (BluetoothDevice b in currentDevicesMap.keys) {
      widgets.add(discovered_device_data_widget(true, icon, b.name, b.hashCode.toString(), b.type.toString(), 0.0, theme));
    }

    // checking if widgets acutally show up
    widgets.add(discovered_device_data_widget(true, icon, 'test', '69', 'fakedevice', 69.0, theme));

    return widgets;
  }



//get list of paired devices
  void getPairedDevices() async {
    List<BluetoothDevice> pairedDevices = await FlutterBlue.instance.connectedDevices;
    for (BluetoothDevice device in pairedDevices) {
      pairedDevicesList.add(device);
    }
  }


//connect to a device
  void connectToDevice(BluetoothDevice device) async {
    if (device.state == BluetoothDeviceState.disconnected) {
      await device.connect();
    }
  }
}
