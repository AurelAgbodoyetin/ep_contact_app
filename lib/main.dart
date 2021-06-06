import 'package:ep_contacts_app/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'eP Contacts App',
      theme: ThemeData(
        splashColor: Colors.white,
        primarySwatch: Colors.orange,
        primaryColor: Colors.deepOrange,
        indicatorColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.orange.withOpacity(.3),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50.0)),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50.0)),
            borderSide: BorderSide(
              color: Colors.deepOrange,
              width: 2.0,
              style: BorderStyle.solid,
            ),
          ),
        ),
      ),
      home: ContactAppHome(),
    );
  }
}
