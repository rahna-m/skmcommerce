import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:sizer/sizer.dart';
import 'package:skmecom/model/featured_model.dart';
import 'package:skmecom/provider/add_to_cart_provider.dart';
import 'package:skmecom/screens/cartscreen.dart';
import 'package:skmecom/utils/constants.dart';

class ProductDetailsDialog extends StatelessWidget {
  final Product product;

  const ProductDetailsDialog({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final provider = CartProvider.of(context, listen: false);

    return AlertDialog(
      backgroundColor: AppColors.backgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      contentPadding: EdgeInsets.zero,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      content: Container(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      height: MediaQuery.of(context).size.height * 0.4,
                      viewportFraction: 1.0,
                      enableInfiniteScroll: true,
                      enlargeCenterPage: true,
                    ),
                    items: product.images.map((imageUrl) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Image.network(
                            "https://commerce.sketchmonk.com/_pb/api/files/${product.collectionId}/${product.id}/$imageUrl",
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width,
                          );
                        },
                      );
                    }).toList(),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Icon(
                        Remix.close_line,
                        size: 25,
                        color: AppColors.graycolor,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            product.name,
                            style: TextStyle(
                              color: AppColors.textcolor,
                              fontSize: titleFontSize,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const Icon(Remix.vip_crown_2_fill, size: 20),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(
                          Remix.apps_line,
                          size: 20,
                          color: AppColors.hashTagColor,
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            product.expand.category.title,
                            style: TextStyle(
                              color: AppColors.hashTagColor,
                              fontSize: titleFontSize,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      product.description,
                      style: TextStyle(
                        color: AppColors.subTextColor,
                        fontSize: secondayTitleFontSize,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          "₹${product.discountPrice}.00",
                          style: TextStyle(
                            fontSize: 17.sp,
                            color: AppColors.primarycolor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "₹${product.actualPrice}.00",
                          style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: AppColors.subTextColor,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(color: AppColors.graycolor),
                          ),
                          color: AppColors.backgroundColor,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          color: AppColors.primarycolor,
                          onPressed: () {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              final provider =
                                  CartProvider.of(context, listen: false);
                              // final product = widget.product;

                              final index = provider.cart
                                  .indexWhere((item) => item.id == product.id);
                              if (index == -1 ||
                                  provider.cart[index].quantity == null) {
                                product.quantity = 1;
                                provider.toogleFavorite(product);
                              }
                            });
                            // provider.toogleFavorite(product);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CartScreen(),
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              const Icon(Remix.add_line,
                                  size: 20, color: Colors.white),
                              const SizedBox(width: 10),
                              Text(
                                "Add to Cart",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
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
