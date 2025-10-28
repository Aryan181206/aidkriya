import 'dart:async';

import 'package:aidkriya/colors/MyColors.dart';
import 'package:aidkriya/screens/auth/SignUp.dart';
import 'package:aidkriya/screens/onboarding/Page1.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:velocity_x/velocity_x.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}




class _SplashscreenState extends State<Splashscreen> {


  @override
  void initState() {
    super.initState();
    // Start a timer to navigate after a few seconds
    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacementNamed(context, '/login');
    });
  }








  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.useYellow,
      body: Stack(
        children: <Widget>[
          Center(
            child: Image.asset("assets/logo.png").w(350).h(350),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: LoadingAnimationWidget.progressiveDots(
                color: MyColors.useBlack,
                size: 50,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
