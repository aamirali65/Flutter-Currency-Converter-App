import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:currensee/pages/home.dart';
import 'package:currensee/pages/register.dart';
import 'package:currensee/services/connection.dart';
import 'package:currensee/widgets/customButton.dart';
import 'package:currensee/widgets/customTextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  Future<void> saveUserEmail(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_email', email);
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
        String? userEmail = value.user?.email;
        if (userEmail != null) {
          saveUserEmail(userEmail);
        }
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
        emailController.clear();
        passwordController.clear();
      });
    }
  }

  SignWithGoogle() async {
    try {
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential != null) {
        String? userEmail = userCredential.user?.email;
        String? userName = userCredential.user?.displayName;

        if (userEmail != null && userName != null) {
          saveUserEmail(userEmail);
          await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
            'email': userEmail,
            'username': userName,
          });

          // Navigate to HomeScreen after successful sign-in
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
        } else {
          print('Error: User email or name is null');
        }
      } else {
        print('Error: UserCredential is null');
      }
    } catch (e) {
      print('Error signing in with Google: $e');
      // Handle error and provide feedback to the user
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error signing in with Google')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          InternetConnection(),
          SafeArea(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'CurrenSee',
                      style: TextStyle(
                        color: Color(0xff182D9E),
                        fontSize: 25,
                        fontFamily: 'Lexend',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Login to your Account',
                        style: TextStyle(fontFamily: 'Lexend', fontSize: 18),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
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
                            suffix: IconButton(
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              icon: _obscureText
                                  ? Icon(Icons.visibility_outlined)
                                  : Icon(Icons.visibility_off_outlined),
                            ),
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
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                    CustomButton(
                      customText: 'Sign in',
                      loading: loading,
                      onTap: login,
                    ),
                    const SizedBox(
                      height: 10,
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
                      onTap: SignWithGoogle,
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white10,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        height: 50,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: const Center(
                          child: Image(
                            image: NetworkImage(
                                'https://cdn.iconscout.com/icon/free/png-256/free-google-1772223-1507807.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
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
                              ),
                            );
                          },
                          child: const Text(
                            ' Sign up',
                            style: TextStyle(color: Color(0xff182D9E)),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

}
