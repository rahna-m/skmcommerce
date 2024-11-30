import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:sizer/sizer.dart';
import 'package:skmecom/component/custom_btn.dart';
import 'package:skmecom/screens/cartscreen.dart';
import 'package:skmecom/utils/constants.dart';
import 'package:toggle_switch/toggle_switch.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  bool isDelivery = false;
  // int activeIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // forceMaterialTransparency: true,
        // scrolledUnderElevation: 0,
        toolbarHeight: 80,
        title: const Text("SKMCOMMERCE"),
        actions: [
          const SizedBox(width: 20),
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: IconButton(
              icon: Icon(Remix.shopping_cart_2_line),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CartScreen()));
              },
            ),
          )
        ],
      ),
      body: Container(
        color: const Color.fromARGB(198, 236, 233, 233),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // items list
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Items",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 20),
                            )),
                      ),
                      const Divider(),
                      SizedBox(
                        height: 300,
                        child: ListView.separated(
                            separatorBuilder: (context, i) {
                              return const Divider();
                            },
                            scrollDirection: Axis.vertical,
                            itemCount: 2,
                            itemBuilder: (context, i) {
                              // final cartItems = finalList[i];
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
                                          image: AssetImage(
                                              'assets/images/watch1.jpeg'),
                                          // NetworkImage(
                                          //     "https://commerce.sketchmonk.com/_pb/api/files/${cartItems.collectionId.toString()}/${cartItems.id}/${cartItems.images[0].toString()}"),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    // Product Details
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Rolex Daytona",

                                            // cartItems.name,

                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Text("(default)"),
                                          const SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Text(
                                                "\u{20B9}2,000",
                                                // "\u{20B9}${cartItems.actualPrice.toString()}",

                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Color.fromARGB(
                                                      255, 126, 125, 125),
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                ),
                                              ),
                                              const SizedBox(width: 5),
                                              Text(
                                                "\u{20B9}1,500",
                                                // "\u{20B9}${cartItems.discountPrice.toString()}",
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
                                    ),
                                    // Price Details
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ))
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Total"),
                            Text(
                              "₹4,000",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 16.sp),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Discount"),
                            Text(
                              "-₹600",
                              style: TextStyle(
                                  color: Colors.green, fontSize: 16.sp),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Subtotal",
                              style: TextStyle(
                                  fontSize: 16.sp, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "₹4,000",
                              style: TextStyle(
                                  color: AppColors.primarycolor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.sp),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
              ),

              // Delivery type

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Delivery Type",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),

                          // const SizedBox(height: 8),

                          ToggleSwitch(
                            minWidth: 90.0,
                            cornerRadius: 10.0,
                            activeBgColors: [
                              [Colors.white],
                              [Colors.white]
                            ],
                            activeFgColor: Colors.black,
                            inactiveBgColor: Color.fromARGB(198, 236, 233, 233),
                            inactiveFgColor: Colors.black,
                            initialLabelIndex: isDelivery ? 1 : 0,
                            totalSwitches: 2,
                            labels: ['Pickup', 'Delivery'],
                            borderWidth: 3.0,
                            borderColor: [Color.fromARGB(198, 236, 233, 233)],
                            // radiusStyle: true,
                            onToggle: (index) {
                               setState(() {
                                isDelivery = index == 1;
                              });
                              print('switched to: $index');
                            },
                          ),
                        ],
                      ),
                    ),
                    // Delivery Type Toggle

                    const SizedBox(height: 16),

                    // Conditionally Display Address Section
                    if (isDelivery)

                    Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Select Address",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 18),
                            )),
                      ),
                      const Divider(),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                        
                            Text("No Address added"),
                            CustomButton(title: "+ Add Address", onPressed: (){},)
                        
                        
                          ],
                        ),
                      )
                     
                  
                     
                    ],
                  ),
                ),
                   

                    // Payment Type Section
                    const SizedBox(height: 16),
                    // const Text(
                    //   "Payment Type",
                    //   style:
                    //       TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    // ),
                    // const SizedBox(height: 8),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   children: [
                    //     Expanded(
                    //       child: GestureDetector(
                    //         onTap: () {
                    //           // Handle Offline Payment Selection
                    //         },
                    //         child: Container(
                    //           padding: const EdgeInsets.symmetric(vertical: 12),
                    //           decoration: BoxDecoration(
                    //             color: Colors.white,
                    //             border: Border.all(color: Colors.blue),
                    //             borderRadius: BorderRadius.circular(8),
                    //           ),
                    //           child: const Text(
                    //             "Offline",
                    //             textAlign: TextAlign.center,
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //     const SizedBox(width: 16),
                    //     Expanded(
                    //       child: GestureDetector(
                    //         onTap: () {
                    //           // Handle Online Payment Selection
                    //         },
                    //         child: Container(
                    //           padding: const EdgeInsets.symmetric(vertical: 12),
                    //           decoration: BoxDecoration(
                    //             color: Colors.white,
                    //             border: Border.all(color: Colors.blue),
                    //             borderRadius: BorderRadius.circular(8),
                    //           ),
                    //           child: const Text(
                    //             "Online",
                    //             textAlign: TextAlign.center,
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),


                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Payment Type",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),

                          // const SizedBox(height: 8),

                          ToggleSwitch(
                            minWidth: 90.0,
                            cornerRadius: 10.0,
                            activeBgColors: [
                              [Colors.white],
                              [Colors.white]
                            ],
                            activeFgColor: Colors.black,
                            inactiveBgColor: Color.fromARGB(198, 236, 233, 233),
                            inactiveFgColor: Colors.black,
                            initialLabelIndex: 0,
                            totalSwitches: 2,
                            labels: ['Offline', 'Online'],
                            borderWidth: 3.0,
                            borderColor: [Color.fromARGB(198, 236, 233, 233)],
                            // radiusStyle: true,
                            onToggle: (index) {
                             
                              print('switched to: $index');
                            },
                          ),
                        ],
                      ),
                    ),
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
