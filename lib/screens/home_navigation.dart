import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';
import 'package:skmecom/component/filtter_drawer.dart';
import 'package:skmecom/provider/add_to_cart_provider.dart';
import 'package:skmecom/screens/accountscreen.dart';
import 'package:skmecom/screens/cartscreen.dart';
import 'package:skmecom/screens/helpscreen.dart';
import 'package:skmecom/screens/homescreen.dart';
import 'package:skmecom/screens/loginscreen.dart';
import 'package:skmecom/screens/shopscreen.dart';
import 'package:skmecom/store_local.dart';
import 'package:skmecom/utils/constants.dart';
import 'package:badges/badges.dart' as badges;

class HomeNavigation extends StatefulWidget {
  final int? selectedIndex;
  final String? filter;
  final String? source;
  // final bool showCheckout;
  const HomeNavigation({
    super.key,
    this.selectedIndex,
    this.filter,
    this.source,
    // this.showCheckout = false,
  });

  @override
  State<HomeNavigation> createState() => _HomeNavigationState();
}

class _HomeNavigationState extends State<HomeNavigation> {
  final AuthService authService = AuthService();
  int _selectedIndex = 0;
  String? _username;
  // String? _password;

  @override
  void initState() {
    super.initState();
    _selectedIndex =
        widget.selectedIndex != null ? widget.selectedIndex ?? 0 : 0;
    getUserCredentials();
  }

  Future<void> getUserCredentials() async {
    Map<String, String?> credentials = await authService.getCredentials();
    setState(() {
      _username = credentials['username'];
      // _password = credentials['password'];
    });

    print("get username $_username");
  }

  Widget navigationPages(int selectedIndex) {
    // if (widget.showCheckout) {
    //   return const CheckoutScreen(); // Show CheckoutScreen directly
    // }
    switch (selectedIndex) {
      case 0:
        return HomeScreen();
      case 1:
        return ShopScreen(
          filter: widget.source == "cat"
              ? widget.filter
              : null, // Reset the filter if it's not a category source
          source: widget.source,
        );
      case 2:
        return HelpScreen();
      case 3:
        return AccountScreen(
          initialTabIndex: widget.filter == 'address' ? 1 : 0,
        );
      default:
        return const Center(
            child: Text("404")); // Use const for stateless widgets
    }
  }

  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> allNavItems = [
      const BottomNavigationBarItem(
        icon: Icon(Remix.home_2_line),
        label: 'Home',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Remix.handbag_line),
        label: 'Shop',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Remix.lifebuoy_line),
        label: 'Help',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Remix.account_circle_line),
        label: 'Account',
      ),
    ];

    // if (_username != null && _username!.isNotEmpty) {
    //   bottomNavItems.add(
    //     const BottomNavigationBarItem(
    //       icon: Icon(Remix.account_circle_line),
    //       label: 'Account',
    //     ),
    //   );
    // }

   List<BottomNavigationBarItem> bottomNavItems = allNavItems.where((item) {
    if (item.label == 'Account') {
      return _username != null && _username!.isNotEmpty;
    }
    return true;
  }).toList();

  // Ensure the selected index is valid
  if (_selectedIndex >= bottomNavItems.length) {
    _selectedIndex = 0; // Default to the first tab
  }

    return Scaffold(
      endDrawerEnableOpenDragGesture: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
        scrolledUnderElevation: 0,
        toolbarHeight: 80,
        title: const Text("SKMCOMMERCE"),
        actions: [
          if (_username == null)
            SizedBox(
              height: 30,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                label: const Text(
                  "Login",
                  style: TextStyle(color: AppColors.primarycolor),
                ),
                icon: const Icon(
                  Remix.login_box_line,
                  size: 18,
                  color: AppColors.primarycolor,
                ),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  elevation: 0.0,
                  side:
                      const BorderSide(width: 1, color: AppColors.primarycolor),
                ),
              ),
            ),
          const SizedBox(width: 20),
          // Padding(
          //   padding: const EdgeInsets.only(right: 20),
          //   child: IconButton(
          //     icon: const Icon(Remix.shopping_cart_2_line),
          //     onPressed: () {
          //       Navigator.push(context,
          //           MaterialPageRoute(builder: (context) => CartScreen()));
          //     },
          //   ),
          // )

          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Consumer<CartProvider>(
                builder: (context, cartProvider, child) {
                  return InkWell(
                    onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => CartScreen()));
                    },
                    child: badges.Badge(
            badgeContent: Text(
              '${cartProvider.totalCartItems}',
              style: const TextStyle(color: Colors.white, fontSize: 10),
            ),
            showBadge: cartProvider.totalCartItems >= 0,
            position: badges.BadgePosition.topEnd(top: -10, end: -4),
            badgeStyle: const badges.BadgeStyle(
              badgeColor: Colors.green,
              padding: EdgeInsets.all(6),
            ),
            child: const Icon(Icons.shopping_cart_outlined),
                    ),
                  );
                },
              ),
          ),
        ],
      ),
      endDrawer: const FilterDrawer(),
      body:
          // widget.showCheckout
          //     ? const CheckoutScreen()
          //     :
          navigationPages(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, // Set the active index
          onTap: (index) {
        setState(() {
          _selectedIndex = index;
          print("selected index $_selectedIndex");
        });
      },
        type: BottomNavigationBarType
            .fixed, // Ensure icons and labels are visible
        items: bottomNavItems,
        selectedItemColor: AppColors.primarycolor,
        unselectedItemColor: Colors.black.withOpacity(0.58),
      ),
    );
  }
}
