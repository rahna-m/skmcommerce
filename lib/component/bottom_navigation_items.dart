// Update BottomNavigationItem
import 'package:flutter/material.dart';
import 'package:skmecom/screens/accountscreen.dart';
import 'package:skmecom/screens/helpscreen.dart';
import 'package:skmecom/screens/homescreen.dart';
import 'package:skmecom/screens/shopscreen.dart';

class BottomNavigationItem {
  final IconData icon;
  final String name;
  final Widget screen;

  const BottomNavigationItem({
    required this.icon,
    required this.name,
    required this.screen,
  });
}

// Example Screens
const List<BottomNavigationItem> bottomNavigationItems = [
  BottomNavigationItem(icon: Icons.home, name: "Home", screen: HomeScreen()),
  BottomNavigationItem(icon: Icons.shopping_cart, name: "Shop", screen: ShopScreen()),
  BottomNavigationItem(icon: Icons.favorite, name: "Help", screen: HelpScreen()),
  BottomNavigationItem(icon: Icons.account_circle, name: "Account", screen: AccountScreen()),
];

// Navigation Logic
// void _onItemTapped(int index) {
//   Navigator.push(
//     context,
//     MaterialPageRoute(builder: (context) => bottomNavigationItems[index].screen),
//   );
// }
