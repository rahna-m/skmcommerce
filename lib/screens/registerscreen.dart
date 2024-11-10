import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:sizer/sizer.dart';
import 'package:skmecom/component/custom_field.dart';
import 'package:skmecom/component/custom_password_field.dart';
import 'package:skmecom/component/successpopup.dart';
import 'package:skmecom/pocketbase_service.dart';
import 'package:skmecom/screens/loginscreen.dart';
import 'package:skmecom/utils/constants.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final PocketBaseService pocketBaseService = PocketBaseService();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final emailRegex =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

  void Register() async {
    final username = _usernameController.text;
    final password = _passwordController.text;
    final name = _nameController.text;
    final email = _emailController.text;
    final passwordConfirm = _confirmPasswordController.text;

    if (await pocketBaseService.create(
        name, username, email, password, passwordConfirm)) {
      SuccessDialog.show(
        context,
        'Registration Successful',
        'Please check your email for verification link.',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE0ECF4), // Background color from your design
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
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
                            'Register',
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
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              CustomTextField(
                                label: 'Name',
                                hintText: 'your full name',
                                controller: _nameController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Name is required';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 30),
                              CustomTextField(
                                label: 'Email',
                                hintText: 'your personal email id',
                                controller: _emailController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Email is required';
                                  }

                                  if (!emailRegex.hasMatch(value)) {}
                                  return null;
                                },
                              ),
                              SizedBox(height: 30),
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
                              SizedBox(height: 30),
                              CustomPasswordTextField(
                                label: 'Password',
                                hintText: 'your secret password',
                                controller: _passwordController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Password is required';
                                  }
                                  if (value.length < 8) {
                                    return 'Password must be at least 8 characters long';
                                  }
                                  if (!RegExp(r'[A-Z]').hasMatch(value)) {
                                    return 'Password must contain at least one uppercase letter';
                                  }
                                  if (!RegExp(r'[a-z]').hasMatch(value)) {
                                    return 'Password must contain at least one lowercase letter';
                                  }
                                  if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]')
                                      .hasMatch(value)) {
                                    return 'Password must contain at least one special character';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 30),
                              CustomPasswordTextField(
                                label: 'Confirm Password',
                                hintText: 're-enter previous password',
                                controller: _confirmPasswordController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Confirm Password is required';
                                  }
                                  if (_passwordController.text != value
                                          ) {
                                    return 'Password does not match';
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
                                    // Handle register action

                                    if (_formKey.currentState!.validate()) {
                                      print("form is valid");
                                      Register();
                                    }
                                  },
                                  icon: Icon(
                                    // Icons.login,
                                    Remix.file_edit_line,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                  label: Text(
                                    'Register',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16.sp),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    // iconColor: Colors.white,
                                    backgroundColor:
                                        AppColors.primarycolor, // Button color
                                    minimumSize: Size(double.infinity,
                                        50), // Full-width button
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text.rich(
                  TextSpan(
                    text: "Already have an account? ",
                    style: TextStyle(color: Colors.grey, fontSize: 16.sp),
                    children: [
                      TextSpan(
                        text: "Login",
                        style: TextStyle(color: AppColors.primarycolor),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()),
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
