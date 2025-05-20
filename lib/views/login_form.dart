import 'package:api_demonstration/middlewares/auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'register_form.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<StatefulWidget> createState() => _Login();
}

class _Login extends State<Login> {
  final AuthController authController = Get.find<AuthController>();
  String _user = "", _password = "";
  bool _hidePassword = true;

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
    Future.microtask(
      () => {
        if (authController.isLoggedIn.value) {Get.toNamed("/home")},
      },
    );

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
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.white),
                      ),
                      onPressed: () => authController.login(_user, _password),
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
            ),
          ),
        ],
      ),
    );
  }
}
