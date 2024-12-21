import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:sizer/sizer.dart';
import 'package:skmecom/component/popup_item.dart';
import 'package:skmecom/component/triangle_widget.dart';
import 'package:skmecom/model/featured_model.dart';
import 'package:skmecom/provider/add_to_cart_provider.dart';
import 'package:skmecom/screens/cartscreen.dart';
import 'package:skmecom/utils/constants.dart';

class ProductItem extends StatefulWidget {
  final Product? productData;
  const ProductItem({super.key, this.productData});

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  TextEditingController _countController = TextEditingController();

  // List<String>? get productImages {
  //   return widget.productData?.images;
  // }

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
    // TODO: implement initState
    super.initState();
    _countController.text = "1";
    //  print( " img:  https://commerce.sketchmonk.com/_pb/api/files/${widget.productData!.collectionId.toString()}/${widget.productData!.id}/${widget.productData!.images[0].toString()}");
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
              onTap: () => itemDetailsPopUp(context),
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
                                // "assets/images/watch1.jpeg",

                                // "https://commerce.sketchmonk.com/_pb/api/files/kdhrswxqb1qh3yw/gaf58ffvo1rtud0/watch_01_s8WuhlQGei.jpeg",
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
                                          addPopup(context);
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
        Stack(
          children: [
            Transform.translate(
              offset: Offset(83.5.w, 10),
              // offset: Offset(85.2.w, 10),
              child: Container(
                decoration: const BoxDecoration(
                    color: AppColors.offerbackgroundcolor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                        topRight: Radius.circular(8))),
                height: 22,
                width: 50,
                child: const Center(
                    child: Text(
                  "20% OFF",
                  style: TextStyle(
                      color: AppColors.backgroundColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 9),
                )),
              ),
            ),
            Transform.translate(
              offset: Offset(94.5.w, 31.6),
              // offset: Offset(95.w, 31.6),
              child: CustomPaint(
                painter: TrianglePainter(
                  strokeColor: const Color.fromARGB(255, 43, 129, 0),
                  strokeWidth: 10,
                  paintingStyle: PaintingStyle.fill,
                ),
                child: Container(
                  height: 10,
                  width: 10,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  Future<dynamic> addPopup(BuildContext context) {
     final provider = CartProvider.of(context, listen: false);
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: AppColors.backgroundColor,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              contentPadding: EdgeInsets.zero,
              actionsPadding: EdgeInsets.zero,
              titlePadding: EdgeInsets.zero,
              iconPadding: EdgeInsets.zero,
              insetPadding: const EdgeInsets.symmetric(horizontal: 20),
              // icon: Icon(
              //   Icons.question_mark,
              //   size: 40,
              // ),
              content: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          "Select Variant",
                          style: TextStyle(
                              color: AppColors.textcolor,
                              fontWeight: FontWeight.w600,
                              fontSize: titleFontSize),
                        ),
                        const Spacer(),
                        InkWell(
                            onTap: () => Navigator.of(context).pop(),
                            child: const Icon(Remix.close_line))
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    //  const PopUpItem(),
                    PopUpItem(
                      productName: widget.productData?.name ?? "No Name",
                      discountAmount: widget.productData?.discountPrice.toString() ??
                          "0.00",
                           actualAmount: widget.productData?.actualPrice.toString() ??
                          "0.00",
                      imageUrl:
                          "https://commerce.sketchmonk.com/_pb/api/files/${widget.productData?.collectionId}/${widget.productData?.id}/${widget.productData?.images[0]}",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () => cartCoutDecrease(),
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                border: Border.all(color: AppColors.graycolor),
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    bottomLeft: Radius.circular(8))),
                            child: const Center(
                                child: Text(
                              "-",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            )),
                          ),
                        ),
                        Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: AppColors.graycolor)),
                            height: 30,
                            width: 60.w,
                            child: Center(
                              child: TextFormField(
                                  controller: _countController,
                                  textAlignVertical: TextAlignVertical.center,
                                  keyboardType: TextInputType.number,
                                  style: const TextStyle(fontSize: 12),
                                  textAlign: TextAlign.center,
                                  decoration: const InputDecoration(
                                    isCollapsed: true,
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 10),
                                    border: InputBorder.none,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.primarycolor,
                                      ),
                                    ),
                                  )),
                            )),
                        InkWell(
                          onTap: () => cartCoutIncrease(),
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                border: Border.all(color: AppColors.graycolor),
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(8),
                                    bottomRight: Radius.circular(8))),
                            child: const Center(
                                child: Text(
                              "+",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            )),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side:
                                  const BorderSide(color: AppColors.graycolor),
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
                                  fontWeight: FontWeight.w600),
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            color: AppColors.primarycolor,
                            onPressed: () {

                               final quantity = int.tryParse(_countController.text) ?? 1;
                             
                                      //  final cartProvider = CartProvider.of(context, listen: false);
                                      Product product = Product(
                                          actualPrice:
                                              widget.productData!.actualPrice,
                                          addons: widget.productData!.addons,
                                          category:
                                              widget.productData!.category,
                                          collectionId:
                                              widget.productData!.collectionId,
                                          collectionName: widget
                                              .productData!.collectionName,
                                          created: widget.productData!.created,
                                          description:
                                              widget.productData!.description,
                                          discountPrice:
                                              widget.productData!.discountPrice,
                                          expand: widget.productData!.expand,
                                          featured:
                                              widget.productData!.featured,
                                          id: widget.productData!.id,
                                          images: widget.productData!.images,
                                          name: widget.productData!.name,
                                          slug: widget.productData!.slug,
                                          updated: widget.productData!.updated,
                                           quantity: quantity
                                          );
                                         
                                          
                                         
                                      provider.toogleFavorite(product);

                                      print("add to cart data $product");
                                         print("Add to cart with quantity: $quantity");

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CartScreen()));
                                 
                            },
                            child: Row(
                              children: [
                                const Icon(
                                  Remix.add_line,
                                  size: 20,
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Add to Cart",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            ));
  }

  Future<dynamic> itemDetailsPopUp(BuildContext context) {
    final provider = CartProvider.of(context, listen: false);
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: AppColors.backgroundColor,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              contentPadding: EdgeInsets.zero,
              actionsPadding: EdgeInsets.zero,
              titlePadding: EdgeInsets.zero,
              iconPadding: EdgeInsets.zero,
              insetPadding: const EdgeInsets.symmetric(horizontal: 20),
              // icon: Icon(
              //   Icons.question_mark,
              //   size: 40,
              // ),
              content: Container(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  // height: MediaQuery.of(context).size.height * 0.6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        children: [
                          // Container(
                          //   child: Image.network(
                          //     // "assets/images/watch1.jpeg",
                          //      "https://commerce.sketchmonk.com/_pb/api/files/${widget.productData!.collectionId.toString()}/${widget.productData!.id}/${widget.productData!.images[0].toString()}",
                          //     width: 100.w,
                          //     height: 40.h,
                          //     fit: BoxFit.cover,
                          //   ),
                          // ),
                          CarouselSlider(
                            options: CarouselOptions(
                              height: MediaQuery.of(context).size.height * 0.4,
                              viewportFraction: 1.0,
                              enableInfiniteScroll: true,
                              enlargeCenterPage: true,
                            ),
                            items: widget.productData!.images.map((imageUrl) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return Image.network(
                                    "https://commerce.sketchmonk.com/_pb/api/files/${widget.productData!.collectionId.toString()}/${widget.productData!.id}/$imageUrl",
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
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    // "Rolex sgfjhdgsjkfgdjsfjd dsdgfdgfgdf iueyrhvrtj",
                                    widget.productData!.name,
                                    style: TextStyle(
                                        color: AppColors.textcolor,
                                        fontSize: titleFontSize,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                const Icon(
                                  Remix.vip_crown_2_fill,
                                  size: 20,
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Remix.apps_line,
                                  size: 20,
                                  color: AppColors.hashTagColor,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: Text(
                                    // "Rolex ",
                                    widget.productData!.expand.category.title,
                                    style: TextStyle(
                                        color: AppColors.hashTagColor,
                                        fontSize: titleFontSize,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              // "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has ",
                              widget.productData!.description,
                              style: TextStyle(
                                  color: AppColors.subTextColor,
                                  fontSize: secondayTitleFontSize),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  // "\u{20B9}3500",
                                  "\u{20B9}${widget.productData!.discountPrice.toString()}.00",
                                  style: TextStyle(
                                      fontSize: 17.sp,
                                      color: AppColors.primarycolor,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  // "\u{20B9}40000",

                                  "\u{20B9}${widget.productData!.actualPrice.toString()}.00",
                                  style: TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      color: AppColors.subTextColor,
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                MaterialButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: const BorderSide(
                                          color: AppColors.graycolor),
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
                                          fontWeight: FontWeight.w600),
                                    )),
                                const SizedBox(
                                  width: 10,
                                ),
                                MaterialButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    color: AppColors.primarycolor,
                                    onPressed: () {
                                      //  final cartProvider = CartProvider.of(context, listen: false);
                                      Product product = Product(
                                          actualPrice:
                                              widget.productData!.actualPrice,
                                          addons: widget.productData!.addons,
                                          category:
                                              widget.productData!.category,
                                          collectionId:
                                              widget.productData!.collectionId,
                                          collectionName: widget
                                              .productData!.collectionName,
                                          created: widget.productData!.created,
                                          description:
                                              widget.productData!.description,
                                          discountPrice:
                                              widget.productData!.discountPrice,
                                          expand: widget.productData!.expand,
                                          featured:
                                              widget.productData!.featured,
                                          id: widget.productData!.id,
                                          images: widget.productData!.images,
                                          name: widget.productData!.name,
                                          slug: widget.productData!.slug,
                                          updated: widget.productData!.updated);
                                      provider.toogleFavorite(product);

                                      print("add to cart data $product");

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CartScreen()));
                                    },
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Remix.add_line,
                                          size: 20,
                                          color: Colors.white,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Add to Cart",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ));
  }
}
