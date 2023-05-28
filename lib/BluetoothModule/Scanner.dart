import 'package:flutter/cupertino.dart';
import 'package:crypto_app/widgets/chart/discovered_device_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:math';

class CustomBluetoothDevice {
  BluetoothDevice device;
  int rssi = 0;
  CustomBluetoothDevice(BluetoothDevice b, int val): device=b, rssi=val;
}


class BluetoothScanner{
  Map<CustomBluetoothDevice, int> currentDevicesMap = {};
  List<BluetoothDevice> pairedDevicesList = [];
  List<BluetoothDevice> discoveredDevicesList = [];
  List<BluetoothDevice> ignoreDevicesList = [];
  List<ScanResult> results = [];
  FlutterBlue flutterBlue = FlutterBlue.instance;

  //get list of discovered devices
  void scanDevices() async {
    results = await flutterBlue.startScan(timeout: Duration(seconds: 3));

    List<CustomBluetoothDevice> devices = results.map((result) => CustomBluetoothDevice(result.device, result.rssi)).toList();

    devices.sort((a, b) {
      if (a.device!.name.isNotEmpty && b.device!.name.isNotEmpty) {
        return a.device!.name.compareTo(b.device!.name);
      } else if (a.device!.name.isNotEmpty) {
        return -1; // a has a name, b doesn't have a name (b should come after a)
      } else if (b.device!.name.isNotEmpty) {
        return 1; // b has a name, a doesn't have a name (a should come after b)
      } else {
        return 0; // both a and b don't have names (order doesn't matter)
      }
    });
    List<CustomBluetoothDevice> currentDevicesKeys = currentDevicesMap.keys.toList();
    for (CustomBluetoothDevice device in currentDevicesKeys) {
      if(!devices.contains(device)){
        currentDevicesMap.remove(device);
      }
    }
    for (CustomBluetoothDevice device in devices) {
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

    for (CustomBluetoothDevice bt in currentDevicesMap.keys) {
      BluetoothDevice b = bt.device;
      widgets.add(discovered_device_data_widget(true, icon, b.name, b.hashCode.toString(), b.type.toString(), currentDevicesMap[bt]!.toDouble(), theme));
    }

    // checking if widgets actually show up
    widgets.add(discovered_device_data_widget(true, icon, 'Updating...', '69', 'fakedevice', 69.0, theme));
    return widgets;
  }

  double beaconToMeter(int measuredPower, int rssi, int n){
    double temp1 = (measuredPower - rssi)/(10 * n);
    double meters = pow(10.0,temp1).toDouble();
    return meters;
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
