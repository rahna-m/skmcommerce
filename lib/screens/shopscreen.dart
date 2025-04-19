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
  final String? source;
  const ShopScreen({super.key, this.filter, this.source});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  final PocketBaseService pocketBaseService = PocketBaseService();

  TextEditingController _searchController = TextEditingController();

  List<Product> result = [];

  // Future<void> fetchFeaturedProducts() async {
  //   final filter = widget.filter?.isNotEmpty == true
  //       ? '((category = "${widget.filter}"))'
  //       : null;

  //   final productsJson = await pocketBaseService.productsFeatured(
  //       collectionName: 'products',
  //       page: 1,
  //       perPage: 12,
  //       filter: filter ?? "",
  //       sort: "");
  //   setState(() {
  //     result = productsJson.map((json) => Product.fromJson(json)).toList();
  //   });
  // }

  Future<void> fetchFeaturedProducts({String? searchTerm}) async {
    String baseFilter = widget.filter?.isNotEmpty == true
        ? '(category = "${widget.filter}")'
        : '';

    String searchFilter = searchTerm?.isNotEmpty == true
        ? '(name ~ "$searchTerm" || slug ~ "$searchTerm" || brand.title ~ "$searchTerm" || category.title ~ "$searchTerm")'
        : '';

    String combinedFilter;
    if (baseFilter.isNotEmpty && searchFilter.isNotEmpty) {
      combinedFilter = '($searchFilter) && $baseFilter';
    } else {
      combinedFilter = searchFilter.isNotEmpty ? searchFilter : baseFilter;
    }

    try {
      final productsJson = await pocketBaseService.productsFeatured(
        collectionName: 'products',
        page: 1,
        perPage: 12,
        filter: combinedFilter,
        sort: "",
      );

      setState(() {
        result = productsJson.map((json) => Product.fromJson(json)).toList();
      });
    } catch (e) {
      print("Error fetching products: $e");
    }
  }

  Future<void> fetchFullProducts() async {
    final filter = widget.filter?.isNotEmpty == true
        ? '((category = "${widget.filter}"))'
        : null;
    final productsJson = await pocketBaseService.fetchProducts(
        collectionName: 'products',
        page: 1,
        perPage: 12,
        filter: filter ?? "",
        sort: "");
    setState(() {
      result = productsJson.map((json) => Product.fromJson(json)).toList();
    });
  }

  Future<void> updateProducts(String filterQuery) async {
    try {
      final formattedFilter = filterQuery.isNotEmpty ? filterQuery : null;
      print("FILTER QUERY: $filterQuery");

      final productsJson = await pocketBaseService.productsFeatured(
        collectionName: 'products',
        page: 1,
        perPage: 12,
        filter: formattedFilter ?? "",
        sort: "",
      );

      setState(() {
        result.clear();
        result = productsJson.map((json) => Product.fromJson(json)).toList();
      });
    } catch (e) {
      print("Failed to fetch filtered products: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.source == "cat" &&
        widget.filter != null &&
        widget.filter!.isNotEmpty) {
      updateProducts('(category = "${widget.filter}")');
    } else {
      if (widget.filter != null && widget.filter!.isNotEmpty) {
        updateProducts(widget.filter!);
      } else {
        fetchFeaturedProducts(); // no search term
      }
    }
  }
  // void initState() {
  //   super.initState();

  //   // If the source is "cat", clear the previous list and apply category filter
  //   if (widget.source == "cat" &&
  //       widget.filter != null &&
  //       widget.filter!.isNotEmpty) {
  //     updateProducts(
  //         '((category = "${widget.filter}"))'); // Apply filter for category
  //   } else {
  //     // Else, fetch featured products
  //     if (widget.filter != null && widget.filter!.isNotEmpty) {
  //       updateProducts(widget.filter!);
  //     } else {
  //       fetchFeaturedProducts();
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: AppColors.backgroundColor,
        foregroundColor: AppColors.backgroundColor,
        surfaceTintColor: AppColors.backgroundColor,
        scrolledUnderElevation: 0,
        forceMaterialTransparency: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.zero,
                padding: EdgeInsets.zero,
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
                      style: const TextStyle(fontSize: 14),
                      onChanged: (value) {
                        fetchFeaturedProducts(searchTerm: value.trim());
                      },
                      decoration: InputDecoration(
                        hintText: "Enter name, category, etc.",
                        isCollapsed: true,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 10),
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
                          onPressed: () {
                            // fetchFeaturedProducts(searchTerm: _searchController.text.trim());
                          },
                        ),
                      )),
                ),
              ),
            ),

            const SizedBox(width: 20),
            // const Spacer(),
            InkWell(
              onTap: () async {
                final filterQuery = await Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const FilterDrawer()),
                );
                if (filterQuery != null && filterQuery is String) {
                  updateProducts(filterQuery);
                }
              },
              child: const Icon(
                Remix.filter_line,
                size: 22,
                color: AppColors.textcolor,
              ),
            ),
          ],
        ),
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          color: AppColors.secBackgroundColor,
          child: ListView(
            children: [
              const SizedBox(
                height: 20,
              ),
              const CommonHeader(title: "PRODUCTS"),
              const SizedBox(
                height: 20,
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: result.length,
                itemBuilder: (context, index) {
                  return ProductItem(
                    productData: result[index],
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 15,
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          )),
    );
  }
}
