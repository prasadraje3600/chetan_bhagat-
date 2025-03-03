import 'package:chetan_bhagat/view/flashscreen.dart';
import 'package:chetan_bhagat/view/homepages.dart';
import 'package:chetan_bhagat/view/login.dart';
import 'package:chetan_bhagat/view/image_qoutes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: FlashScreen(),
    );
  }
}
