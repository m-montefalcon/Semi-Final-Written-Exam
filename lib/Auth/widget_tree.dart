

import 'package:dbassignment/my_home.dart';
import 'package:dbassignment/pages/login_page.dart';
import 'package:dbassignment/pages/registration_page.dart';
import 'package:flutter/material.dart';

import 'auth.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({Key? key}) : super(key: key);

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot){
        if (snapshot.hasData){
          return  MyHome();
        } else {
          return LoginPage();
        }
      },
    );
  }
}