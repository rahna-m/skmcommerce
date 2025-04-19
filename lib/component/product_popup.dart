
// import 'package:flutter/material.dart';
// import 'package:remixicon/remixicon.dart';
// import 'package:sizer/sizer.dart';
// import 'package:skmecom/component/popup_item.dart';
// import 'package:skmecom/component/product_quantity_widget.dart';
// import 'package:skmecom/model/featured_model.dart';
// import 'package:skmecom/provider/add_to_cart_provider.dart';
// import 'package:skmecom/screens/cartscreen.dart';
// import 'package:skmecom/utils/constants.dart';

// class VariantSelectionDialog extends StatelessWidget {
//   final Product product;

//   const VariantSelectionDialog({super.key, required this.product});

//   @override
//   Widget build(BuildContext context) {
//     final provider = CartProvider.of(context, listen: false);

//     return AlertDialog(
//       backgroundColor: AppColors.backgroundColor,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.all(Radius.circular(8.0)),
//       ),
//       contentPadding: EdgeInsets.zero,
//       insetPadding: const EdgeInsets.symmetric(horizontal: 20),
//       content: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Text(
//                   "Select Variant",
//                   style: TextStyle(
//                     color: AppColors.textcolor,
//                     fontWeight: FontWeight.w600,
//                     fontSize: titleFontSize,
//                   ),
//                 ),
//                 const Spacer(),
//                 InkWell(
//                   onTap: () => Navigator.of(context).pop(),
//                   child: const Icon(Remix.close_line),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
//             PopUpItem(
//               productName: product.name,
//               discountAmount: product.discountPrice.toString(),
//               actualAmount: product.actualPrice.toString(),
//               imageUrl:
//                   "https://commerce.sketchmonk.com/_pb/api/files/${product.collectionId}/${product.id}/${product.images[0]}",
//             ),
//             const SizedBox(height: 10),
//             buildProductQuantityWidget(
//               context: context,
//               product: product,
//               showTextField: true, 
//             ),
//             const SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 MaterialButton(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                     side: const BorderSide(color: AppColors.graycolor),
//                   ),
//                   color: AppColors.backgroundColor,
//                   onPressed: () => Navigator.of(context).pop(),
//                   child: Text(
//                     "Cancel",
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 16.sp,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//                 MaterialButton(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   color: AppColors.primarycolor,
//                   onPressed: () {
//                     provider.toogleFavorite(product);
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const CartScreen(),
//                       ),
//                     );
//                   },
//                   child: Row(
//                     children: [
//                       const Icon(
//                         Remix.add_line,
//                         size: 20,
//                         color: Colors.white,
//                       ),
//                       const SizedBox(width: 10),
//                       Text(
//                         "Add to Cart",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 16.sp,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 10),
//           ],
//         ),
//       ),
//     );
//   }
// }







import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:sizer/sizer.dart';
import 'package:skmecom/component/popup_item.dart';
import 'package:skmecom/component/product_quantity_widget.dart';
import 'package:skmecom/model/featured_model.dart';
import 'package:skmecom/provider/add_to_cart_provider.dart';
import 'package:skmecom/screens/cartscreen.dart';
import 'package:skmecom/utils/constants.dart';

class VariantSelectionDialog extends StatefulWidget {
  final Product product;

  const VariantSelectionDialog({super.key, required this.product});

  @override
  State<VariantSelectionDialog> createState() => _VariantSelectionDialogState();
}

class _VariantSelectionDialogState extends State<VariantSelectionDialog> {

@override
void initState() {
  super.initState();

  Future.delayed(Duration.zero, () {
    final provider = CartProvider.of(context, listen: false);
    final product = widget.product;

    if (provider.getProductQuantity(product) == 0 || product.quantity == null) {
      product.quantity = 1;
      provider.toogleFavorite(product);
    }
  });
}

//   @override
// void initState() {
//   super.initState();

//   // Safely delay cart setup
//   WidgetsBinding.instance.addPostFrameCallback((_) {
//     final provider = CartProvider.of(context, listen: false);
//     final product = widget.product;

//     if (provider.getProductQuantity(product) == 0 || product.quantity == null) {
//       product.quantity = 1;
//       provider.toogleFavorite(product);
//     }
//   });
// }


  @override
  Widget build(BuildContext context) {
    final provider = CartProvider.of(context);

    return AlertDialog(
      backgroundColor: AppColors.backgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      contentPadding: EdgeInsets.zero,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      content: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Select Variant",
                  style: TextStyle(
                    color: AppColors.textcolor,
                    fontWeight: FontWeight.w600,
                    fontSize: titleFontSize,
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Icon(Remix.close_line),
                ),
              ],
            ),
            const SizedBox(height: 20),
            PopUpItem(
              productName: widget.product.name,
              discountAmount: widget.product.discountPrice.toString(),
              actualAmount: widget.product.actualPrice.toString(),
              imageUrl:
                  "https://commerce.sketchmonk.com/_pb/api/files/${widget.product.collectionId}/${widget.product.id}/${widget.product.images[0]}",
            ),
            const SizedBox(height: 10),
            buildProductQuantityWidget(
              context: context,
              product: widget.product,
              showTextField: true,
              onUpdate: () {
                setState(() {
                   print("${widget.product.quantity}");
                  print("+ clicked");
                });
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(color: AppColors.graycolor),
                  ),
                  color: AppColors.backgroundColor,
                  onPressed: () => Navigator.of(context).pop(),
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
                    provider.toogleFavorite(widget.product);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CartScreen(),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      const Icon(
                        Remix.add_line,
                        size: 20,
                        color: Colors.white,
                      ),
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
    );
  }
}
