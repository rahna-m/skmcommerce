// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_switch/flutter_switch.dart';
// import 'package:remixicon/remixicon.dart';
// import 'package:sizer/sizer.dart';
// import 'package:skmecom/model/category_model.dart';
// import 'package:skmecom/pocketbase_service.dart';
// import 'package:skmecom/services/filtersingleton.dart';
// import 'package:skmecom/utils/constants.dart';

// import 'package:syncfusion_flutter_sliders/sliders.dart';
// import 'package:syncfusion_flutter_core/theme.dart';

// class FilterDrawer extends StatefulWidget {
//   const FilterDrawer({super.key});

//   @override
//   State<FilterDrawer> createState() => _FilterDrawerState();
// }

// class _FilterDrawerState extends State<FilterDrawer> {
//   bool _switchValue = true;
//   bool checkedValue = false;
//   bool checkedValue1 = false;
//   bool checkedValue2 = false;
//   bool checkedValue3 = false;
//   bool priceRangeCheckedValue = false;
//   double _value = 0.0;
//   double feet = 0;
//   String heightInFeet = "null";
//   int height = 180;
//   bool _loading = true;
//   final PocketBaseService pocketBaseService = PocketBaseService();
//   List<CategoryModel> categories = [];

//   Future<void> fetchCategories() async {
//     final categoriesJson = await pocketBaseService.fetchCategories();

//     setState(() {
//       categories =
//           categoriesJson.map((cat) => CategoryModel.fromJson(cat)).toList();
//       setState(() {
//         _loading = false;
//       });
//     });
//     print("cat: $categories");
//   }

//   @override
//   void initState() {
//     // TODO: implement initState

//     fetchCategories();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 100.w,
//       child: Drawer(
//         child: SafeArea(
//           child: ListView(
//             // Important: Remove any padding from the ListView.
//             padding: EdgeInsets.zero,
//             children: [
//               Row(
//                 children: [
//                   SizedBox(
//                     width: 20,
//                   ),
//                   InkWell(
//                     onTap: () => Navigator.of(context).pop(),
//                     child: Icon(
//                       Remix.close_line,
//                       size: 25,
//                       color: AppColors.graycolor,
//                     ),
//                   ),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   Text(
//                     "Filters",
//                     style: TextStyle(
//                         color: AppColors.textcolor,
//                         fontSize: titleFontSize,
//                         fontWeight: FontWeight.w600),
//                   ),
//                   Spacer(),
//                   MaterialButton(
//                       elevation: 0,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                         side: const BorderSide(color: AppColors.graycolor),
//                       ),
//                       color: AppColors.backgroundColor,
//                       onPressed: () {
//                         FilterSingleton.instance.resetFilter();
//                         setState(() {});
//                       },
//                       child: Row(
//                         children: [
//                           Icon(
//                             Remix.refresh_line,
//                             size: 20,
//                             color: Colors.black,
//                           ),
//                           SizedBox(
//                             width: 10,
//                           ),
//                           Text(
//                             "Reset",
//                             style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 16.sp,
//                                 fontWeight: FontWeight.w500),
//                           ),
//                         ],
//                       )),
//                   SizedBox(
//                     width: 20,
//                   )
//                 ],
//               ),
//               Divider(
//                 color: AppColors.graycolor,
//               ),
//               SizedBox(
//                 height: 40,
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 12),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       padding:
//                           EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//                       width: 90.w,
//                       decoration: BoxDecoration(
//                           border: Border.all(color: AppColors.graycolor),
//                           borderRadius: BorderRadius.circular(8)),
//                       child: Row(
//                         children: [
//                           FlutterSwitch(
//                             height: 20.0,
//                             width: 40.0,
//                             padding: 4.0,
//                             toggleSize: 15.0,
//                             borderRadius: 10.0,
//                             inactiveColor: AppColors.graycolor,
//                             activeColor: AppColors.primarycolor,
//                             value: FilterSingleton.instance.featuredFlag,
//                             onToggle: (value) {
//                               FilterSingleton.instance.setFeatured();
//                               setState(() {});
//                             },
//                           ),
//                           SizedBox(
//                             width: 20,
//                           ),
//                           Text(
//                             "Featured ?",
//                             style: TextStyle(
//                                 color: AppColors.textcolor,
//                                 fontSize: secondayTitleFontSize,
//                                 fontWeight: FontWeight.w600),
//                           )
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Container(
//                       width: 90.w,
//                       decoration: BoxDecoration(
//                           border: Border.all(color: AppColors.graycolor),
//                           borderRadius: BorderRadius.circular(8)),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Padding(
//                             padding: EdgeInsets.symmetric(
//                                 vertical: 10, horizontal: 10),
//                             child: Text(
//                               "Categories",
//                               style: TextStyle(
//                                   color: AppColors.textcolor,
//                                   fontSize: secondayTitleFontSize,
//                                   fontWeight: FontWeight.w600),
//                             ),
//                           ),
//                           Divider(
//                             color: AppColors.graycolor,
//                             height: 0,
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 10, vertical: 10),
//                             child: Column(
//                                 children: categories.map((e) {
//                               return TextButton(
//                                   style: TextButton.styleFrom(
//                                       padding: EdgeInsets.zero,
//                                       minimumSize: Size.zero,
//                                       tapTargetSize:
//                                           MaterialTapTargetSize.shrinkWrap,
//                                       splashFactory: NoSplash.splashFactory),
//                                   onPressed: () {
//                                     // FilterSingleton.instance.setFilter(e.id);
//                                     // setState(() {});
//                                   },
//                                   child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.start,
//                                       children: [
//                                         SizedBox(
//                                             height: 24.0,
//                                             width: 24.0,
//                                             child: Checkbox(
//                                                 value: FilterSingleton
//                                                     .instance.SeletedCategory
//                                                     .contains(e.id),
//                                                 side: MaterialStateBorderSide
//                                                     .resolveWith(
//                                                   (states) => BorderSide(
//                                                       width: 1.0,
//                                                       color:
//                                                           AppColors.graycolor),
//                                                 ),
//                                                 shape: RoundedRectangleBorder(
//                                                     side: BorderSide(
//                                                         color:
//                                                             AppColors.graycolor,
//                                                         width: 0.2),
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             5)),
//                                                 onChanged: (value) {
//                                                   FilterSingleton.instance
//                                                       .setFilter(e.id);
//                                                   setState(() {});
//                                                   // setState(() =>
//                                                   //     checkedValue = value!);
//                                                 })),
//                                         SizedBox(width: 10.0),
//                                         Text(
//                                           "${e.title}",
//                                           style: TextStyle(
//                                               color: AppColors.textcolor,
//                                               fontSize: secondayTitleFontSize,
//                                               fontWeight: FontWeight.w100),
//                                         )
//                                       ]));
//                             }).toList()),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Container(
//                       width: 90.w,
//                       decoration: BoxDecoration(
//                           border: Border.all(color: AppColors.graycolor),
//                           borderRadius: BorderRadius.circular(8)),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Padding(
//                             padding: EdgeInsets.symmetric(
//                                 vertical: 10, horizontal: 10),
//                             child: Row(
//                               children: [
//                                 Text(
//                                   "Price Range",
//                                   style: TextStyle(
//                                       color: AppColors.textcolor,
//                                       fontSize: secondayTitleFontSize,
//                                       fontWeight: FontWeight.w600),
//                                 ),
//                                 Spacer(),
//                                 SizedBox(
//                                     height: 24.0,
//                                     width: 24.0,
//                                     child: Checkbox(
//                                         value: FilterSingleton
//                                             .instance.priceRangeFlag,
//                                         side:
//                                             MaterialStateBorderSide.resolveWith(
//                                           (states) => BorderSide(
//                                               width: 1.0,
//                                               color: AppColors.graycolor),
//                                         ),
//                                         shape: RoundedRectangleBorder(
//                                             side: BorderSide(
//                                                 color: AppColors.graycolor,
//                                                 width: 0.2),
//                                             borderRadius:
//                                                 BorderRadius.circular(5)),
//                                         onChanged: (value) {
//                                           FilterSingleton.instance
//                                               .togglePriceRage();
//                                           setState(() {});
//                                         })),
//                               ],
//                             ),
//                           ),
//                           Divider(
//                             color: AppColors.graycolor,
//                             height: 0,
//                           ),
//                           SfRangeSliderTheme(
//                             data: SfRangeSliderThemeData(
//                               thumbColor: Colors.white,
//                               thumbStrokeWidth: 1,
//                               thumbStrokeColor: AppColors.primarycolor,
//                             ),
//                             child: SfRangeSlider(
//                               min: 0.0,
//                               max: 10000.0,
//                               values: FilterSingleton.instance.priceRange,
//                               interval: 2500,
//                               stepSize: 100,
//                               showTicks: true,
//                               showLabels: true,
//                               enableTooltip: true,
//                               showDividers: true,
//                               minorTicksPerInterval: 0,
//                               // activeColor: AppColors.primarycolor,
//                               inactiveColor: AppColors.graycolor,
//                               labelPlacement: LabelPlacement.onTicks,
//                               labelFormatterCallback:
//                                   (actualValue, formattedText) {
//                                 print(actualValue);
//                                 print(formattedText);
//                                 formattedText = "\u{20B9}" +
//                                     (actualValue / 1000).toString() +
//                                     "K";
//                                 return formattedText;
//                               },
//                               onChanged: FilterSingleton.instance.priceRangeFlag
//                                   ? (SfRangeValues values) {
//                                       FilterSingleton.instance
//                                           .setPriceRange(values);
//                                       setState(() {});
//                                     }
//                                   : null,
//                             ),
//                           ),
//                           SizedBox(
//                             height: 40,
//                           )
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:remixicon/remixicon.dart';
import 'package:sizer/sizer.dart';
import 'package:skmecom/model/category_model.dart';
import 'package:skmecom/pocketbase_service.dart';
import 'package:skmecom/services/filtersingleton.dart';
import 'package:skmecom/utils/constants.dart';

import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syncfusion_flutter_core/theme.dart';

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
  bool _loading = true;
  final PocketBaseService pocketBaseService = PocketBaseService();
  List<CategoryModel> categories = [];

  Future<void> fetchCategories() async {
    final categoriesJson = await pocketBaseService.fetchCategories();

    setState(() {
      categories =
          categoriesJson.map((cat) => CategoryModel.fromJson(cat)).toList();
      setState(() {
        _loading = false;
      });
    });
    print("cat: $categories");
  }

  @override
  void initState() {
    // TODO: implement initState

    fetchCategories();
  }

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
                    onTap: () {
                      // Construct the filter query
                      final selectedCategory = FilterSingleton.instance.selectedCategory.isNotEmpty
                          ? '(category = "${FilterSingleton.instance.selectedCategory.first}")'
                          : '';
                      final priceRange = FilterSingleton.instance.priceRangeFlag
                          ? '(discount_price >= ${FilterSingleton.instance.priceRange.start} && discount_price <= ${FilterSingleton.instance.priceRange.end})'
                          : '';
                      final featured = FilterSingleton.instance.featuredFlag
                          ? '(featured = true)'
                          : '';

                      // Combine the filters
                      String filterQuery = '';
                      if (selectedCategory.isNotEmpty) filterQuery += selectedCategory;
                      if (priceRange.isNotEmpty) {
                        filterQuery += filterQuery.isNotEmpty ? ' && $priceRange' : priceRange;
                      }
                      if (featured.isNotEmpty) {
                        filterQuery += filterQuery.isNotEmpty ? ' && $featured' : featured;
                      }

                      // Pass the filter query back
                      Navigator.of(context).pop(filterQuery); // Pass query back on close
                    },


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
                      onPressed: () {
                        FilterSingleton.instance.resetFilter();
                        setState(() {});
                      },
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
                            inactiveColor: AppColors.graycolor,
                            activeColor: AppColors.primarycolor,
                            value: FilterSingleton.instance.featuredFlag,
                            onToggle: (value) {
                              FilterSingleton.instance.setFeatured();
                              setState(() {});
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
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Column(
                                children: categories.map((e) {
                              return TextButton(
                                  style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      minimumSize: Size.zero,
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      splashFactory: NoSplash.splashFactory),
                                  onPressed: () {
                                    // FilterSingleton.instance.setFilter(e.id);
                                    // setState(() {});
                                  },
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                            height: 24.0,
                                            width: 24.0,
                                            child: Checkbox(
                                                value:
                                                FilterSingleton.instance.selectedCategory.contains(e.id),
                                                side: MaterialStateBorderSide
                                                    .resolveWith(
                                                  (states) => BorderSide(
                                                      width: 1.0,
                                                      color:
                                                          AppColors.graycolor),
                                                ),
                                                shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                        color:
                                                            AppColors.graycolor,
                                                        width: 0.2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                onChanged: (value) {
                                                  FilterSingleton.instance
                                                      .setFilter(e.id);
                                                  setState(() {});
                                                  // setState(() =>
                                                  //     checkedValue = value!);
                                                })),
                                        SizedBox(width: 10.0),
                                        Text(
                                          "${e.title}",
                                          style: TextStyle(
                                              color: AppColors.textcolor,
                                              fontSize: secondayTitleFontSize,
                                              fontWeight: FontWeight.w100),
                                        )
                                      ]));
                            }).toList()),
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
                                        value: FilterSingleton
                                            .instance.priceRangeFlag,
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
                                          FilterSingleton.instance.togglePriceRange();

                                          // FilterSingleton.instance
                                          //     .togglePriceRage();
                                          setState(() {});
                                        })),
                              ],
                            ),
                          ),
                          Divider(
                            color: AppColors.graycolor,
                            height: 0,
                          ),
                          SfRangeSliderTheme(
                            data: SfRangeSliderThemeData(
                              thumbColor: Colors.white,
                              thumbStrokeWidth: 1,
                              thumbStrokeColor: AppColors.primarycolor,
                            ),
                            child: SfRangeSlider(
                              min: 0.0,
                              max: 10000.0,
                              values: FilterSingleton.instance.priceRange,
                              interval: 2500,
                              stepSize: 100,
                              showTicks: true,
                              showLabels: true,
                              enableTooltip: true,
                              showDividers: true,
                              minorTicksPerInterval: 0,
                              // activeColor: AppColors.primarycolor,
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
                              onChanged: FilterSingleton.instance.priceRangeFlag
                                  ? (SfRangeValues values) {
                                      FilterSingleton.instance
                                          .setPriceRange(values);
                                      setState(() {});
                                    }
                                  : null,
                            ),
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