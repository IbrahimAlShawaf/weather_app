import 'package:flutter/material.dart';


import 'view/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  //get weatherApi => null;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: ThemeData(
       useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home:  const SplashScreen(),
    );
  }
}

