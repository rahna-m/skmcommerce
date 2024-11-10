import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:sizer/sizer.dart';
import 'package:skmecom/component/custom_field.dart';
import 'package:skmecom/component/custom_password_field.dart';
import 'package:skmecom/pocketbase_service.dart';
import 'package:skmecom/screens/home_navigation.dart';
import 'package:skmecom/screens/registerscreen.dart';
import 'package:skmecom/store_local.dart';
import 'package:skmecom/utils/constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final PocketBaseService pocketBaseService = PocketBaseService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService authService = AuthService();

  void saveUserCredentials(String user, String pswd) async {
  await authService.saveCredentials(user, pswd);
  print("Credentials saved.");
}

 void login() async {
    final username = _usernameController.text;
    final password = _passwordController.text;

     if (await pocketBaseService.authenticate(username, password)) {

     saveUserCredentials(username,password);
      // If login is successful, navigate to the dashboard
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeNavigation()),
      );
    } else {
      // Show error message if authentication fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Authentication failed.'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(top: 20.0), // Position it at the top
          duration: Duration(seconds: 3),
        ),
      );
    }

  //   try {
  //  await pocketBaseService.authenticate(username, password);

 


  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (context) => HomeScreen()),
  //     );
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text("Authentication failed: ${e.toString()}"),
  //         backgroundColor: Colors.red,
  //         duration: Duration(seconds: 3),
  //       ),
  //     );
  //   }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE0ECF4), // Background color from your design
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  // padding: const EdgeInsets.all(24.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: AppColors.graycolor.withOpacity(0.8))
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Colors.black.withOpacity(0.1),
                      //     blurRadius: 10,
                      //     offset: Offset(0, 5),
                      //   ),
                      // ],
                      ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24.0, vertical: 10.0),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: AppColors.graycolor
                                          .withOpacity(0.8)))),
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          children: [
                            CustomTextField(
                              label: 'Username',
                              hintText: 'your username',
                              controller: _usernameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Username is required';
                                }
                                return null;
                              },
                            ),
                          
                            SizedBox(height: 20),
                            CustomPasswordTextField(
                              label: 'Password',
                              hintText: 'your secret password',
                              controller: _passwordController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Password is required';
                                }
                                return null;
                              },
                            ),
                          
                            SizedBox(height: 30),
                            Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    blurRadius: 5,
                                    offset: Offset(2, 5),
                                  ),
                                ],
                              ),
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  // Handle login action

                                  if (_formKey.currentState!.validate()) {
                                    print("form is valid");
                                    login();
                                  }
                                },
                                icon: Icon(
                                  // Icons.login,
                                  Remix.login_box_line,
                                  size: 20,
                                  color: Colors.white,
                                ),
                                label: Text(
                                  'Login',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16.sp),
                                ),
                                style: ElevatedButton.styleFrom(
                                  // iconColor: Colors.white,
                                  backgroundColor:
                                      AppColors.primarycolor, // Button color
                                  minimumSize: Size(
                                      double.infinity, 50), // Full-width button
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                // TextButton(
                //   onPressed: () {
                //     // Navigate to register screen
                //   },
                // child:
                Text.rich(
                  TextSpan(
                    text: "Don't have an account? ",
                    style: TextStyle(color: Colors.grey, fontSize: 16.sp),
                    children: [
                      TextSpan(
                        text: "Register",
                        style: TextStyle(color: AppColors.primarycolor),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterScreen()),
                            );
                          },
                      ),
                    ],
                  ),
                ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
