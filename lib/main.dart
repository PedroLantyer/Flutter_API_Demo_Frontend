import 'package:flutter/material.dart';

import 'views/home.dart';
import 'views/login_form.dart';

void main() async {
  //await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  bool _isLogged = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API Demo',
      home: _isLogged ? const Home() : const Login(),
    );
  }
}
