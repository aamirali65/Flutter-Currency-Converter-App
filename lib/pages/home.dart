import 'package:currensee/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff182D9E),
        title: const Text('CurrenSee',style: TextStyle(fontFamily: 'Lexend',color: Colors.white),),
      ),
      drawer: Container(
        color: Colors.white,
        child: Drawer(
          child: Column(
            children: [
              IconButton(
                  onPressed: (){
                    auth.signOut()
                        .then((value) {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context)=>const LoginScreen()));
                    })
                        .onError((error, stackTrace) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.toString())));
                    });
                  },
                  tooltip: 'logout',
                  icon: const Icon(Icons.logout_outlined,))
            ],
          ),
        ),
      ),
      body: const Text('hello'),
    );
  }
}
