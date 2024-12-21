import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:remixicon/remixicon.dart';
import 'package:skmecom/model/category_model.dart';
import 'package:skmecom/store_local.dart';

class PocketBaseService {
  final PocketBase client = PocketBase(
      'http://commerce.sketchmonk.com:8090'); //  PocketBase server URL


// Login
  Future<bool> authenticate(String username, String password) async {

     final AuthService authService = AuthService();
    try {
    final result =   await client.collection('users').authWithPassword(username, password);
      print("Logged in successfully!");
        print("user login result $result" );


    // Extract required values
    final token = result.token;
     final record = result.record!;
    // final userId = record.id;
         print("user login result record $record" );
    // Extract fields from record's raw JSON
    final rawRecord = record.toJson();
    final userId = rawRecord['id'];
    final userName = rawRecord['username'];
    final email = rawRecord['email'];
       final name = rawRecord['name'];
    // final verified = rawRecord['verified'];

      await authService.saveCredentials(userName,token, userId, email, name);

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
    final records = await client.collection(collectionName).getFullList(query: query);
    print("url $query" );
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
    final records = await client.collection('categories').getFullList(query: query);
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

   Future<bool> placeOrder({
    required List<Map<String, dynamic>> products,
    required String deliveryType,
    required String paymentType,
    String comments = "",
    String address = "",
  }) async {
    try {
      // Build the request body
      final body = {
        "products": products,
        "deliveryType": deliveryType,
        "paymentType": paymentType,
        "comments": comments,
        "address": address,
      };

      // Send the POST request
      final response = await client.collection('orders').create(body: body);

      print("Order placed successfully! Response: $response");
      return true;
    } catch (e) {
      print("Failed to place order: $e");
      return false;
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


    Future<void> updateUser(String userId, Map<String, dynamic> data) async {
  try {
    await client.collection('users').update(userId, body: data);
    print("User updated successfully!");
  } catch (e) {
    print("Failed to update user: $e");
  }
}
}



