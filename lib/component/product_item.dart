
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:skmecom/component/product_detailed_popup.dart';
import 'package:skmecom/component/product_popup.dart';
import 'package:skmecom/model/featured_model.dart';
import 'package:skmecom/provider/add_to_cart_provider.dart';

import 'package:skmecom/utils/constants.dart';

class ProductItem extends StatefulWidget {
  final Product? productData;
  const ProductItem({super.key, this.productData});

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  TextEditingController _countController = TextEditingController();

  cartCoutIncrease() {
    setState(() {
      _countController.text = (int.parse(_countController.text) + 1).toString();
    });
  }

  cartCoutDecrease() {
    setState(() {
      if (_countController.text != "1" && _countController.text != "") {
        _countController.text =
            (int.parse(_countController.text) - 1).toString();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _countController.text = "1";

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = CartProvider.of(context, listen: false);
      final product = widget.productData!;
      if (provider.getProductQuantity(product) == 0) {
        provider.toogleFavorite(product..quantity = 1);
      }
      
    });
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ),
            child: InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) =>
                      ProductDetailsDialog(product: widget.productData!),
                );
              },
              child: Container(
                width: 90.w,
                height: 130,
                color: AppColors.backgroundColor,
                child: Row(
                  children: [
                    SizedBox(
                      width: 130,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.productData!.images.length,
                          itemBuilder: (context, i) {
                            return ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  bottomLeft: Radius.circular(8)),
                              child: Image.network(
                                "https://commerce.sketchmonk.com/_pb/api/files/${widget.productData!.collectionId.toString()}/${widget.productData!.id}/${widget.productData!.images[0].toString()}",
                                // width: 100,
                                // height: 100,
                                fit: BoxFit.cover,
                              ),
                            );
                          }),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    // "Rolex",
                                    widget.productData!.name,

                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: AppColors.textcolor,
                                        fontSize: titleFontSize,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Container(
                              width: MediaQuery.sizeOf(context).width - 200,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has ",
                                      widget.productData!.description,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: AppColors.subTextColor,
                                          fontSize: secondayTitleFontSize),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Row(
                              children: [
                                Text(
                                  // "\u{20B9}40000",
                                  "\u{20B9}${widget.productData!.actualPrice.toString()}.00",
                                  style: TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      color: AppColors.subTextColor,
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  // "\u{20B9}3500",
                                  "\u{20B9}${widget.productData!.discountPrice.toString()}.00",
                                  style: TextStyle(
                                      fontSize: 17.sp,
                                      color: AppColors.primarycolor,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                const Spacer(),
                                _countController.text == "1"
                                    ? const SizedBox()
                                    : ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                        ),
                                        child: InkWell(
                                          onTap: () => cartCoutDecrease(),
                                          child: Container(
                                            color: AppColors.primarycolor,
                                            width: 30,
                                            height: 28,
                                            child: const Center(
                                              child: Text(
                                                "-",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                _countController.text == "1"
                                    ? const SizedBox()
                                    : Container(
                                        color: AppColors.graycolor,
                                        width: 30,
                                        height: 28,
                                        child: Center(
                                          child: TextFormField(
                                              style: const TextStyle(
                                                  color:
                                                      AppColors.primarycolor),
                                              controller: _countController,
                                              readOnly: true,
                                              textAlign: TextAlign.center,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: const InputDecoration(
                                                  border: InputBorder.none,
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          vertical: 10))),
                                        )),
                                InkWell(
                                  onTap: () => cartCoutDecrease(),
                                  child: Container(
                                    // color: AppColors.primarycolor,
                                    width: 30,
                                    height: 28,
                                    decoration: BoxDecoration(
                                        color: AppColors.primarycolor,
                                        backgroundBlendMode: BlendMode.darken,
                                        borderRadius: _countController.text ==
                                                "1"
                                            ? const BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(0),
                                                bottomLeft: Radius.circular(0),
                                                bottomRight:
                                                    Radius.circular(10))
                                            : BorderRadius.circular(0)),
                                    child: Center(
                                      child: InkWell(
                                        onTap: () {
                                          // addPopup(context);
                                          showDialog(
                                            context: context,
                                            builder: (context) =>
                                                VariantSelectionDialog(
                                                    product:
                                                        widget.productData!),
                                          );
                                        },
                                        child: const Text(
                                          "+",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
