import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skmecom/model/featured_model.dart';

class CartProvider extends ChangeNotifier {
  final List<Product> _cart = [];
  List<Product> get cart => _cart;

  void toogleFavorite(Product product){
    if(_cart.contains(product)) {
      for (Product element in _cart) {
        // element.quantity++;

        element.quantity = (element.quantity ?? 0) + 1;
      }
    } else {
      _cart.add(product);
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