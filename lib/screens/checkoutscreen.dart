import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:skmecom/component/custom_btn.dart';
import 'package:skmecom/pocketbase_service.dart';
import 'package:skmecom/provider/add_to_cart_provider.dart';
import 'package:skmecom/store_local.dart';
import 'package:skmecom/utils/constants.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:url_launcher/url_launcher.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final AuthService authService = AuthService();
  final PocketBaseService pocketBaseService = PocketBaseService();

  bool isDelivery = false;
  String orderDeliveryType = "pickup";
  String orderPaymentType = "offline";
  String orderComments = "";
  List result = [];
  String selectedAddress = "";

  @override
  void initState() {
    super.initState();

    fetchAllAddress();
  }

  void handlePlaceOrder(
    List<Map<String, dynamic>> products,
    String deliveryType,
    String paymentType,
    String comments,
    String address,
  ) async {
    Map<String, String?> credentials = await authService.getCredentials();
    String? token = credentials['token'];

    // Call the `placeOrder` method
    final orderResponse = await pocketBaseService.placeOrder(
      token: token.toString(),
      products: products,
      deliveryType: deliveryType,
      paymentType: paymentType,
      comments: comments,
      address: address,
    );

    print("Place order response: $orderResponse");

    if (orderResponse != null) {
      String receipt = orderResponse["order"]["receipt"] ?? "";
      String message = orderResponse["message"] ?? "";

      print("orderrrrrrr msg: $message");

      showOrderSuccessDialog(context, receipt, message);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to place order.")),
      );
    }
  }

  Future<void> fetchAllAddress() async {
    Map<String, String?> credentials = await authService.getCredentials();
    String? tokens = credentials['token'];
    final addressJson = await pocketBaseService.fetchAddress(
      collectionName: 'addresses',
      token: tokens.toString(),
      page: 1,
      perPage: 500,
      skipTotal: 1,
    );

    setState(() {
      result = addressJson.cast<Map<String, dynamic>>() ?? [];
      //  result = [];
    });

    print("Address list: $result");
  }

  @override
  Widget build(BuildContext context) {
    final provider = CartProvider.of(context);
    final finalList = provider.cart;
    return Scaffold(
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            // "Rolex Daytona",

                                            cartItems.name,

                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          const Text("(default)"),
                                          const SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Text(
                                                // "\u{20B9}2,000",
                                                "\u{20B9}${cartItems.actualPrice.toString()}",

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
                                    ),
                                    // Price Details
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              setState(() {
                                                provider
                                                    .removeFromCart(cartItems);
                                              });
                                            },
                                            icon: const Icon(
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
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Total"),
                            Text(
                              // "₹4,000",
                              "₹${provider.actualPrice()}",
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
                            const Text("Discount"),
                            Text(
                              // "-₹600",
                              "₹${provider.discountPrice()}",
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
                              // "₹4,000",
                              "₹${provider.totalPrice()}",
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
                padding: const EdgeInsets.symmetric(horizontal: 18),
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
                            activeBgColors: const [
                              [Colors.white],
                              [Colors.white]
                            ],
                            activeFgColor: Colors.black,
                            inactiveBgColor: Color.fromARGB(198, 236, 233, 233),
                            inactiveFgColor: Colors.black,
                            initialLabelIndex: isDelivery ? 1 : 0,
                            totalSwitches: 2,
                            labels: const ['Pickup', 'Delivery'],
                            borderWidth: 3.0,
                            borderColor: const [
                              Color.fromARGB(198, 236, 233, 233)
                            ],
                            // radiusStyle: true,
                            onToggle: (index) {
                              setState(() {
                                isDelivery = index == 1;
                                orderDeliveryType =
                                    isDelivery ? "delivery" : "pickup";
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
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Select Address",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18),
                                  )),
                            ),
                            const Divider(),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: result.isEmpty
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Text("No Address added"),
                                        CustomButton(
                                          title: "+ Add Address",
                                          onPressed: () {},
                                        )
                                      ],
                                    )
                                  : Builder(
                                      builder: (context) {
                                        // Auto-select first address if nothing is selected
                                        if (selectedAddress.isEmpty) {
                                          selectedAddress = result[0]["id"];
                                        }

                                        return SizedBox(
                                          height: 200,
                                          child: ListView.builder(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 0, horizontal: 10),
                                            itemCount: result.length,
                                            itemBuilder: (context, index) {
                                              final address = result[index];
                                              return RadioListTile<String>(
                                                value: address["id"]!,
                                                groupValue: selectedAddress,
                                                onChanged: (value) {
                                                  setState(() {
                                                    selectedAddress =
                                                        value.toString();
                                                  });

                                                  print(
                                                      "selected address $selectedAddress");
                                                },
                                                title: Text(
                                                  address["name"]!,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                subtitle: Text(
                                                  "${address["building"]}, ${address["street"]}, ${address["pin"]}",
                                                  style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 14),
                                                ),
                                                activeColor:
                                                    AppColors.primarycolor,
                                              );
                                            },
                                          ),
                                        );
                                      },
                                    ),
                            )
                          ],
                        ),
                      ),

                    // Payment Type Section
                    const SizedBox(height: 16),

                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
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
                            activeBgColors: const [
                              [Colors.white],
                              [Colors.white]
                            ],
                            activeFgColor: Colors.black,
                            inactiveBgColor:
                                const Color.fromARGB(198, 236, 233, 233),
                            inactiveFgColor: Colors.black,
                            initialLabelIndex: 0,
                            totalSwitches: 2,
                            labels: const ['Offline', 'Online'],
                            borderWidth: 3.0,
                            borderColor: const [
                              Color.fromARGB(198, 236, 233, 233)
                            ],
                            // radiusStyle: true,
                            onToggle: (index) {
                              setState(() {
                                orderPaymentType =
                                    index == 1 ? "offline" : "offline";
                              });
                              print('switched to: $index');
                            },
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Notes",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),
                                )),
                          ),
                          const Divider(),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Column(
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                TextField(
                                  onChanged: (value) {
                                    orderComments = value;
                                  },
                                  maxLines:
                                      3, // Adjust for the height of the input
                                  decoration: InputDecoration(
                                    hintText:
                                        'If you have any special requests or instructions, please mention them here.',
                                    hintStyle: TextStyle(
                                      color: Colors.grey.shade400,
                                      fontSize: 14.0,
                                    ),
                                    contentPadding: const EdgeInsets.all(16.0),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    Container(
                      width: double.infinity,
                      child: CustomButton(
                        title: "Place Order",
                        //  onPressed: handlePlaceOrder('Pickup','Offline',"","" ),
                        onPressed: () {
                          final products = finalList.map((item) {
                            return {
                              "product": item
                                  .id, // Assuming each item in finalList has an `id`
                              "quantity": item
                                  .quantity // Assuming each item in finalList has a `quantity`
                            };
                          }).toList();

                          print(
                              "$products, $orderDeliveryType, $orderPaymentType, $orderComments, $selectedAddress");
                          handlePlaceOrder(
                              products,
                              orderDeliveryType,
                              orderPaymentType,
                              orderComments,
                              selectedAddress.toString());
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showOrderSuccessDialog(BuildContext context, String receipt, String order
      //  Map<String, dynamic> order
      ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.green),
                  SizedBox(width: 10),
                  Text(
                    'Order Placed',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(text: 'Your order'),
                    TextSpan(
                      text: receipt,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const TextSpan(text: 'has been placed successfully.\n'),
                  ],
                ),
              ),
              Text(order),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          ),
          ElevatedButton.icon(
            icon: const Icon(FontAwesomeIcons.whatsapp, color: Colors.white),
            onPressed: () {
              shareOrderOnWhatsApp(receipt, order);
            },
            label: const Text(
              "Send to WhatsApp",
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
          )
        ],
      ),
    );
  }

  void shareOrderOnWhatsApp(String receipt, String order) async {
    String message = "**Order #$receipt has been placed successfully.\n";
    message += order;

    final whatsappUrl = "https://wa.me/?text=${Uri.encodeComponent(message)}";

    if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
      await launchUrl(Uri.parse(whatsappUrl),
          mode: LaunchMode.externalApplication);
    } else {
      print("WhatsApp not installed or URL can't be launched.");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text("WhatsApp not installed or URL can't be launched.")),
      );
    }
  }
}
