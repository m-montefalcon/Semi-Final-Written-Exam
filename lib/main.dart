import 'package:dbassignment/pages/hexcolor.dart';
import 'package:dbassignment/pages/login_page.dart';
import 'package:flutter/material.dart';


import 'pages/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(LoginUiApp());
}


class LoginUiApp extends StatelessWidget {

  Color _primaryColor = HexColor('#DC54FE');
  Color _accentColor = HexColor('#8A02AE');
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: _primaryColor,
        accentColor: _accentColor,
        scaffoldBackgroundColor: Colors.grey.shade100,
        primarySwatch: Colors.grey,
      ),
      home: SplashScreen(title: 'Flutter Login UI'),
    );
  }
}


