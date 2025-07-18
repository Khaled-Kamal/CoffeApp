import 'package:coffe_app/home.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) => Home()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffeb60d),
      body: Center(child: Image.asset('assets/logo/logo.png', width: 350)),
    );
  }
}
