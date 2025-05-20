import 'package:api_demonstration/middlewares/auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'views/home.dart';
import 'views/login_form.dart';

void main() async {
  //await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'API Demo',
      initialRoute: '/login',
      getPages: [
        GetPage(name: '/login', page: () => Login()),
        GetPage(name: '/home', page: () => Home()),
      ],
      initialBinding: BindingsBuilder(() {
        Get.put(AuthController());
      }),
    );
  }
}
