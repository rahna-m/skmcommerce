import 'package:flutter/material.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text("Coming soon"),
      ),
      //  bottomNavigationBar: CustomBottomNavigationBar(
      //     currentItem: BottomNavItem.home,
      //   ),
    );
  }
}
