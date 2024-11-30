import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:skmecom/provider/add_to_cart_provider.dart';
import 'package:skmecom/screens/accountscreen.dart';
import 'package:skmecom/screens/helpscreen.dart';
import 'package:skmecom/screens/home_navigation.dart';
import 'package:skmecom/screens/homescreen.dart';
import 'package:skmecom/screens/shopscreen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MultiProvider(
    providers: [

      // for add to cart
      ChangeNotifierProvider(create: (_) => CartProvider())

    ],
    child:  Sizer(builder: (context, orientation, screenType) {
      return MaterialApp(
        title: 'SKMCommerce',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Outfit',
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const HomeNavigation(),
        routes: {
          '/home': (context) => HomeScreen(),
          '/shop': (context) => ShopScreen(),
          '/help': (context) => HelpScreen(),
          '/account': (context) => AccountScreen()
        },
      );
    }
    )
 
    );
  }

