import 'package:chetan_bhagat/view/homepages.dart';
import 'package:chetan_bhagat/view/login.dart';
// import 'package:chetan_bhagat/homepages.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FlashScreen extends StatefulWidget {
  const FlashScreen({super.key});

  @override
  State<FlashScreen> createState() => _FlashScreenState();
}

class _FlashScreenState extends State<FlashScreen> {
  String? userName;
  void getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    userName = prefs.getString("username");

    setState(() {});
  }

  @override
  void initState() {
    getUserName();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  userName != null ? const HomePages() : LoginPage()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          Image.asset(
            "images/minnie.png",
          ),
          Image.asset("images/chetan_bhagat_031.png"),
          const Text("Indian Writer",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              )),
          const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Chetan Bhagat",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              )),
        ]));
  }
}
