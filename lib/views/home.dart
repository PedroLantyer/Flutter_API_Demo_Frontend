import 'package:api_demonstration/middlewares/auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<StatefulWidget> createState() => _Home();
}

class _Home extends State<Home> {
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    Future.microtask(
      () => {
        if (authController.isLoggedIn.isFalse) {Get.toNamed("/login")},
      },
    );

    double screenWidth = MediaQuery.sizeOf(context).width;
    double screenHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () => authController.logout(),
            icon: Icon(Icons.logout, color: Colors.white),
          ),
          Center(
            child: Text(
              "Hello World",
              style: TextStyle(
                color: Colors.white,
                fontSize: screenWidth * 0.1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
