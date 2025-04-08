import 'package:flutter/material.dart';
import 'package:skmecom/pocketbase_service.dart';
import 'package:skmecom/utils/constants.dart';

class ConfirmPopup {
  // static Future<void> show(BuildContext context, String title, String message) {
  //   return showDialog(
  //     context: context,
  //     barrierDismissible: true,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(12),
  //         ),
  //         contentPadding: const EdgeInsets.all(20),
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Row(
  //               children: [
  //                 Icon(
  //                   Icons.check_circle,
  //                   color: Colors.green,
  //                   size: 36,
  //                 ),
  //                 SizedBox(width: 10),
  //                 Text(
  //                   title,
  //                   style: TextStyle(
  //                     fontSize: 20,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             SizedBox(height: 10),
  //             Text(
  //               message,
  //               style: TextStyle(fontSize: 16),
  //               textAlign: TextAlign.start,
  //               softWrap: true,
  //             ),
  //             SizedBox(height: 20),
  //             Align(
  //               alignment: Alignment.centerRight,
  //               child: ElevatedButton(
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                 },
  //                 style: ElevatedButton.styleFrom(
  //                   shape: RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.circular(8),
  //                   ),
  //                   backgroundColor: AppColors.primarycolor,
  //                 ),
  //                 child: Text("OK", style: TextStyle(color: Colors.white),),
  //               ),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  // final PocketBaseService pocketBaseService = PocketBaseService();

  static Future<void> show(BuildContext context, String recordId, String token,
      PocketBaseService pocketBaseService,VoidCallback onDeleteSuccess) {
    // final provider = CartProvider.of(context, listen: false);
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icon(
                  //   Icons.check_circle,
                  //   color: Colors.green,
                  //   size: 36,
                  // ),
                  // SizedBox(width: 10),
                  Text(
                    "Are you absolutely sure?",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                "This action cannot be undone. This will permanently delete your address.",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
                softWrap: true,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
                      "No,Cancel",
                      style: TextStyle(color: AppColors.primarycolor),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await pocketBaseService.deleteAddress(recordId, token);
                      // provider.clearCart(); // Clear the cart
                      Navigator.of(context).pop(); // Close the dialog

                      onDeleteSuccess();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: AppColors.primarycolor,
                    ),
                    child: const Text(
                      "Yes,Delete",
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
