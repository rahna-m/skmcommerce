import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:skmecom/utils/constants.dart';

enum BottomNavItem { home, shop, help }

class CustomBottomNavigationBar extends StatefulWidget {
  final BottomNavItem currentItem;

  const CustomBottomNavigationBar({
    Key? key,
    required this.currentItem,
  }) : super(key: key);

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  late BottomNavItem _selectedItem;

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.currentItem;
  }

  void _onItemTapped(int index) {
    // Get the selected item based on the tapped index
    final selectedItem = BottomNavItem.values[index];

    if (_selectedItem == selectedItem) return; // Prevent redundant navigation

    setState(() {
      _selectedItem = selectedItem;
    });

    // Navigate to the corresponding route based on the selected item
    switch (selectedItem) {
      case BottomNavItem.home:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case BottomNavItem.shop:
        Navigator.pushReplacementNamed(context, '/shop');
        break;
      case BottomNavItem.help:
        Navigator.pushReplacementNamed(context, '/help');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedItem.index, // Set the active index
      onTap: _onItemTapped, // Handle item taps
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Remix.home_2_line),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Remix.handbag_line),
          label: 'Shop',
        ),
        BottomNavigationBarItem(
          icon: Icon(Remix.lifebuoy_line),
          label: 'Help',
        ),
      ],
      selectedItemColor: AppColors.primarycolor,
      unselectedItemColor: Colors.black.withOpacity(0.58),
    );
  }
}
