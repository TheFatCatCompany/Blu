import 'package:crypto_app/widgets/actions/actions_widget.dart';
import 'package:crypto_app/widgets/balance_panel/balance_panel.dart';
import 'package:crypto_app/widgets/chart/chart_home_page.dart';
import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:unicons/unicons.dart';
import 'dart:async';
import 'package:crypto_app/BluetoothModule/Scanner.dart';
import 'package:permission_handler/permission_handler.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Timer? timer;
  BluetoothScanner scanner = BluetoothScanner();
  List<Widget> deviceWidgets = [];


  
  @override
  void initState() {
    super.initState();

    // Start periodic timer when widget is initialized
    requestPermissionsAndStartScan();

    timer = Timer.periodic(const Duration(seconds: 5), (Timer t) {
      updateValues();
    });
  }


  // What the hell
  Future<void> requestPermissionsAndStartScan() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.bluetooth,
      Permission.location,
    ].request();

    if (statuses[Permission.bluetooth] != PermissionStatus.granted ||
        statuses[Permission.location] != PermissionStatus.granted) {
      // Handle the case where permission is denied
      return;
    }

    scanner.scanDevices(); // Start Bluetooth scanning
  }

  @override
  void dispose() {
    // Cancel timer when widget is gone
    timer?.cancel();
    super.dispose();
  }

  void updateValues(){
    setState(() {
      // scan again for bluetooth devices
      try {
        scanner.scanDevices();
        deviceWidgets = scanner.getWidgets();
        while (deviceWidgets.isEmpty) {
          deviceWidgets = scanner.getWidgets();
          Future.delayed(const Duration(seconds: 5));
        }
      } catch (e) {}
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: themeData.backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40.0), //appbar size
        child: AppBar(
          bottomOpacity: 0.0,
          elevation: 0.0,
          shadowColor: Colors.transparent,
          backgroundColor: themeData.backgroundColor,
          leading: SizedBox(
            height: 10.w,
            width: 15.w,
          ),
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          leadingWidth: 15.w,
          title: Text(
            "StalkerRadar",
            style: TextStyle(
                color: themeData.brightness == Brightness.light
                ? Colors.black
                : Colors.white,
            ),
          ),
          centerTitle: true,
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 5.w),
              child: SizedBox(
                height: 3.5.h,
                width: 10.w,
                child: Container(
                  decoration: BoxDecoration(
                    color: themeData.primaryColor.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    UniconsLine.bell,
                    color: themeData.primaryColor,
                    size: 20.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 2.h),
          child: ListView(
            children: deviceWidgets,
          ),
        ),
      ),
    );
  }
}
