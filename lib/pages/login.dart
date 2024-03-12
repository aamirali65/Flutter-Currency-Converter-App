import 'package:currensee/pages/home.dart';
import 'package:currensee/pages/register.dart';
import 'package:currensee/widgets/customButton.dart';
import 'package:currensee/widgets/customTextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;
  bool _obscureText = true;
  final formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void login() {
    if (formkey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      _auth
          .signInWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text.toString())
          .then((value) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
        setState(() {
          loading = false;
        });
      }).onError((error, stackTrace) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
        setState(() {
          loading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'CurrenSee',
              style: TextStyle(
                  color: Color(0xff182D9E),
                  fontSize: 25,
                  fontFamily: 'Lexend',
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 50,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Login to your Account',
                style: TextStyle(fontFamily: 'Lexend', fontSize: 18),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Form(
              key: formkey,
                child: Column(
              children: [
                CustomTextField(
                    labelText: 'Email',
                    controller: emailController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter Your Email';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  labelText: 'Password',
                  suffix: IconButton(onPressed: (){
                    if(_obscureText){
                      _obscureText = false;
                    }else{
                      _obscureText = true;
                    }
                    setState(() {

                    });
                  }, icon: _obscureText ? Icon(Icons.visibility_outlined): Icon(Icons.visibility_off_outlined)),
                  controller: passwordController,
                  obscureText: _obscureText,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter Your Password';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            )),
            CustomButton(customText: 'Sign in',
                loading: loading,
                onTap: () {
              login();
                }),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 2,
                  width: 100,
                  color: Colors.grey.shade300,
                ),
                const Text('or sign in with'),
                Container(
                  height: 2,
                  width: 100,
                  color: Colors.grey.shade300,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {},
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    border: Border.all(color: Colors.grey.shade200)),
                height: 50,
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: const Center(
                    child: Image(
                  image: NetworkImage(
                      'https://cdn.iconscout.com/icon/free/png-256/free-google-1772223-1507807.png'),
                  fit: BoxFit.cover,
                )),
              ),
            ),
            const SizedBox(
              height: 80,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account ?"),
                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Register(),
                          ));
                    },
                    child: const Text(
                      ' Sign up',
                      style: TextStyle(color: Color(0xff182D9E)),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
