
import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:sizer/sizer.dart';
import 'package:skmecom/component/common_heading.dart';
import 'package:skmecom/component/product_item.dart';
import 'package:skmecom/model/featured_model.dart';
import 'package:skmecom/pocketbase_service.dart';
import 'package:skmecom/utils/constants.dart';

import '../component/filtter_drawer.dart';

class ShopScreen extends StatefulWidget {
  final String? filter;
  final String? source;  // Add source parameter
  const ShopScreen({super.key, this.filter, this.source});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {


   final PocketBaseService pocketBaseService = PocketBaseService();

  TextEditingController _searchController = TextEditingController();

   List<Product> result = [];
   // Construct the filter in the format ((category = "he0wz883fxto127"))

   Future<void> fetchFeaturedProducts() async {
     // setState(() {
     //   result.clear();  // Clear the old list before fetching new data
     // });
     final filter = widget.filter?.isNotEmpty == true
         ? '((category = "${widget.filter}"))'
         : null;

     final productsJson = await pocketBaseService.productsFeatured(
         collectionName: 'products',
         page: 1, perPage: 12, filter: filter ?? "", sort: ""
     );
     setState(() {
       result = productsJson.map((json) => Product.fromJson(json)).toList();
     });
   }

   //   Future<void> fetchFeaturedProducts() async {
  //     // Properly format the filter string
  //     final filter = widget.filter?.isNotEmpty == true
  //         ? '((category = "${widget.filter}"))'
  //         : null;
  //   final productsJson = await pocketBaseService.productsFeatured(
  //     collectionName: 'products',
  //     page: 1, perPage: 12, filter: filter ?? "", sort: ""
  //   );
  //   setState(() {
  //     result = productsJson.map((json) => Product.fromJson(json)).toList();
  //     //  result = productsJson.cast<Product>();
  //   });
  //   // print("Featured products: ${result.length}");
  //   // print("Featured products: ${result.first.images}");
  // }

   Future<void> fetchFullProducts() async {
     // Properly format the filter string
     final filter = widget.filter?.isNotEmpty == true
         ? '((category = "${widget.filter}"))'
         : null;
     final productsJson = await pocketBaseService.fetchProducts(
         collectionName: 'products',
         page: 1, perPage: 12, filter: filter ?? "", sort: ""
     );
     setState(() {
       result = productsJson.map((json) => Product.fromJson(json)).toList();
       //  result = productsJson.cast<Product>();
     });
     // print("Featured products: ${result.length}");
     // print("Featured products: ${result.first.images}");
   }

   Future<void> updateProducts(String filterQuery) async {
     try {
       // Properly format the filter string if needed
       final formattedFilter = filterQuery.isNotEmpty
           ? filterQuery
           : null;
       print("FILTER QUERY: $filterQuery");

       final productsJson = await pocketBaseService.productsFeatured(
         collectionName: 'products',
         page: 1,
         perPage: 12,
         filter: formattedFilter ?? "",
         sort: "",
       );

       setState(() {
         result.clear();  // Clear the previous products before adding new ones
         result = productsJson.map((json) => Product.fromJson(json)).toList();
       });

     } catch (e) {
       print("Failed to fetch filtered products: $e");
     }
   }


   // Future<void> updateProducts(String filterQuery) async {
   //   try {
   //     // Properly format the filter string if needed
   //     final formattedFilter = filterQuery.isNotEmpty
   //         ? filterQuery
   //         : null;
   //     print("FILTER QUER - ${filterQuery}");
   //
   //     final productsJson = await pocketBaseService.productsFeatured(
   //       collectionName: 'products',
   //       page: 1,
   //       perPage: 12,
   //       filter: formattedFilter ?? "",
   //       sort: "",
   //     );
   //
   //     setState(() {
   //       result = productsJson.map((json) => Product.fromJson(json)).toList();
   //     });
   //
   //     // Debugging: Uncomment the lines below to verify the result
   //     // print("Filtered products: ${result.length}");
   //     // print("First product details: ${result.first.images}");
   //   } catch (e) {
   //     print("Failed to fetch filtered products: $e");
   //   }
   //
   // }




   // @override
   // void initState() {
   //   super.initState();
   //   if (widget.filter != null && widget.filter!.isNotEmpty) {
   //     updateProducts(widget.filter!);
   //   } else {
   //     fetchFeaturedProducts();
   //   }
   //   //fetchFeaturedProducts();
   // }

   @override
   void initState() {
     super.initState();

     // If the source is "cat", clear the previous list and apply category filter
     if (widget.source == "cat" && widget.filter != null && widget.filter!.isNotEmpty) {
       updateProducts('((category = "${widget.filter}"))');  // Apply filter for category
     } else {
       // Else, fetch featured products
       if (widget.filter != null && widget.filter!.isNotEmpty) {
         updateProducts(widget.filter!);
       } else {
         fetchFeaturedProducts();
       }
     }
   }




   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white, //your color,
        shadowColor: AppColors.backgroundColor,
        foregroundColor: AppColors.backgroundColor,
        surfaceTintColor: AppColors.backgroundColor,
        scrolledUnderElevation: 0,

        forceMaterialTransparency: true,

        title: Container(
          color: AppColors.backgroundColor,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.graycolor, width: 1),
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.backgroundColor,
                  ),
                  width: 70.w,
                  height: 35,
                  child: Center(
                    child: TextFormField(
                        textAlignVertical: TextAlignVertical.center,
                        keyboardType: TextInputType.text,
                        style: TextStyle(fontSize: 14),
                        onChanged: (value) {
                          setState(() {});
                        },
                        decoration: InputDecoration(
                          hintText: "Enter name, category, etc.",
                          isCollapsed: true,
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          border: InputBorder.none,
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(
                              color: AppColors.primarycolor,
                            ),
                          ),
                          suffixIcon: IconButton(
                            icon: const Icon(
                              Remix.search_line,
                              size: 18,
                              color: AppColors.graycolor,
                            ),
                            onPressed: () {},
                          ),
                        )),
                  ),
                ),
              ),
              Spacer(),
              // InkWell(
              //   onTap: () => Scaffold.of(context).openEndDrawer(),
              //   child: Icon(
              //     Remix.filter_line,
              //     size: 22,
              //     color: AppColors.textcolor,
              //   ),
              // ),

              InkWell(
                onTap: () async {
                  final filterQuery = await Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const FilterDrawer()),
                  );
                  if (filterQuery != null && filterQuery is String) {
                    updateProducts(filterQuery);
                  }
                },
                child: Icon(
                  Remix.filter_line,
                  size: 22,
                  color: AppColors.textcolor,
                ),
              ),

              // SizedBox(
              //   width: 20,
              // )
            ],
          ),
        ),
      ),

      body: Container(
           padding: const EdgeInsets.symmetric(horizontal: 0),

          color: AppColors.secBackgroundColor,
          child: ListView(
            children: [
              SizedBox(
                height: 20,
              ),
              CommonHeader(title: "PRODUCTS"),
              SizedBox(
                height: 20,
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: result.length,
                itemBuilder: (context, index) {
                  return ProductItem( productData: result[index],);
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 15,
                  );
                },
              ),
               SizedBox(
                height: 20,
              ),
            ],

          )
          //  Column(
          //   children: [ProductItem()],
          // ),
          ),
      // bottomNavigationBar: CustomBottomNavigationBar(
      //   currentItem: BottomNavItem.home,
      // ),
    );
  }
}

