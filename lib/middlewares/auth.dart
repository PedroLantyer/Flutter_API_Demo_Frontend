import 'dart:convert';

import 'package:api_demonstration/middlewares/server_config.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AuthController extends GetxController {
  var isLoggedIn = false.obs;
  var isLoading = false.obs;
  int? id;
  String? user;

  Future<void> login(String username, String password) async {
    isLoading(true);

    String authority = ServerConfig().getAuthority();
    Uri url = Uri.http(authority, "/login");
    http.Response res = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(<String, dynamic>{
        "user": username,
        "password": password,
      }),
    );
    Map body = jsonDecode(res.body);
    if (body != null && body["id"] != null && body["user"] != null) {
      user = body["user"];
      id = int.parse(body["id"]);
      isLoggedIn(true);
      Get.offAllNamed('/home');
    } else {
      Get.snackbar('Error', 'Invalid credentials');
    }

    isLoading(false);
  }

  void logout() {
    isLoggedIn(false);
    Get.offAllNamed('/login'); // Redirect to the login page
  }
}
