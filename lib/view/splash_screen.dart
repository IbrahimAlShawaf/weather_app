import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'my_home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startSplashScreenTimer(); // calling startSplashScreenTimer method,to start the timer
  }

  startSplashScreenTimer() async {
    // Because we using Timer and it is a Future Object, we used async keyword
    var duration = const Duration(seconds: 5);
    return Timer(duration, navigationToNextPage);
    /*
     1-Create a variable type Duration, and set Duration to 5 seconds,
     2-Create a  Timer here, which takes two arguments, first duration,
     and callback which is in our case is navigationToNextPage which will be called after the duration {5 seconds here },
     Note: we have to import 'dart:async' so we can use Timer class
     */
  }

  void navigationToNextPage() async {
    Navigator.pushAndRemoveUntil(
      context, MaterialPageRoute(builder: (context) => const MyHomePage()),
      (Route<dynamic> route) => false, //
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: Colors.indigo[300],
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 100,
                ),
                Image.asset(
                  'assets/images/cloudy.png',
                  height: 250,
                  width: 250,
                ),
                // const CircleAvatar(
                //   radius: 70,
                //   backgroundImage: AssetImage('assets/images/cloudy.png'),
                //   backgroundColor: Colors.transparent,
                // ),
                const SizedBox(
                  height: 50,
                ),
                LoadingAnimationWidget.fourRotatingDots(
                    color: Colors.indigo, size: 100),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
