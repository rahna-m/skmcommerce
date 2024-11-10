import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:remixicon/remixicon.dart';
import 'package:sizer/sizer.dart';
import 'package:skmecom/utils/constants.dart';

import 'package:syncfusion_flutter_sliders/sliders.dart';

class FilterDrawer extends StatefulWidget {
  const FilterDrawer({super.key});

  @override
  State<FilterDrawer> createState() => _FilterDrawerState();
}

class _FilterDrawerState extends State<FilterDrawer> {
  bool _switchValue = true;
  bool checkedValue = false;
  bool checkedValue1 = false;
  bool checkedValue2 = false;
  bool checkedValue3 = false;
  bool priceRangeCheckedValue = false;
  double _value = 0.0;
  double feet = 0;
  String heightInFeet = "null";
  int height = 180;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      child: Drawer(
        child: SafeArea(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: Icon(
                      Remix.close_line,
                      size: 25,
                      color: AppColors.graycolor,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Filters",
                    style: TextStyle(
                        color: AppColors.textcolor,
                        fontSize: titleFontSize,
                        fontWeight: FontWeight.w600),
                  ),
                  Spacer(),
                  MaterialButton(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(color: AppColors.graycolor),
                      ),
                      color: AppColors.backgroundColor,
                      onPressed: () {},
                      child: Row(
                        children: [
                          Icon(
                            Remix.refresh_line,
                            size: 20,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Reset",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      )),
                  SizedBox(
                    width: 20,
                  )
                ],
              ),
              Divider(
                color: AppColors.graycolor,
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      width: 90.w,
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.graycolor),
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        children: [
                          FlutterSwitch(
                            height: 20.0,
                            width: 40.0,
                            padding: 4.0,
                            toggleSize: 15.0,
                            borderRadius: 10.0,
                            activeColor: AppColors.graycolor,
                            value: _switchValue,
                            onToggle: (value) {
                              setState(() {
                                _switchValue = value;
                              });
                            },
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Featured ?",
                            style: TextStyle(
                                color: AppColors.textcolor,
                                fontSize: secondayTitleFontSize,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 90.w,
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.graycolor),
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: Text(
                              "Categories",
                              style: TextStyle(
                                  color: AppColors.textcolor,
                                  fontSize: secondayTitleFontSize,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Divider(
                            color: AppColors.graycolor,
                            height: 0,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                TextButton(
                                    style: TextButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        minimumSize: Size.zero,
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        splashFactory: NoSplash.splashFactory),
                                    onPressed: () => setState(
                                        () => checkedValue = !checkedValue),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                              height: 24.0,
                                              width: 24.0,
                                              child: Checkbox(
                                                  value: checkedValue,
                                                  side: MaterialStateBorderSide
                                                      .resolveWith(
                                                    (states) => BorderSide(
                                                        width: 1.0,
                                                        color: AppColors
                                                            .graycolor),
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                      side: BorderSide(
                                                          color: AppColors
                                                              .graycolor,
                                                          width: 0.2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  onChanged: (value) {
                                                    setState(() =>
                                                        checkedValue = value!);
                                                  })),
                                          SizedBox(width: 10.0),
                                          Text(
                                            "Rolex",
                                            style: TextStyle(
                                                color: AppColors.textcolor,
                                                fontSize: titleFontSize),
                                          )
                                        ])),
                                SizedBox(
                                  height: 5,
                                ),
                                TextButton(
                                    style: TextButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        minimumSize: Size.zero,
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        splashFactory: NoSplash.splashFactory),
                                    onPressed: () => setState(
                                        () => checkedValue1 = !checkedValue1),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                              height: 24.0,
                                              width: 24.0,
                                              child: Checkbox(
                                                  value: checkedValue1,
                                                  side: MaterialStateBorderSide
                                                      .resolveWith(
                                                    (states) => BorderSide(
                                                        width: 1.0,
                                                        color: AppColors
                                                            .graycolor),
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                      side: BorderSide(
                                                          color: AppColors
                                                              .graycolor,
                                                          width: 0.2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  onChanged: (value) {
                                                    setState(() =>
                                                        checkedValue1 = value!);
                                                  })),
                                          SizedBox(width: 10.0),
                                          Text(
                                            "WHEY PROTEIN",
                                            style: TextStyle(
                                                color: AppColors.textcolor,
                                                fontSize: titleFontSize),
                                          )
                                        ])),
                                SizedBox(
                                  height: 5,
                                ),
                                TextButton(
                                    style: TextButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        minimumSize: Size.zero,
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        splashFactory: NoSplash.splashFactory),
                                    onPressed: () => setState(
                                        () => checkedValue2 = !checkedValue2),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                              height: 24.0,
                                              width: 24.0,
                                              child: Checkbox(
                                                  side: MaterialStateBorderSide
                                                      .resolveWith(
                                                    (states) => BorderSide(
                                                        width: 1.0,
                                                        color: AppColors
                                                            .graycolor),
                                                  ),
                                                  value: checkedValue2,
                                                  shape: RoundedRectangleBorder(
                                                      side: BorderSide(
                                                          color: AppColors
                                                              .graycolor,
                                                          width: 0.2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  onChanged: (value) {
                                                    setState(() =>
                                                        checkedValue2 = value!);
                                                  })),
                                          SizedBox(width: 10.0),
                                          Text(
                                            "Rechard Mille",
                                            style: TextStyle(
                                                color: AppColors.textcolor,
                                                fontSize: titleFontSize),
                                          )
                                        ])),
                                SizedBox(
                                  height: 5,
                                ),
                                TextButton(
                                    style: TextButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        minimumSize: Size.zero,
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        splashFactory: NoSplash.splashFactory),
                                    onPressed: () => setState(
                                        () => checkedValue3 = !checkedValue3),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                              height: 24.0,
                                              width: 24.0,
                                              child: Checkbox(
                                                  side: MaterialStateBorderSide
                                                      .resolveWith(
                                                    (states) => BorderSide(
                                                        width: 1.0,
                                                        color: AppColors
                                                            .graycolor),
                                                  ),
                                                  value: checkedValue3,
                                                  shape: RoundedRectangleBorder(
                                                      side: BorderSide(
                                                          color: AppColors
                                                              .graycolor,
                                                          width: 0.2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  onChanged: (value) {
                                                    setState(() =>
                                                        checkedValue3 = value!);
                                                  })),
                                          SizedBox(width: 10.0),
                                          Text(
                                            "Gainer",
                                            style: TextStyle(
                                                color: AppColors.textcolor,
                                                fontSize: titleFontSize),
                                          )
                                        ])),
                                SizedBox(
                                  height: 10,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 90.w,
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.graycolor),
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: Row(
                              children: [
                                Text(
                                  "Price Range",
                                  style: TextStyle(
                                      color: AppColors.textcolor,
                                      fontSize: secondayTitleFontSize,
                                      fontWeight: FontWeight.w600),
                                ),
                                Spacer(),
                                SizedBox(
                                    height: 24.0,
                                    width: 24.0,
                                    child: Checkbox(
                                        value: priceRangeCheckedValue,
                                        side:
                                            MaterialStateBorderSide.resolveWith(
                                          (states) => BorderSide(
                                              width: 1.0,
                                              color: AppColors.graycolor),
                                        ),
                                        shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                color: AppColors.graycolor,
                                                width: 0.2),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        onChanged: (value) {
                                          setState(() =>
                                              priceRangeCheckedValue = value!);
                                        })),
                              ],
                            ),
                          ),
                          Divider(
                            color: AppColors.graycolor,
                            height: 0,
                          ),
                          SfSlider(
                            min: 0.0,
                            max: 10000.0,
                            value: _value,
                            interval: 2500,
                            stepSize: 100,
                            showTicks: true,
                            showLabels: true,
                            enableTooltip: true,
                            showDividers: true,
                            minorTicksPerInterval: 0,
                            activeColor: AppColors.primarycolor,
                            inactiveColor: AppColors.graycolor,
                            labelPlacement: LabelPlacement.onTicks,
                            labelFormatterCallback:
                                (actualValue, formattedText) {
                              print(actualValue);
                              print(formattedText);
                              formattedText = "\u{20B9}" +
                                  (actualValue / 1000).toString() +
                                  "K";
                              return formattedText;
                            },
                            onChanged: (dynamic value) {
                              setState(() {
                                _value = value;
                              });
                            },
                          ),
                          SizedBox(
                            height: 40,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
