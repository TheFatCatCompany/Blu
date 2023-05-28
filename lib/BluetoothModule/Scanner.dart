import 'package:flutter/cupertino.dart';
import 'package:crypto_app/widgets/chart/discovered_device_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:math';

class CustomBluetoothDevice {
  int hCode;
  BluetoothDevice device;
  CustomBluetoothDevice(BluetoothDevice b): device=b, hCode=b.hashCode;

  @override
  int get hashCode => hCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is CustomBluetoothDevice &&
              runtimeType == other.runtimeType &&
              hCode == other.hCode;
}


class DeviceData {
  int cycles = 1;
  int prevRssi;
  int rssi;

  DeviceData(int rssiVal): prevRssi=rssiVal, rssi=rssiVal;
}


class BluetoothScanner{
  Map<CustomBluetoothDevice, DeviceData> currentDevicesMap = {};
  List<BluetoothDevice> pairedDevicesList = [];
  List<BluetoothDevice> discoveredDevicesList = [];
  List<BluetoothDevice> ignoreDevicesList = [];
  List<ScanResult> results = [];
  Set<int> ignoreDevicesSet = {};
  FlutterBlue flutterBlue = FlutterBlue.instance;

  //function to produce danger value between 0.0 and 1.0
  double dangerValue(int currentrssi, int previousrssi, int cycle)
  {
    double danger = 0.0;
    double rssi = currentrssi.toDouble();
    double prssi = previousrssi.toDouble();
    double c = cycle.toDouble();
    double r = rssi-prssi;
    danger = (c/100 + (r*0.005)).clamp(0.0, 1.0);
    return danger;
  }

  //get list of discovered devices
  void scanDevices() async {
    results = await flutterBlue.startScan(timeout: const Duration(seconds: 7));

    List<CustomBluetoothDevice> devices = results.map((result) => CustomBluetoothDevice(result.device)).toList();
    List<int> tmpRssi = results.map((results) => results.rssi).toList();
    List<CustomBluetoothDevice> currentDevicesKeys = currentDevicesMap.keys.toList();
    Map<CustomBluetoothDevice, DeviceData> mapcopy = Map.from(currentDevicesMap);

    for (CustomBluetoothDevice device in currentDevicesKeys) {
      if (!devices.contains(device)) {
        currentDevicesMap.remove(device); // no longer in range
      }
    }

    devices.asMap().forEach((idx, device) {
      // If a new device is found
      if (!currentDevicesMap.containsKey(device)) {
        currentDevicesMap[device] = DeviceData(tmpRssi[idx]);
      }
      else {
        // Else the device is still in range
        currentDevicesMap[device]!.cycles += 1;
        currentDevicesMap[device]!.prevRssi = currentDevicesMap[device]!.rssi;
        currentDevicesMap[device]!.rssi = tmpRssi[idx];
      }
    });

    if (currentDevicesMap.isEmpty) {currentDevicesMap = Map.from(mapcopy); }
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
    currentDevicesMap = Map.fromEntries(currentDevicesMap.entries.toList()..sort((a, b) => dangerValue(b.value.rssi, b.value.prevRssi, b.value.cycles).compareTo(dangerValue(a.value.rssi, a.value.prevRssi, a.value.cycles))));
    for (CustomBluetoothDevice bt in currentDevicesMap.keys) {
      BluetoothDevice b = bt.device;
      widgets.add(discovered_device_data_widget(true, icon, b.name, b.hashCode.toString(), b.type.toString(), dangerValue(currentDevicesMap[bt]!.rssi, currentDevicesMap[bt]!.prevRssi, currentDevicesMap[bt]!.cycles), theme, this));
    }

    // checking if widgets actually show up
    widgets.add(discovered_device_data_widget(true, icon, 'Updating...', '69', 'fakedevice', 69.0, theme, this));
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

  void ignoreDevice(String deviceID){
    ignoreDevicesSet.add(int.parse(deviceID));
  }

  void unignoreDevice(String deviceID){
    ignoreDevicesSet.remove(int.parse(deviceID));
  }

}
