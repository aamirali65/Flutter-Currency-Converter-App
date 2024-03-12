import 'dart:async';
import 'package:currensee/services/splash_service.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashService splashScreen = SplashService();
  @override

  void initState() {
    // TODO: implement initState
    super.initState();
    splashScreen.isLogin(context);
  }
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xff182D9E),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('CurrenSee',style: TextStyle(
              color: Colors.white,
              fontSize: 50,
                fontFamily: 'Lexend'
            ),),
            SizedBox(height: 10,),
            Text('The Currency Conversion App',style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: 'Lexend'
            ),),
          ],
        ),
      ),
    );
  }
}
