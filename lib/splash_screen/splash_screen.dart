import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/provider/settings_provider.dart';

import '../home/home_screen.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = 'splash-screen';

  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsProvider>(context);
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    });
    return Container(
      child: settingsProvider.isDarkMood()
          ? Image.asset('assets/images/dark_splash.png')
          : Image.asset('assets/images/splash.png'),
    );
  }
}
