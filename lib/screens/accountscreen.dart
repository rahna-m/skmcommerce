import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:skmecom/component/address_drawer.dart';
import 'package:skmecom/component/custom_btn.dart';
import 'package:skmecom/pocketbase_service.dart';
import 'package:skmecom/screens/loginscreen.dart';
import 'package:skmecom/store_local.dart';
import 'package:skmecom/utils/constants.dart';

class AccountScreen extends StatefulWidget {
    final int initialTabIndex;

  const AccountScreen({super.key, this.initialTabIndex = 0});


  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> with SingleTickerProviderStateMixin {
  final AuthService authService = AuthService();
  final PocketBaseService pocketBaseService = PocketBaseService();

  String? _name;
  String? _email;
  String? _username;
  String? userId;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
   late TabController _tabController;

  // Future<void> fetchUserDetails() async {
  //   final userRecord = await pocketBaseService.fetchUserById('64994269jmq2f43');
  //   print(userRecord);
  // }

 


  @override
  void initState() {
    super.initState();
    getUserCredentials();
    _tabController = TabController(length: 2, vsync: this,  initialIndex: widget.initialTabIndex);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void navigateToAddressesTab() {
    _tabController.animateTo(1); // Navigate to the second tab
  }

  Future<void> getUserCredentials() async {
    Map<String, String?> credentials = await authService.getCredentials();
    setState(() {
      _username = credentials['username'];
      _name = credentials['name'];
      _email = credentials['email'];
      userId = credentials['userId'];

      usernameController.text = _username ?? '';
      nameController.text = _name ?? '';
      emailController.text = _email ?? '';
    });

    print("get _userId on account $userId");
  }

 

  PlatformFile? selectedFile;

  Future<void> pickFile() async {
    try {
      // Open the file picker to select an image
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );

      if (result != null && result.files.isNotEmpty) {
        setState(() {
          selectedFile = result.files.first;
        });
        print("File picked: ${selectedFile!.name}");
      } else {
        print("No file selected");
      }
    } catch (e) {
      print("Error picking file: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          toolbarHeight: 0,
          // title: const Text("Account"),
          bottom:  TabBar(
            controller: _tabController,
            tabAlignment: TabAlignment.center,
            indicatorColor: AppColors.primarycolor,
            labelColor: AppColors.primarycolor,
            unselectedLabelColor: Colors.black54,
            tabs: [
              Tab(text: "Profile"),
              Tab(text: "Addresses"),
            ],
          ),
        ),
        body: TabBarView(
           controller: _tabController,
          children: [
            // Profile Tab Content
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Container(
                      //  padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.white, // Background color

                        borderRadius:
                            BorderRadius.circular(10), // Rounded corners
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 20),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "General",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),
                                )),
                          ),
                          const Divider(),
                          const SizedBox(height: 20),
                          Center(
                            child: Column(
                              children: [
                                // Avatar Upload Section

                                GestureDetector(
                                  onTap: pickFile,
                                  child: CircleAvatar(
                                    radius: 50,
                                    backgroundColor: Colors.grey[200],
                                    backgroundImage: selectedFile != null
                                        ? MemoryImage(selectedFile!.bytes!)
                                        : null,
                                    child: selectedFile == null
                                        ? const Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Remix.image_add_line,
                                                color: Colors.black45,
                                                size: 20,
                                              ),
                                              Text("Upload")
                                            ],
                                          )
                                        : null,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  "Upload an image to set as your avatar",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black54),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // User Information Form
                                const Text(
                                  "Name",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                                const SizedBox(height: 8),
                                TextField(
                                  controller: nameController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    hintText: "Enter your name",
                                  ),
                                ),
                                const SizedBox(height: 16),

                                const Text(
                                  "Email",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                                const SizedBox(height: 8),
                                TextField(
                                  controller: emailController,
                                  enabled: false, // Email is non-editable
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    hintText: "Enter your email",
                                  ),
                                ),
                                const SizedBox(height: 16),

                                const Text(
                                  "Username",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                                const SizedBox(height: 8),
                                TextField(
                                  controller: usernameController,
                                  enabled: false,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    hintText: "Enter your username",
                                  ),
                                ),
                                const SizedBox(height: 30),
                              ],
                            ),
                          ),
                          const Divider(),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Align(
                                alignment: Alignment.center,
                                child: ElevatedButton.icon(
                                  icon: Icon(
                                    Remix.save_2_line,
                                    color: Colors.white,
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primarycolor
                                          .withOpacity(0.78),
                                      elevation: 2,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  label: Text(
                                    "Save",
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {
                                    final data = {
                                      "name": nameController.text,
                                    };

                                    pocketBaseService.updateUser(
                                        userId.toString(), data);
                                  },
                                )),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    // Logout Button
                    SizedBox(
                      height: 40,
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          //  logout

                          authService.clearCredentials();

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        },
                        icon: const Icon(
                          Remix.logout_box_line,
                          size: 18,
                          color: AppColors.primarycolor,
                        ),
                        label: const Text(
                          "Logout",
                          style: TextStyle(color: AppColors.primarycolor),
                        ),
                        style: ElevatedButton.styleFrom(
                            // backgroundColor: Colors.white,
                            elevation: 0.0,
                            side: const BorderSide(
                              width: 1,
                              color: AppColors.primarycolor,
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Addresses Tab Content
            Center(
                child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("No Addresses found"),
                  SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                    title: "+ Add Address",
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddressDrawer()));
                    },
                  )
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
