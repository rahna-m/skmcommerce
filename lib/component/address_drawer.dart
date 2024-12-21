import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:skmecom/component/custom_field.dart';

class AddressDrawer extends StatefulWidget {
  @override
  State<AddressDrawer> createState() => _AddressDrawerState();
}

class _AddressDrawerState extends State<AddressDrawer> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _buildingController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _landmarkController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
                        Text(
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
                      items: ['City 1', 'City 2', 'City 3']
                          .map((city) => DropdownMenuItem(
                                value: city,
                                child: Text(city),
                              ))
                          .toList(),
                      onChanged: (value) {},
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
                        Text(
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
                      items: ['State 1', 'State 2', 'State 3']
                          .map((state) => DropdownMenuItem(
                                value: state,
                                child: Text(state),
                              ))
                          .toList(),
                      onChanged: (value) {},
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
                      hintText: 'Nearby point of interest or prominent location',
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
                        Text(
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
                
                    Row(
                      children: [
                        // Country Code Dropdown
                        Container(
                          width: 80,
                          height: 48,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade400),
                            borderRadius:
                                BorderRadius.horizontal(left: Radius.circular(8)),
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
                          child: TextField(
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
