import 'dart:convert';

import 'package:api_demonstration/middlewares/server_config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'home.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<StatefulWidget> createState() => _Login();
}

class _Login extends State<Register> {
  String _user = "", _password = "", _email = "", _passwordDupe = "";
  bool _hidePassword = true, _isLogged = false;

  void handleUserChange(String newUser) {
    setState(() => _user = newUser);
  }

  void handlePasswordChange(String newPassword) {
    setState(() => _password = newPassword);
  }

  void handlePasswordVisibilityChange() {
    setState(() => _hidePassword = !_hidePassword);
  }

  void handleEmailChange(String newEmail) {
    setState(() => _email = newEmail);
  }

  void handlePasswordDupeChange(String newPwd) {
    setState(() => _passwordDupe = newPwd);
  }

  @override
  Widget build(BuildContext context) {
    Future<void> handleRegister() async {
      String authority = ServerConfig().getAuthority();
      Uri url = Uri.http(authority, "register");
      http.Response res = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(<String, dynamic>{
          "user": _user,
          "password": _password,
          "email": _email,
        }),
      );
      String body = res.body;
      print('Status Code: ${res.statusCode}');
      print(body);
    }

    void handleRedirect() {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    }

    double screenWidth = MediaQuery.sizeOf(context).width;
    double screenHeight = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.08,
                    vertical: screenHeight * 0.01,
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      counterText: "",
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "user",
                    ),
                    onChanged: (String newUser) => handleUserChange(newUser),
                    initialValue: _user,
                    maxLength: 64,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.08,
                    vertical: screenHeight * 0.01,
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      counterText: "",
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "email",
                    ),
                    onChanged: (String newEmail) => handleEmailChange(newEmail),
                    initialValue: _email,
                    maxLength: 64,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.08,
                    vertical: screenHeight * 0.01,
                  ),
                  child: TextFormField(
                    obscureText: _hidePassword,
                    decoration: InputDecoration(
                      counterText: "",
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "password",
                      suffixIcon: IconButton(
                        onPressed: () => handlePasswordVisibilityChange(),
                        icon: Icon(
                          _hidePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    onChanged: (String newPwd) => handlePasswordChange(newPwd),

                    initialValue: _password,
                    maxLength: 32,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.08,
                    vertical: screenHeight * 0.01,
                  ),
                  child: TextFormField(
                    obscureText: _hidePassword,
                    decoration: InputDecoration(
                      counterText: "",
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "password",
                      suffixIcon: IconButton(
                        onPressed: () => handlePasswordVisibilityChange(),
                        icon: Icon(
                          _hidePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    onChanged:
                        (String newPwd) => handlePasswordDupeChange(newPwd),

                    initialValue: _passwordDupe,
                    maxLength: 32,
                  ),
                ),
                TextButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.white),
                  ),
                  onPressed: () => handleRegister(),
                  child: Text(
                    "Register",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
