import 'package:flutter/cupertino.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:crypto_app/widgets/chart/discovered_device_data_widget.dart';
import 'package:flutter/material.dart';


class BluetoothScanner{
  List<BluetoothDiscoveryResult> currentDevicesList = [];
  List<BluetoothDevice> pairedDevicesList = [];
  List<BluetoothDiscoveryResult> discoveredDevicesList = [];
  //get list of discovered devices

  Future<List<BluetoothDiscoveryResult>> devices() async {
    await FlutterBluetoothSerial.instance.startDiscovery().listen((r) {
      debugPrint('what');
      currentDevicesList.add(r);
    }).asFuture();

    return currentDevicesList;
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

    for (BluetoothDiscoveryResult b in currentDevicesList) {
      widgets.add(discovered_device_data_widget(true, icon, b.device.name!, b.device.address, b.device.type.stringValue, 0.0, theme));
    }

    // checking if widgets acutally show up
    widgets.add(discovered_device_data_widget(true, icon, 'test', '69', 'fakedevice', 69.0, theme));

    return widgets;
  }



//get list of paired devices
  List<BluetoothDevice> pairedDevices() {
    List<BluetoothDevice> devices = [];
    FlutterBluetoothSerial.instance.getBondedDevices().then((r) {
      devices = r;
    });
    return devices;
  }

//connect to a device
  void connect(BluetoothDevice device) {
    BluetoothConnection.toAddress(device.address).then((r) {
      print('Connected to the device');
    });
  }
}
