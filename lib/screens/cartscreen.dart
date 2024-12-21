import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:skmecom/component/custom_btn.dart';
import 'package:skmecom/provider/add_to_cart_provider.dart';
import 'package:skmecom/screens/checkoutscreen.dart';
import 'package:skmecom/screens/loginscreen.dart';
import 'package:skmecom/store_local.dart';
import 'package:skmecom/utils/constants.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final AuthService authService = AuthService();
  String? _username;

  @override
  void initState() {
    super.initState();
    getUserCredentials();
  }

  Future<void> getUserCredentials() async {
    Map<String, String?> credentials = await authService.getCredentials();
    setState(() {
      _username = credentials['username'];
     
      // _password = credentials['password'];
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = CartProvider.of(context);
    final finalList = provider.cart;

    productQuantity(IconData icon, int index, {Color color = Colors.black}) {
      return GestureDetector(
        onTap: () {
          setState(() {
            icon == Icons.add
                ? provider.incrementQtn(index)
                : provider.decrementQtn(index);
          });
        },
        child: Icon(
          icon,
          color: color, // Set icon color here
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Cart",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Divider(),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Cart Items",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                )),
          ),
          Divider(),
          // Expanded(child: Center(child: Text("No Data"),))
          Expanded(
            child: ListView.separated(
                separatorBuilder: (context, i) {
                  return Divider();
                },
                scrollDirection: Axis.vertical,
                itemCount: finalList.length,
                itemBuilder: (context, i) {
                  final cartItems = finalList[i];
                  // print("cart data $cartItems");
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: Row(
                      children: [
                        // Product Image
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image:
                                  // AssetImage('assets/images/watch1.jpeg'),
                                  NetworkImage(
                                      "https://commerce.sketchmonk.com/_pb/api/files/${cartItems.collectionId.toString()}/${cartItems.id}/${cartItems.images[0].toString()}"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        // Product Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                //  "Rolex Daytona",

                                cartItems.name,

                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                width: 30.w,
                                height: 35,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  // color: Colors.black,
                                  border:
                                      Border.all(color: Colors.grey, width: 2),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Flexible(
                                      child: productQuantity(Icons.remove, i),
                                    ),
                                    SizedBox(
                                      width: 50,
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          border: Border.symmetric(
                                              vertical: BorderSide(
                                                  color: Colors.grey,
                                                  width: 2)),
                                          // borderRadius: const BorderRadius.only(
                                          //   topRight: Radius.circular(8),
                                          //   bottomRight: Radius.circular(8),
                                          // ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            cartItems.quantity.toString(),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: productQuantity(Icons.add, i),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Price Details
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Text(
                                  // "\u{20B9}2,000",
                                  "\u{20B9}${cartItems.actualPrice.toString()}",

                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Color.fromARGB(255, 126, 125, 125),
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  // "\u{20B9}1,500",
                                  "\u{20B9}${cartItems.discountPrice.toString()}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: AppColors.primarycolor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                }),
          )
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "₹${provider.totalPrice()}",
              style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primarycolor),
            ),
            Row(
              children: [
                TextButton(
                    onPressed: () {
                      ClearPopup.show(context);
                    },
                    child: const Text(
                      "Clear",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    )),
                const SizedBox(
                  width: 10,
                ),
                CustomButton(
                  title: "Checkout",
                  onPressed: () {

                     if (_username != null && _username!.isNotEmpty) {
                          Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CheckoutScreen()));
                     } else {

                         Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginScreen()));

                     }
                
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ClearPopup {
  static Future<void> show(BuildContext context) {
    final provider = CartProvider.of(context, listen: false);
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          contentPadding: const EdgeInsets.all(20),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 36,
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Are you sure?",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                "You will lose all the items in the cart",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.start,
                softWrap: true,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(color: AppColors.graycolor)),
                      backgroundColor: Colors.white,
                    ),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: AppColors.primarycolor),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      provider.clearCart(); // Clear the cart
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: AppColors.primarycolor,
                    ),
                    child: const Text(
                      "Clear",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
