import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class InternetConnection extends StatefulWidget {
  const InternetConnection({super.key});

  @override
  State<InternetConnection> createState() => _InternetConnectionState();
}

class _InternetConnectionState extends State<InternetConnection> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startStreaimg();
    checkInternet();
  }

  late ConnectivityResult result;
  late StreamSubscription subscription;
  var icConnected = false;
  checkInternet()async{
    result = await Connectivity().checkConnectivity();
    if(result!=ConnectivityResult.none){
      icConnected = true;
    }else{
      icConnected = false;
      showDialogBox();
    }
    setState(() {

    });
  }
  showDialogBox(){
    showDialog(
      barrierDismissible: false,
      context: context, builder: (context) => CupertinoAlertDialog(
      title: const Text('No Internet'),
      content: const Text('please check your internet connection!'),
      actions: [
        CupertinoButton(child: const Text('Retry',style: TextStyle(color: Color(0xff2945FF)),), onPressed: (){
          Navigator.pop(context);
          setState(() {

          });
          checkInternet();
        })
      ],
    ),);
  }
  startStreaimg(){
    subscription = Connectivity().onConnectivityChanged.listen((event)async{
      checkInternet();
    });
  }



  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}