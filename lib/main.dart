import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/home/home_screen.dart';
import 'package:todo/my_theme/my_theme.dart';
import 'package:todo/provider/settings_provider.dart';
import 'package:todo/splash_screen/splash_screen.dart';
import 'package:todo/tasks_list/edit_task_screen.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
      create: (buildContext) => SettingsProvider(), child: MyApplication()));
}

class MyApplication extends StatelessWidget {
  late SettingsProvider settingsProvider;

  @override
  Widget build(BuildContext context) {
    settingsProvider = Provider.of<SettingsProvider>(context);
    getValueFromShared();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: MyTheme.lightTheme,
      darkTheme: MyTheme.darkTheme,
      themeMode: settingsProvider.currentTheme,
      routes: {
        HomeScreen.routeName: (_) => HomeScreen(),
        SplashScreen.routeName: (_) => SplashScreen(),
        EditTaskScreen.routeName: (_) => EditTaskScreen(),
      },
      initialRoute: SplashScreen.routeName,
    );
  }

  getValueFromShared() async {
    final pref = await SharedPreferences.getInstance();
    settingsProvider.changeLanguage(pref.getString("lang") ?? 'en');

    if (pref.getString("theme") == "light") {
      settingsProvider.changeTheme(ThemeMode.light);
    } else if (pref.getString("theme") == "dark") {
      settingsProvider.changeTheme(ThemeMode.dark);
    }
  }
}
