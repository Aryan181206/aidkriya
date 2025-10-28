import 'package:aidkriya/screens/splash/SplashScreen.dart';
import 'package:aidkriya/utils/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'aidKRIYA',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: Splashscreen(),
      initialRoute: MyRoutes.splash,
      routes: MyRoutes.routes,

    );
  }
}
