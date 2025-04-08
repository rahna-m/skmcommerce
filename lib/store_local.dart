import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // Save username and password
  Future<void> saveCredentials(
      String username,
      // String password,
      String token,
      String? userId,
      String? email,
      String? name, 
      String? avatar
      ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // await prefs.setString('password', password);
    await prefs.setString('username', username);
    await prefs.setString('token', token);
    await prefs.setString('userId', userId!);

    await prefs.setString('email', email!);
    await prefs.setString('name', name!);
        await prefs.setString('avatar', avatar!);
    // await prefs.setBool('verified', verified!);

    print("saved username $username");
    print("saved token $token");
    print("saved userId $userId");
    print("saved email $email");
    print("saved name $name");
        print("saved avatar $avatar");
  }

  // Retrieve username and password
  Future<Map<String, String?>> getCredentials() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
    String? userId = prefs.getString('userId');
    String? token = prefs.getString('token');
    String? email = prefs.getString('email');
    String? name = prefs.getString('name');
     String? avatar = prefs.getString('avatar');

    print("get username $username");
    print("get token $token");
    print("get userId $userId");
    print("get email $email");
    print("get name $name");
     print("get avatar $avatar");

    //  String? verified = prefs.getString('verified');
    return {
      'username': username,
      'userId': userId,
      'token': token,
      'email': email,
      'name': name,
          'avatar': avatar
    };
  }

  // Clear stored credentials
  Future<void> clearCredentials() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    await prefs.remove('userId');
    await prefs.remove('token');
    await prefs.remove('email');
    await prefs.remove('name');
    await prefs.remove('avatar');
  }
}
