import 'package:aidkriya/screens/Walkerscreen/WalkerScreen.dart';
import 'package:aidkriya/screens/auth/login.dart';
import 'package:aidkriya/screens/auth/SignUp.dart';
import 'package:aidkriya/screens/splash/SplashScreen.dart';
import 'package:aidkriya/screens/wanderer_screen/Payment/Payment.dart';
import 'package:aidkriya/screens/wanderer_screen/WandererMainScreen.dart';
import 'package:aidkriya/screens/wanderer_screen/bottomnav/ScheduleWalk.dart';
import 'package:aidkriya/screens/wanderer_screen/mainscreen.dart';
import 'package:flutter/material.dart';

import '../screens/Walkerscreen/bottomnav/ongoing/wmap.dart';

class MyRoutes {
  static const String login = '/login';
  static const String signup = '/signup';
  static const String splash = '/splash';
  static const String wanMS = '/wanMS';
  static const String Payment ='/payment';
  static const String scheduleWalk = '/scheduleWalk';
  static const String mainscreen = '/mainscreen';
  static const String WalkerS ='/walkers' ;
  static const String wmap ='/Wmap' ;


  static Map<String, WidgetBuilder> routes = {
    splash : (context) => const Splashscreen(),
    login: (context) => const Login(),
    signup: (context) => const Signup(),
    wanMS : (context) => WandererMainScreen(),
    scheduleWalk : (context) => ScheduleWalk(),
    WalkerS:(context)=>Walkerscreen(),
    wmap:(context)=>Walkermap(),
    Payment:(context)=>PaymentScreen(duration: 1, rate: 1, distance: 1, upiId: "7817920772@superyes"),




    mainscreen: (context) => const Mainscreen(),
  };
}
