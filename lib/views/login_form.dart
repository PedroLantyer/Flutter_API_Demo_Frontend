import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'home.dart';
import 'register_form.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<StatefulWidget> createState() => _Login();
}

class _Login extends State<Login> {
  String _user = "", _password = "";
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

  @override
  Widget build(BuildContext context) {
    Future<void> handleLogin() async {
      int port = 8080;
      String address = "192.168.100.10",
          endpoint = "/login",
          authority = "$address:$port";

      Uri url = Uri.http(authority, endpoint);
      http.Response res = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(<String, dynamic>{
          "user": _user,
          "password": _password,
        }),
      );
      Map body = jsonDecode(res.body);
      if (body["isLogged"] != false) {
        setState(() {
          _isLogged = true;
        });
      }
    }

    void handleRedirect() {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    }

    if (_isLogged) {
      handleRedirect();
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
                TextButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.white),
                  ),
                  onPressed:
                      () => handleLogin().then(
                        (res) => {
                          if (_isLogged) {handleRedirect()},
                        },
                      ),
                  child: Text(
                    "LOGIN",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: screenWidth * 0.01,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Text(
                        "Still don't have an account?",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.01,
                      ),
                      child: GestureDetector(
                        child: Text(
                          "SIGNUP",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Color(0xFF79FF00),
                          ),
                        ),
                        onTap:
                            () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Register(),
                                ),
                              ),
                            },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
