import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:sizer/sizer.dart';
import 'package:skmecom/component/common_heading.dart';
import 'package:skmecom/component/product_item.dart';
import 'package:skmecom/model/featured_model.dart';
import 'package:skmecom/pocketbase_service.dart';
import 'package:skmecom/utils/constants.dart';

class ShopScreen extends StatefulWidget {
  final String? filter;
  const ShopScreen({super.key, this.filter});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
 

   final PocketBaseService pocketBaseService = PocketBaseService();
  
  TextEditingController _searchController = TextEditingController();

   List<Product> result = [];

    Future<void> fetchFeaturedProducts() async {
       final filter = widget.filter?.isNotEmpty == true ? widget.filter : null;
    final productsJson = await pocketBaseService.productsFeatured(
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

    @override
  void initState() {
    super.initState();
    fetchFeaturedProducts();
   
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
              Container(
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
              Spacer(),
              InkWell(
                onTap: () => Scaffold.of(context).openEndDrawer(),
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
