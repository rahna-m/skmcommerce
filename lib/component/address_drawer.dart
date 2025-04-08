import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:skmecom/component/custom_field.dart';
import 'package:skmecom/pocketbase_service.dart';
import 'package:skmecom/screens/home_navigation.dart';
import 'package:skmecom/store_local.dart';

class AddressDrawer extends StatefulWidget {
  @override
  State<AddressDrawer> createState() => _AddressDrawerState();
}

class _AddressDrawerState extends State<AddressDrawer> {
  final AuthService authService = AuthService();
  final PocketBaseService pocketBaseService = PocketBaseService();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _buildingController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _landmarkController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? city;
  String? state;
  String? userId;
  // String? token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjb2xsZWN0aW9uSWQiOiJfcGJfdXNlcnNfYXV0aF8iLCJleHAiOjE3MzcxMDk2MTksImlkIjoiNjQ5OTQyNjlqbXEyZjQzIiwicmVmcmVzaGFibGUiOnRydWUsInR5cGUiOiJhdXRoIn0.7jMWOB-THKxiHr0kPuc4roj-f1PZIPn0bjW0Oj2K0_0";
  String? token;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    getUserCredentials();
  }

  void _validate() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _errorMessage = null; // Clear error if validation passes
      });
    } else {
      setState(() {
        _errorMessage = 'Please enter a valid 10-digit phone number';
      });
    }
  }

  Future<void> getUserCredentials() async {
    Map<String, String?> credentials = await authService.getCredentials();
    setState(() {
      userId = credentials['userId'];
       token = credentials['token'];
    });

    print("get _userId on account $userId");
  }

  void handleAddAddress(
    String building,
    String city,
    String contact,
    String landmark,
    String name,
    String pin,
    String state,
    String street,
    String user,
    String token,
  ) async {
    // Call the `placeOrder` method
    final isSuccess = await pocketBaseService.AddAddress(
      
        building: building,
        city: city,
        contact: contact,
        name: name,
        pin: pin,
        state: state,
        street: street,
        user: user,
        token: token, context: context);

    print(
        "Address $building, $city, $contact, $name, $pin, $state, $street, $user");

    // Show a success or error message
    if (isSuccess) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text("Address added successfully!")),
      // );
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HomeNavigation(
                    selectedIndex: 3,
                    filter: 'address',
                  )));

      // Navigator.of(context).push(MaterialPageRoute(builder: (context) => AccountScreen(initialTabIndex: 1)));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to add address.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Add Address',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            leading: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context); // Close the drawer or screen
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name Field

                    CustomTextField(
                      label: 'Name',
                      hintText: 'Name to identify the address',
                      controller: _nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Name is required';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    // Building Field

                    CustomTextField(
                      label: 'Building',
                      hintText: 'Flat no. / House no. etc.',
                      controller: _buildingController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Building name is required';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    // Street Field

                    CustomTextField(
                      label: 'Street',
                      hintText: 'e.g. 4th block',
                      controller: _streetController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Street name is required';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    Row(
                      children: [
                        const Text(
                          "* ",
                          style: TextStyle(color: Colors.red),
                        ),
                        Text(
                          "City",
                          style: TextStyle(fontSize: 16.sp),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      items: ['Banglore']
                          .map((city) => DropdownMenuItem(
                                value: city,
                                child: Text(city),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          city = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a city';
                        }
                        return null; // No error
                      },
                      decoration: InputDecoration(
                        hintText: 'Select city',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    Row(
                      children: [
                        const Text(
                          "* ",
                          style: TextStyle(color: Colors.red),
                        ),
                        Text(
                          "State",
                          style: TextStyle(fontSize: 16.sp),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      items: ['Karnataka']
                          .map((state) => DropdownMenuItem(
                                value: state,
                                child: Text(state),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          state = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a state';
                        }
                        return null; // No error
                      },
                      decoration: InputDecoration(
                        hintText: 'Select state',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    CustomTextField(
                      isRequired: false,
                      label: 'Landmark',
                      hintText:
                          'Nearby point of interest or prominent location',
                      controller: _landmarkController,
                    ),

                    const SizedBox(height: 16),

                    // pin

                    CustomTextField(
                      label: 'PIN',
                      hintText: '6 digit pin/zip code of the area',
                      controller: _pinController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'PIN is required';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    // Contact no

                    Row(
                      children: [
                        const Text(
                          "* ",
                          style: TextStyle(color: Colors.red),
                        ),
                        Text(
                          "Contact Number",
                          style: TextStyle(fontSize: 16.sp),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            // Country Code Dropdown
                            Container(
                              width: 80,
                              height: 48,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade400),
                                borderRadius: const BorderRadius.horizontal(
                                    left: Radius.circular(8)),
                              ),
                              child: const Center(
                                child: Text(
                                  '+91',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ),

                            // Phone Number Input Field
                            Expanded(
                              child: TextFormField(
                                controller: _contactController,
                                keyboardType: TextInputType.phone,
                                decoration: const InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 16),
                                  hintText: 'a phone number to contact',
                                  hintStyle: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.horizontal(
                                      right: Radius.circular(8),
                                    ),
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                ),
                                validator: (value) {
                                  // setState(() {
                                  //   _validate();
                                  // });

                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a phone number';
                                  } else if (!RegExp(r'^[0-9]{10}$')
                                      .hasMatch(value)) {
                                    return 'Please enter a valid 10-digit phone number';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),

                        // Error Message
                        if (_errorMessage != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              _errorMessage!,
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            color: Colors.white,
            child: ElevatedButton(
              onPressed: () {
                // Handle submit action

                if (_formKey.currentState!.validate()) {
                  print("form is valid");

                  print(
                      "address data : ${_buildingController.text}, ${city.toString()},${_contactController.text},${_landmarkController.text}, ${_nameController.text}, ${state.toString()},${_pinController.text},${_streetController.text}, ${userId.toString()}");
                  print("token $token");
                  handleAddAddress(
                      _buildingController.text, // building name
                      city.toString(), //city
                      _contactController.text, // contact
                      _landmarkController.text, // landmark
                      _nameController.text, //name
                      _pinController.text, //pin
                      state.toString(), //state
                      _streetController.text, // street
                      userId.toString(), // user id
                      token.toString()); 

          //            Navigator.push(
          // context,
          // MaterialPageRoute(
          //     builder: (context) => HomeNavigation(
          //           selectedIndex: 3,
          //           filter: 'address',
                   
                    
          //         )));
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,

                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),

                minimumSize: const Size.fromHeight(60), // Full-width button
              ),
              child: Text(
                'Submit',
                style: TextStyle(color: Colors.white, fontSize: 16.sp),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
