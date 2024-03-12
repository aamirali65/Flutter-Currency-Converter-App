import 'package:currensee/pages/login.dart';
import 'package:currensee/widgets/customButton.dart';
import 'package:currensee/widgets/customTextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  bool loading = false;
  final formkey = GlobalKey<FormState>();
  bool _obscureText = true;
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void signup() {
    if (formkey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      _auth
          .createUserWithEmailAndPassword(
              email: emailController.text.toString(),
              password: passwordController.text.toString())
          .then((value) {
        setState(() {
          loading = false;
        });
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('User Created Successfully!')));
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ));
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
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
                'Register to your Account',
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
                    }),
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
            CustomButton(
                customText: ' Sign up',
                loading: loading,
                onTap: () {
              signup();
            }),
            const SizedBox(
              height: 80,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("already have an account ? "),
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Sign in',
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
