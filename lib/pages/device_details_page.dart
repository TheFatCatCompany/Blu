
import 'package:crypto_app/widgets/chart/chart.dart';
import 'package:crypto_app/widgets/chart/chart_sort_widget.dart';
import 'package:crypto_app/widgets/circular_danger_indicator.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:unicons/unicons.dart';

class DeviceDetailsPage extends StatefulWidget {
  final IconData deviceIcon;
  final String deviceName;
  final String deviceCode;
  final String deviceType;
  final double signalStrength;
  const DeviceDetailsPage({
    Key? key,
    required this.deviceIcon,
    required this.deviceName,
    required this.deviceCode,
    required this.deviceType,
    required this.signalStrength,
  }) : super(key: key);

  @override
  _DeviceDetailsPageState createState() => _DeviceDetailsPageState();
}

class _DeviceDetailsPageState extends State<DeviceDetailsPage> {
  @override
  void initState() {
    super.initState();
  }

  Rx<double> totalSpotsValue = 0.0.obs;
  Rx<int> selectedSort = 2.obs;
  List sortStrings = [
    '1H',
    '1D',
    '1W',
    '1M',
    '1Y',
  ];
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
          leading: Padding(
            padding: EdgeInsets.only(left: 5.w),
            child: SizedBox(
              height: 3.5.h,
              width: 10.w,
              child: InkWell(
                onTap: () => Get.back(),
                child: Container(
                  decoration: BoxDecoration(
                    color: themeData.primaryColor.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    UniconsLine.angle_left,
                    color: themeData.primaryColor,
                    size: 20.sp,
                  ),
                ),
              ),
            ),
          ),
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          leadingWidth: 15.w,
          title: Text(
            widget.deviceName,
            style: GoogleFonts.lato(
              color: themeData.primaryColor,
              fontWeight: FontWeight.w600,
              fontSize: 16.sp,
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
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 2.h),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.5.w),
                  child: Container(
                    decoration: BoxDecoration(
                      color: themeData.primaryColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Icon(
                        widget.deviceIcon,
                        size: 80.sp,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 0.5.h),
              child: Center(
                child: Text(
                  widget.deviceName,
                  style: GoogleFonts.lato(
                    letterSpacing: 1,
                    color: themeData.primaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 20.sp,
                  ),
                ),
              ),
            ),
            Center(
              child: Text(
                ' ${widget.deviceCode}/${widget.deviceType}',
                style: GoogleFonts.lato(
                  letterSpacing: 1,
                  color: themeData.primaryColor,
                  fontWeight: FontWeight.w300,
                  fontSize: 15.sp,
                ),
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 1.h, bottom: 3.h),
              child: Center(
                child: Container(
                  width: 95.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(

                      child: SizedBox(
                        width: 85.w,
                        height: 30.h,
                        child: Stack(
                            children:[circular_danger_indicator(
                              fraction: 0.5,
                              height: 250,
                              width: 250,
                            ),
                              Center(child:Text((0.5*100).toString(), style: TextStyle(fontSize: 30, color: Colors.white)))
                            ]
                        )
                        )
                      ),
                    ),
                  ),
                ),
              ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              child: SizedBox(
                height: 5.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: sortStrings.length,
                  itemBuilder: (BuildContext context, int i) {
                    return Obx(() => i == selectedSort.value
                        ? GestureDetector(
                        onTap: () => selectedSort.value = i,
                        child: chartSortWidget(
                            sortStrings[i], true, themeData))
                        : GestureDetector(
                        onTap: () => selectedSort.value = i,
                        child: chartSortWidget(
                            sortStrings[i], false, themeData)));
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5.h, left: 5.w, right: 5.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {}, //TODO: add sell action
                    splashColor:
                    themeData.secondaryHeaderColor.withOpacity(0.5),
                    highlightColor:
                    themeData.secondaryHeaderColor.withOpacity(0.8),
                    child: Container(
                      decoration: BoxDecoration(
                        color: themeData.primaryColor.withOpacity(0.05),
                        border: Border.all(
                          color: themeData.secondaryHeaderColor,
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: 43.w,
                      height: 7.h,
                      child: Center(
                        child: Text(
                          'Sell',
                          style: GoogleFonts.lato(
                            color: themeData.primaryColor.withOpacity(0.7),
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {}, //TODO: add buy action
                    splashColor: themeData.primaryColor,
                    highlightColor: themeData.primaryColor,
                    child: Container(
                      decoration: BoxDecoration(
                        color: themeData.secondaryHeaderColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: 43.w,
                      height: 7.h,
                      child: Center(
                        child: Text(
                          'Buy',
                          style: GoogleFonts.lato(
                            color: Colors.white.withOpacity(0.8),
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
