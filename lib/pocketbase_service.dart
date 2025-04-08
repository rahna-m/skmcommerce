import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:remixicon/remixicon.dart';
import 'package:skmecom/model/category_model.dart';
import 'package:skmecom/store_local.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;

class PocketBaseService {
  final PocketBase client = PocketBase(
      'http://commerce.sketchmonk.com:8090'); //  PocketBase server URL
      

// Login
  Future<bool> authenticate(String username, String password) async {
    final AuthService authService = AuthService();
    try {
      final result =
          await client.collection('users').authWithPassword(username, password);
      print("Logged in successfully!");
      print("user login result $result");

      // Extract required values
      final token = result.token;
      final record = result.record!;
      // final userId = record.id;
      print("user login result record $record");
      // Extract fields from record's raw JSON
      final rawRecord = record.toJson();
      final userId = rawRecord['id'];
      final userName = rawRecord['username'];
      final email = rawRecord['email'];
      final name = rawRecord['name'];
       final avatar = rawRecord['avatar'];
      // final verified = rawRecord['verified'];

      await authService.saveCredentials(userName, token, userId, email, name, avatar);

      // Save data to SharedPreferences
      // final prefs = await SharedPreferences.getInstance();
      // await prefs.setString('token', token);
      // await prefs.setString('userId', userId);
      // await prefs.setString('userName', userName);
      // await prefs.setString('email', email);
      // await prefs.setBool('verified', verified);
      return true;
    } catch (e) {
      print("Authentication failed: $e");
      return false;
    }
  }

// Register
  Future<bool> create(String name, String username, String email,
      String password, String passwordConfirm) async {
    final body = <String, dynamic>{
      "username": username,
      "email": email,
      "emailVisibility": true,
      "password": password,
      "passwordConfirm": passwordConfirm,
      "name": name
    };
    try {
      await client.collection('users').create(body: body);
      print("Registered successfully!");
      // (optional) send an email verification request
      await client.collection('users').requestVerification(email);
      print("Verification Request has been send to your email...");

      return true;
    } catch (e) {
      print("Authentication failed: $e");

      return false;
    }
  }

  // https://commerce.sketchmonk.com/_pb/api/collections/products/records?page=1&perPage=6&filter=featured%20%3D%20true&sort=&expand=category%2Cvariants_via_product

  Future<List<Map<String, dynamic>>> productsFeatured({
    required String collectionName,
    int page = 1,
    int perPage = 6,
    String filter = "",
    String sort = "",
    String expand = "category,variants_via_product",
  }) async {
    try {
      final query = {
        "page": page,
        "perPage": perPage,
        "filter": filter,
        "sort": sort,
        "expand": expand,
      };

      // Make sure to check how your API client accepts parameters
      final records =
          await client.collection(collectionName).getFullList(query: query);
      print("url $query");
      print("record $records");
      return records.map((record) => record.toJson()).toList();
    } catch (e) {
      print("Failed to fetch records: $e");
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> fetchCategories({
    int page = 1,
    int perPage = 12,
    String filter = "",
    String sort = "",
  }) async {
    try {
      final query = {
        "page": page,
        "perPage": perPage,
        "filter": filter,
        "sort": sort,
      };
      final records =
          await client.collection('categories').getFullList(query: query);
      print("cat record $records");
      return records.map((record) => record.toJson()).toList();
    } catch (e) {
      print("Failed to fetch records: $e");
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> fetchRecords(String collectionName) async {
    try {
      final records = await client.collection(collectionName).getFullList();

      print("address ${records}");
      return records.map((record) => record.toJson()).toList();
    } catch (e) {
      print("Failed to fetch records: $e");
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> fetchProducts({
    required String collectionName,
    int page = 1,
    int perPage = 6,
    String filter = "featured = true",
    String sort = "",
    String expand = "category,variants_via_product",
  }) async {
    try {
      final query = {
        "page": page,
        "perPage": perPage,
        "filter": filter,
        "sort": sort,
        "expand": expand,
      };

      // Make sure to check how your API client accepts parameters
      final records =
          await client.collection(collectionName).getFullList(query: query);

      return records.map((record) => record.toJson()).toList();
    } catch (e) {
      print("Failed to fetch records: $e");
      return [];
    }
  }

  // Future<bool> placeOrder({
  //   required  String token,
  //   required List<Map<String, dynamic>> products,
  //   required String deliveryType,
  //   required String paymentType,
  //   String comments = "",
  //   String address = "",
  // }) async {
  //   try {

  //       final pb = PocketBase('https://commerce.sketchmonk.com/_om/');
  //     // Build the request body
  //     final body = {
  //       "products": products,
  //       "deliveryType": deliveryType,
  //       "paymentType": paymentType,
  //       "comments": comments,
  //       "address": address,
  //     };

  //     // Send the POST request
  //     final response = await pb.collection('orders').create(body: body,
  //      headers: {
  //       'Authorization': 'Bearer $token', // Authentication
  //     },);

  //     print("Order placed successfully! Response: $response");
  //     return true;
  //   } catch (e) {
  //     print("Failed to place order: $e");
  //     return false;
  //   }
  // }


//   Future<bool> placeOrder({
//   required String token,
//   required List<Map<String, dynamic>> products,
//   required String deliveryType,
//   required String paymentType,
//   String comments = "",
//   String address = "",
// }) async {
//   try {
//     final url = Uri.parse('https://commerce.sketchmonk.com/_om/orders');

//     final body = jsonEncode({
//       "items": products,
//       "deliveryType": deliveryType,
//       "paymentType": paymentType,
//       "comments": comments,
//       "address": address,
//     });

//     final response = await http.post(
//       url,
//       headers: {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer $token',
//       },
//       body: body,
//     );

//     if (response.statusCode == 200 || response.statusCode == 201) {
//       print("Order placed successfully! Response: ${response.body}");
//       return true;
//     } else {
//       print("Failed with status ${response.statusCode}: ${response.body}");
//       return false;
//     }
//   } catch (e) {
//     print("Exception occurred while placing order: $e");
//     return false;
//   }
// }


Future<Map<String, dynamic>?> placeOrder({
  required String token,
  required List<Map<String, dynamic>> products,
  required String deliveryType,
  required String paymentType,
  String comments = "",
  String address = "",
}) async {
  try {
    final url = Uri.parse('https://commerce.sketchmonk.com/_om/orders');

    final body = jsonEncode({
      "items": products,
      "deliveryType": deliveryType,
      "paymentType": paymentType,
      "comments": comments,
      "address": address,
    });

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: body,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      print("Order placed successfully! Response: ${response.body}");
      return responseData; // ✅ Return response JSON
    } else {
      print("Failed with status ${response.statusCode}: ${response.body}");
      return null;
    }
  } catch (e) {
    print("Exception occurred while placing order: $e");
    return null;
  }
}



  Future<Map<String, dynamic>?> fetchUserById(String userId) async {
    try {
      final record = await client.collection('users').getOne(userId);
      print("User record: ${record.toJson()}");
      return record.toJson();
    } catch (e) {
      print("Failed to fetch user record: $e");
      return null;
    }
  }

  // Future<void> updateUser(String userId, Map<String, dynamic> data) async {
  //   try {
  //     await client.collection('users').update(userId, body: data);
  //     print("User updated successfully!");
  //   } catch (e) {
  //     print("Failed to update user: $e");
  //   }
  // }

//   Future<void> updateUser(String userId, String token, String name, PlatformFile? avatarFile) async {
//   try {
//     // Prepare the data map
//     Map<String, dynamic> data = {
//       'name': name,
//     };

//     // If an avatar file is provided, upload it first
//     if (avatarFile != null) {
//       // Replace with your upload logic to get the avatar URL
//       final avatarUrl = await uploadAvatar(avatarFile);
//       data['avatar'] = avatarUrl; // Add avatar URL to data
//     }

//     // Update the user in the database
//     await client.collection('users').update(userId, body: data);
//     print("User updated successfully!");
//   } catch (e) {
//     print("Failed to update user: $e");
//   }
// }


// Future<void> updateUser(String userId, String token, String name, PlatformFile? avatarFile) async {
//   try {
//     // Prepare the data map
//     Map<String, dynamic> data = {
//       'name': name,
//     };

//     // If an avatar file is provided, upload it first
//     if (avatarFile != null) {
//       // Replace with your upload logic to get the avatar URL
//       // final avatarUrl = await uploadAvatar(avatarFile);
//       data['avatar'] = avatarFile.name; // Add avatar URL to data
//     }

//     // Update the user in the database with authentication
//     await client.collection('users').update(
//       userId,
//       body: data,
//       headers: {
//         'Authorization': 'Bearer $token', // Pass token as Bearer authentication
//         'Content-Type': 'application/json', // Ensure correct content type
//       },
//     );

//     print("User updated successfully!");
//   } catch (e) {
//     print("Failed to update user: $e");
//   }
// }


Future<void> updateUser(BuildContext context, String userId, String token, String name, PlatformFile? avatarFile) async {
  try {
    // final pb = PocketBase('https://your-pocketbase-url.com');

    // Prepare body data
    final body = {'name': name};

    // Prepare file list
    List<http.MultipartFile> files = [];

    if (avatarFile != null && avatarFile.bytes != null) {
      files.add(
        http.MultipartFile.fromBytes(
          'avatar', // Field name in PocketBase
          avatarFile.bytes!,
          filename: avatarFile.name,
        ),
      );
    }

    // Update the user record in PocketBase with authentication
    final record = await client.collection('users').update(
      userId,
      body: body,
      files: files, // Always pass a List<MultipartFile>
      headers: {
        'Authorization': 'Bearer $token', // Authentication
      },
    );

    print("User updated successfully: ${record.toJson()}");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('User updated successfully!'),
          backgroundColor: Colors.green,
        ),
      );
  } catch (e) {
    print("Failed to update user: $e");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update user: $e'),
          backgroundColor: Colors.red,
        ),
      );
  }
}






// Future<String> uploadAvatar(PlatformFile avatarFile) async {
//   try {
//     // Upload logic here (this is a placeholder)
//     // Replace with the actual upload code to your backend or file storage
//     print("Uploading avatar: ${avatarFile.name}");
//     // Simulating upload and returning a dummy URL
//     await Future.delayed(const Duration(seconds: 2));
//     return "https://example.com/uploads/${avatarFile.name}";
//   } catch (e) {
//     print("Failed to upload avatar: $e");
//     rethrow;
//   }
// }

  Future<bool> AddAddress({
   required BuildContext context,
    required String building,
    required String city,
    required String contact,
    String landmark = "",
    required String name,
    required String pin,
    required String state,
    required String street,
    required String user,
    required String token,
  }) async {
    try {
      // Build the request body
      final body =  <String, dynamic>{
        "building": building,
        "city": city,
        "contact": contact,
        "landmark": landmark,
        "name": name,
        "pin": pin,
        "state": state,
        "street": street,
        "user": user,
      };

      // Send the POST request
      final response = await client.collection('addresses').create(body: body,
       headers: {
        "Authorization": "Bearer $token", // Add your token here
        "Content-Type": "application/json", // Example of content type
      },);

      print("Address added successfully! Response: $response");
        ScaffoldMessenger.of(context).showSnackBar(
      const  SnackBar(
          content: Text('Address added successfully!'),
          backgroundColor: Colors.green,
        ),
      );
      return true;
    } catch (e) {
      print("Failed to add address: $e");
       ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to add address: $e'),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }
  }

    Future<List<Map<String, dynamic>>> fetchAddress({
    required String collectionName,
     required String token,
    int page = 1,
    int perPage = 500,
    int skipTotal = 1,
    
  }) async {
    try {
      final query = {
        "page": page,
        "perPage": perPage,
        "skipTotal": skipTotal,
      
      };

      // Make sure to check how your API client accepts parameters
      final records =
          await client.collection(collectionName).getFullList(query: query,
           headers: {
        "Authorization": "Bearer $token", // Add your token here
        "Content-Type": "application/json", // Example of content type
      },);
       print("Address added successfully! Response: $records");

      return records.map((record) => record.toJson()).toList();
      
    } catch (e) {
      print("Failed to fetch address records: $e");
      return [];
    }
  }


  Future<void> deleteAddress(String recordId, String token) async {
  try {
    await client.collection('addresses').delete(recordId,
        headers: {
        "Authorization": "Bearer $token", // Add your token here
        "Content-Type": "application/json", // Example of content type
      },);
    print('Record deleted successfully');
  } catch (e) {
    print('Error deleting record: $e');
  }
}
}
