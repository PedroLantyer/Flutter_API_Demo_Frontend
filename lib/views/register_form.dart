import 'dart:convert';

import 'package:api_demonstration/middlewares/auth.dart';
import 'package:api_demonstration/middlewares/server_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<StatefulWidget> createState() => _Register();
}

class _Register extends State<Register> {
  String _user = "",
      _password = "",
      _email = "",
      _passwordDupe = "",
      _errorMsg = "test";
  bool _hidePassword = true, _errorVisible = false;

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
    AuthController authController = Get.find<AuthController>();

    Future.microtask(
      () => {
        if (authController.isLoggedIn.isTrue) {Get.toNamed("/home")},
      },
    );

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

      if (res.statusCode == 201) {
        Get.toNamed("/login");
      }
    }

    bool inputValidation() {
      if (_password != _passwordDupe) {
        setState(() {
          _errorMsg = "Passwords don't match";
          _errorVisible = true;
        });
        return false;
      }
      if (_user.length < 6 || _user.length > 64) {
        setState(() {
          _errorMsg = "User length must be bigger than 5 and smaller than 65";
          _errorVisible = true;
        });
        return false;
      }
      if (_email.length >= 4 || _email.length <= 64) {
        bool hasWhiteSpace = _email.contains(' ');
        int indexOfAt = _email.indexOf('@');
        if (hasWhiteSpace || indexOfAt <= 1) {
          setState(() {
            _errorMsg = "Invalid e-mail";
            _errorVisible = true;
          });
          return false;
        }
      } else {
        setState(() {
          _errorMsg = "Invalid e-mail";
          _errorVisible = true;
        });
      }

      if (_password.length >= 8 && _password.length <= 32) {
        RegExp pattern = RegExp(
          r"(?=.*?[0-9])(?=.*?[a-zA-Z])",
        ); // Verifies if PWD has both Chars and Numbers
        if (pattern.hasMatch(_password)) {
          setState(() {
            _errorMsg = "Password must have Chars and Numbers";
            _errorVisible = true;
          });
          return false;
        }
      } else {
        setState(() {
          _errorMsg =
              "Password must have a length bigger than 7 and smaller than 33";
          _errorVisible = true;
        });
        return false;
      }

      setState(() {
        _errorMsg = "";
        _errorVisible = false;
      });
      return true;
    }

    double screenWidth = MediaQuery.sizeOf(context).width;
    double screenHeight = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 800),
              child: Form(
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
                        onChanged:
                            (String newUser) => handleUserChange(newUser),
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
                        onChanged:
                            (String newEmail) => handleEmailChange(newEmail),
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
                        onChanged:
                            (String newPwd) => handlePasswordChange(newPwd),

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
                      onPressed:
                          () => {
                            if (inputValidation()) {handleRegister()},
                          },
                      child: Text(
                        "Register",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    Visibility(
                      visible: _errorVisible,
                      child: Text(
                        _errorMsg,
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: screenHeight * 0.03,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
