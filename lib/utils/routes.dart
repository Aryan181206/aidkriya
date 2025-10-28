import 'package:aidkriya/screens/auth/login.dart';
import 'package:aidkriya/screens/auth/SignUp.dart';
import 'package:aidkriya/screens/splash/SplashScreen.dart';
import 'package:aidkriya/screens/wanderer_screen/WandererMainScreen.dart';
import 'package:aidkriya/screens/wanderer_screen/bottomnav/ScheduleWalk.dart';
import 'package:aidkriya/screens/wanderer_screen/mainscreen.dart';
import 'package:flutter/material.dart';

class MyRoutes {
  static const String login = '/login';
  static const String signup = '/signup';
  static const String splash = '/splash';
  static const String wanMS = '/wanMS';
  static const String scheduleWalk = '/scheduleWalk';
  static const String mainscreen = '/mainscreen';

  static Map<String, WidgetBuilder> routes = {
    splash : (context) => const Splashscreen(),
    login: (context) => const Login(),
    signup: (context) => const Signup(),
    wanMS : (context) => WandererMainScreen(),
    scheduleWalk : (context) => ScheduleWalk(),




    mainscreen: (context) => const Mainscreen(),
  };
}
