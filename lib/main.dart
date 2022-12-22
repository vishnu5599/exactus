import 'package:exactus/authentication/login.dart';
import 'package:exactus/authentication/register.dart';
import 'package:exactus/screens/addUser.dart';
import 'package:exactus/screens/editUser.dart';
import 'package:exactus/screens/viewUsers.dart';
import 'package:flutter/material.dart';
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignIn(),
    );
  }
}
