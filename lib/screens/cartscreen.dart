import 'package:flutter/material.dart';
import 'package:skmecom/model/featured_model.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cart", style: TextStyle(fontWeight: FontWeight.w600),), backgroundColor: Colors.white,),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Cart Items", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),),
          ),
          Expanded(child: Center(child: Text("No Data"),))
        ],
      ),
    );
  }
}