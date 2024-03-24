import 'dart:async';
import 'package:currensee/services/splash_service.dart';
import 'package:currensee/widgets/customText.dart';
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
    return Scaffold(
      backgroundColor: const Color(0xff182D9E),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           MyText('CurrenSee', Colors.white, 50),
            const SizedBox(height: 10,),
            MyText('The Currency Conversion App', Colors.white, 14),
          ],
        ),
      ),
    );
  }
}
