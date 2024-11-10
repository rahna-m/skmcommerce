import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:remixicon/remixicon.dart';
import 'package:skmecom/model/category_model.dart';

class PocketBaseService {
  final PocketBase client = PocketBase(
      'http://commerce.sketchmonk.com:8090'); // Replace with your PocketBase server URL


// Login
  Future<bool> authenticate(String username, String password) async {
    try {
    final result =   await client.collection('users').authWithPassword(username, password);
      print("Logged in successfully!");
        print(result );
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
    final records = await client.collection(collectionName).getFullList(query: query);
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
      return records.map((record) => record.toJson()).toList();
    } catch (e) {
      print("Failed to fetch records: $e");
      return [];
    }
  }
}
