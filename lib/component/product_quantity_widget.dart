// import 'package:flutter/material.dart';
// import 'package:skmecom/model/featured_model.dart';
// import 'package:skmecom/provider/add_to_cart_provider.dart';

// Widget buildProductQuantityWidget({
//   required Product product,
//   int? index,
//   bool showTextField = true,
//   required BuildContext context,
//    VoidCallback? onUpdate,
// }) {
//   final provider = CartProvider.of(context);

//   // int quantity = provider.getProductQuantity(product) ;


//   print("product quantity ${product.quantity}");




//   return Container(
//     height: 35,
//     width: double.infinity,
//     decoration: BoxDecoration(
//       border: Border.all(color: Colors.grey, width: 1),
//       borderRadius: BorderRadius.circular(10),
//     ),
//     child: Row(
//       mainAxisSize: MainAxisSize.min,
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         GestureDetector(
//           onTap: () {
//             provider.decrementQtn(index: index, product: product);
//              onUpdate?.call();
//           },
//           child: const Padding(
//             padding: EdgeInsets.symmetric(horizontal: 8),
//             child: Icon(Icons.remove, size: 20),
//           ),
//         ),
//         if (showTextField)
//           SizedBox(
//             width: 50,
//             child: Center(
//               child: Text(
//                 provider.getProductQuantity(product).toString(),
//                 style: const TextStyle(fontWeight: FontWeight.bold),
//               ),
//             ),
//           ),
//         GestureDetector(
//           onTap: () {
//             provider.incrementQtn(index: index, product: product);
//              onUpdate?.call();
//           },
//           child: const Padding(
//             padding: EdgeInsets.symmetric(horizontal: 8),
//             child: Icon(Icons.add, size: 20),
//           ),
//         ),
//       ],
//     ),
//   );
// }





import 'package:flutter/material.dart';
import 'package:skmecom/model/featured_model.dart';
import 'package:skmecom/provider/add_to_cart_provider.dart';

Widget buildProductQuantityWidget({
  required Product product,
  int? index,
  bool showTextField = true,
  required BuildContext context,
  VoidCallback? onUpdate,
}) {
  final provider = CartProvider.of(context);

  // If the product is not yet in cart, set initial quantity to 1
  final existingIndex = provider.cart.indexWhere((item) => item.id == product.id);
  if (existingIndex == -1 || provider.cart[existingIndex].quantity == null) {
    product.quantity = 1;
    provider.toogleFavorite(product); // add to cart with initial quantity
  }

  final quantity = provider.getProductQuantity(product);

  return Container(
    height: 35,
    width: double.infinity,
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey, width: 1),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            provider.decrementQtn(index: index, product: product);
            onUpdate?.call();
          },
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Icon(Icons.remove, size: 20),
          ),
        ),
        if (showTextField)
          SizedBox(
            width: 50,
            child: Center(
              child: Text(
                quantity.toString(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        GestureDetector(
          onTap: () {
            provider.incrementQtn(index: index, product: product);
            onUpdate?.call();
          },
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Icon(Icons.add, size: 20),
          ),
        ),
      ],
    ),
  );
}
