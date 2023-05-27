import 'dart:ffi';

import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:crypto_app/pages/device_details_page.dart';

Padding discovered_device_data_widget(
   bool isHomePage,
   IconData deviceIcon,
   String deviceName,
   String deviceCode,
   String deviceType,
   double signalStrength,
   ThemeData themeData,
   ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
        child: Center(
          child: GestureDetector(
            onTap: () => Get.to(
              () => DeviceDetailsPage(
                deviceIcon: deviceIcon,
                deviceName: deviceName,
                deviceCode: deviceCode,
                deviceType: deviceType,
                signalStrength: signalStrength,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: 2,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 2.h,
                  horizontal: 2.w,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 2.w),
                      child: Row(
                        children: [
                          Icon(
                            deviceIcon,
                            color: Colors.white,
                            size: 20.sp,
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Text(
                            deviceName,
                            style: GoogleFonts.lato(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 13.sp,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 2.w),
                      child: Row(
                        children: [
                          Text(
                            deviceCode,
                            style: GoogleFonts.lato(
                              color: Colors.white.withOpacity(0.7),
                              fontWeight: FontWeight.bold,
                              fontSize: 10.sp,
                              letterSpacing: 1,
                            ),
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Text(
                            deviceType,
                            style: GoogleFonts.lato(
                              color: Colors.white.withOpacity(0.7),
                              fontWeight: FontWeight.bold,
                              fontSize: 10.sp,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 2.w),
                      child: Row(
                        children: [
                          Text(
                            signalStrength.toString(),
                            style: GoogleFonts.lato(
                              color: Colors.white.withOpacity(0.7),
                              fontWeight: FontWeight.bold,
                              fontSize: 10.sp,
                              letterSpacing: 1,
                            ),
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
    );
}
