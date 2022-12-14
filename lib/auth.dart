import 'dart:async';
import 'package:flutter/material.dart';
import 'package:isumi/app/screens/authentication/login/login.dart';
import 'package:isumi/app/screens/main_page.dart';
import 'package:onyxsio/onyxsio.dart';

// import 'login/login.dart';

class WapperPage extends StatefulWidget {
  const WapperPage({Key? key, required this.state}) : super(key: key);
  final AppStatus state;
  @override
  State<WapperPage> createState() => _WapperPageState();
}

class _WapperPageState extends State<WapperPage> {
  @override
  void initState() {
    _timerCounter();
    super.initState();
  }

  void _timerCounter() {
    Timer(const Duration(seconds: 3), () {
      SplashScreen.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    // return const Scaffold();
    switch (widget.state) {
      case AppStatus.authenticated:
        return const MainPage();
      case AppStatus.unauthenticated:
        return const LoginPage();
    }
  }
}
