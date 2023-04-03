import 'dart:async';

import 'package:flutter/material.dart';
import 'LoginPage.dart';


class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(
          seconds: 5,
        ), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Login()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
          child:Container(
            alignment: Alignment.center,
            width: 120,
            height: 120,
            child: Image.asset("assets/images/notpad.png"),
          ),
          ),
          Text(
            "Notpad",
            style: TextStyle(fontSize: 25),
          ),
        ],
      ),
    );
  }
}
