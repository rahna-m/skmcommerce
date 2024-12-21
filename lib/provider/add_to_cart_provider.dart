import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skmecom/model/featured_model.dart';

class CartProvider extends ChangeNotifier {
  final List<Product> _cart = [];
  List<Product> get cart => _cart;

  // void toogleFavorite(Product product){
  //   if(_cart.contains(product)) {
  //     for (Product element in _cart) {
  //       // element.quantity++;

  //       element.quantity = (element.quantity ?? 0) + 1;
  //     }
  //   } else {
  //     _cart.add(product);
  //   }
  //   notifyListeners();
  // }

  void clearCart() {
  _cart.clear();
  notifyListeners();
}

  void toogleFavorite(Product product) {
    // Check if product already exists in the cart
    final index = cart.indexWhere((item) => item.id == product.id);
    if (index != -1) {
      // Update the quantity of the existing product
      // cart[index].quantity += product.quantity;

      cart[index].quantity = (cart[index].quantity ?? 0) + (product.quantity ?? 0);
    } else {
      // Add new product to the cart
      cart.add(product);
    }
    notifyListeners();
  }

  //  for increment
  incrementQtn(int index){
    _cart[index].quantity = ( _cart[index].quantity ?? 1) + 1;
     notifyListeners();
  }

   //  for decrement
  decrementQtn(int index){
    if (_cart[index].quantity! <= 1){
      return;
    }
    _cart[index].quantity = ( _cart[index].quantity ?? 1) - 1;
     notifyListeners();
  }

    // for without discount total amount
  actualPrice(){
    double myTotal = 0.0;
    for (Product element in _cart) {
      // myTotal += element.discountPrice * element.quantity;

      myTotal += (element.actualPrice) * (element.quantity ?? 0);
    }

    return myTotal;
  }

     // for without discount total amount
  discountPrice(){
    double myTotal = 0.0;
    for (Product element in _cart) {
      // myTotal += element.discountPrice * element.quantity;

      myTotal += (element.actualPrice - element.discountPrice) * (element.quantity ?? 0);
    }

    return myTotal;
  }

  // for total amount
  totalPrice(){
    double myTotal = 0.0;
    for (Product element in _cart) {
      // myTotal += element.discountPrice * element.quantity;

      myTotal += (element.discountPrice) * (element.quantity ?? 0);
    }

    return myTotal;
  }

  static CartProvider of(BuildContext context, {bool listen = true}){
    return Provider.of<CartProvider>(context, listen: listen);
  }
}