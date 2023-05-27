import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
class BluetoothScanner{
  List<BluetoothDiscoveryResult> currentDevicesList = [];
  List<BluetoothDevice> pairedDevicesList = [];
  List<BluetoothDiscoveryResult> discoveredDevicesList = [];
  //get list of discovered devices

  List<BluetoothDiscoveryResult> devices() {
    FlutterBluetoothSerial.instance.startDiscovery().listen((r) {
      currentDevicesList.add(r);
    });
    return currentDevicesList;
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
