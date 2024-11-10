import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:skmecom/screens/loginscreen.dart';
import 'package:skmecom/store_local.dart';
import 'package:skmecom/utils/constants.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
    final AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Center(
        child:  SizedBox(
              height: 30,
              child: ElevatedButton.icon(
                onPressed: () {
                  authService.clearCredentials();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                label: const Text(
                  "Logout",
                  style: TextStyle(color: AppColors.primarycolor),
                ),
                icon: const Icon(
                  // Icons.login,
                   Remix.logout_box_line,
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
      ),
    
    );
  }
}
