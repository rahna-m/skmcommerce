import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:skmecom/component/address_card.dart';
import 'package:skmecom/component/address_drawer.dart';
import 'package:skmecom/component/confirmpopup.dart';
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

class _AccountScreenState extends State<AccountScreen>
    with SingleTickerProviderStateMixin {
  final AuthService authService = AuthService();
  final PocketBaseService pocketBaseService = PocketBaseService();
  String? _avatar;
  String? _name;
  String? _email;
  String? _username;
  String? userId;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  late TabController _tabController;
  List result = [];
  String? token;

  @override
  void initState() {
    super.initState();
    getUserCredentials();
    fetchAllAddress();
    _tabController = TabController(
        length: 2, vsync: this, initialIndex: widget.initialTabIndex);
    // fetchAllAddress();
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
      _avatar = credentials['avatar'];
      _name = credentials['name'];
      _email = credentials['email'];
      userId = credentials['userId'];
      token = credentials['token'];

      usernameController.text = _username ?? '';
      nameController.text = _name ?? '';
      emailController.text = _email ?? '';
    });

    print("get _userId on account $userId");
    print("get _avatar on account $_avatar");
  }

  PlatformFile? selectedFile;

  Future<void> pickFile() async {
    try {
      // Open the file picker to select an image
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        withData: true, // Ensure bytes are loaded
      );

      if (result != null && result.files.isNotEmpty) {
        setState(() {
          selectedFile = result.files.first;
        });
        print("File picked: ${selectedFile!.name}");
        print("File bytes length: ${selectedFile!.bytes?.length}");
      } else {
        print("No file selected");
      }
    } catch (e) {
      print("Error picking file: $e");
    }
  }

  Future<void> fetchAllAddress() async {
    Map<String, String?> credentials = await authService.getCredentials();
    String? tokens = credentials['token'];
    final addressJson = await pocketBaseService.fetchAddress(
      collectionName: 'addresses',
      token: tokens.toString(),
      page: 1,
      perPage: 500,
      skipTotal: 1,
    );

    setState(() {
       result = addressJson.cast<Map<String, dynamic>>() ?? [];
      //  result = [];
    });

    print("Address list: $result");
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
          bottom: TabBar(
            controller: _tabController,
            tabAlignment: TabAlignment.center,
            indicatorColor: AppColors.primarycolor,
            labelColor: AppColors.primarycolor,
            unselectedLabelColor: Colors.black54,
            tabs: const [
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
                                GestureDetector(
                                  onTap: pickFile,
                                  child: CircleAvatar(
                                    radius: 50,
                                    backgroundColor: Colors.grey[200],
                                    backgroundImage: selectedFile != null &&
                                            selectedFile!.bytes != null
                                        ? MemoryImage(selectedFile!.bytes!)
                                        : (_avatar != null &&
                                                _avatar!.isNotEmpty
                                            ?
                                            // NetworkImage(_avatar!)
                                            //     as ImageProvider
                                            NetworkImage(
                                                    "https://commerce.sketchmonk.com/_pb/api/files/_pb_users_auth_/${userId.toString()}/$_avatar")
                                                as ImageProvider
                                            : null),
                                    child: (selectedFile == null &&
                                            (_avatar == null ||
                                                _avatar!.isEmpty))
                                        ? const Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.add_a_photo,
                                                color: Colors.black45,
                                                size: 20,
                                              ),
                                              Text("Upload"),
                                            ],
                                          )
                                        : null,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  (_avatar != null && _avatar!.isNotEmpty)
                                      ? "Click on the image to change"
                                      : "Upload an image to set as your avatar",
                                  style: const TextStyle(
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
                                    // final data = {
                                    final name = nameController.text.trim();
                                    // };

                                    print(
                                        "selected image file ${selectedFile}");

                                    pocketBaseService.updateUser(
                                        context,
                                        userId.toString(),
                                        token.toString(),
                                        name,
                                        selectedFile);
                                    // pickAvatarAndUpdateUser(userId.toString());
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
            Stack(
              children: [
                result.isEmpty
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 40),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text("No Addresses found"),
                              const SizedBox(height: 10),
                              CustomButton(
                                title: "+ Add Address",
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AddressDrawer(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(20),
                        itemCount: result.length,
                        itemBuilder: (context, index) {
                          final address = result[index];

                          return AddressCard(
                            name: address["name"] ?? "",
                            street:
                                "${address["building"]}, ${address["street"]} - ${address["pin"]}",
                            cityState:
                                "${address["city"]} - ${address["state"]}",
                            onEdit: () {
                              print("Edit tapped for ${address["name"]}");
                            },
                            onDelete: () {
                              print("Delete tapped for ${address["name"]}");
                              String recordId = address["id"].toString();
                              ConfirmPopup.show(
                                context,
                                recordId,
                                token.toString(),
                                pocketBaseService,
                                () {
                                  setState(() {
                                    fetchAllAddress(); // Refresh the address list
                                  });
                                },
                              );
                            },
                          );
                        },
                      ),
               result.isEmpty ? SizedBox() : Positioned(
                  bottom: 20,
                  right: 20,
                  child: FloatingActionButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddressDrawer(),
                        ),
                      );
                    },
                    backgroundColor: AppColors.primarycolor,
                    child: const Icon(Icons.add, color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
