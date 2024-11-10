import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:skmecom/component/filtter_drawer.dart';
import 'package:skmecom/screens/accountscreen.dart';
import 'package:skmecom/screens/cartscreen.dart';
import 'package:skmecom/screens/helpscreen.dart';
import 'package:skmecom/screens/homescreen.dart';
import 'package:skmecom/screens/loginscreen.dart';
import 'package:skmecom/screens/shopscreen.dart';
import 'package:skmecom/store_local.dart';
import 'package:skmecom/utils/constants.dart';

class HomeNavigation extends StatefulWidget {
  final int? selectedIndex;
  const HomeNavigation({super.key,  this.selectedIndex});

  @override
  State<HomeNavigation> createState() => _HomeNavigationState();
}

class _HomeNavigationState extends State<HomeNavigation> {
  final AuthService authService = AuthService();
  int _selectedIndex =  0;
  String? _username;
  // String? _password;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex != null ? widget.selectedIndex ?? 0 : 0;
    getUserCredentials();
  }

  Future<void> getUserCredentials() async {
    Map<String, String?> credentials = await authService.getCredentials();
    setState(() {
      _username = credentials['username'];
      // _password = credentials['password'];
    });
  }

  Widget navigationPages(int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        return HomeScreen();
        break;
      case 1:
        return ShopScreen();
        break;
      case 2:
        return HelpScreen();
        break;
      case 3:
        return AccountScreen();
        break;

      default:
        return Center(child: Text("404"));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> bottomNavItems = [
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
      //  const BottomNavigationBarItem(
      //     icon: Icon(Remix.account_circle_line),
      //     label: 'Account',
      //   ),
    ];

    if (_username != null && _username!.isNotEmpty) {
      bottomNavItems.add(
        const BottomNavigationBarItem(
          icon: Icon(Remix.account_circle_line),
          label: 'Account',
        ),
      );
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
            _username == null
                ? SizedBox(
                    height: 30,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                      label: const Text(
                        "Login",
                        style: TextStyle(color: AppColors.primarycolor),
                      ),
                      icon: const Icon(
                        // Icons.login,
                        Remix.login_box_line,
                        size: 18,
                        color: AppColors.primarycolor,
                      ),
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          elevation: 0.0,
                          side: const BorderSide(
                              width: 1, color: AppColors.primarycolor)),
                    ),
                  )
                : SizedBox(),
            const SizedBox(width: 20),
             Padding(
              padding: EdgeInsets.only(right: 20),
              child: IconButton( icon: Icon(Remix.shopping_cart_2_line),
               onPressed: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen())); }, ),
            )
          ],
        ),
         endDrawer: const FilterDrawer(),
        body: navigationPages(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex, // Set the active index
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: bottomNavItems,
          // items: const <BottomNavigationBarItem>[
          //   BottomNavigationBarItem(
          //     icon: Icon(Remix.home_2_line),
          //     label: 'Home',
          //   ),
          //   BottomNavigationBarItem(
          //     icon: Icon(Remix.handbag_line),
          //     label: 'Shop',
          //   ),
          //   BottomNavigationBarItem(
          //     icon: Icon(Remix.lifebuoy_line),
          //     label: 'Help',
          //   ),
          //  _username == "" ? SizedBox():  BottomNavigationBarItem(
          //     icon: Icon(Remix.account_circle_line),
          //     label: 'Account',
          //   ),
          // ],
          selectedItemColor: AppColors.primarycolor,
          unselectedItemColor: Colors.black.withOpacity(0.58),
        ));
  }
}
