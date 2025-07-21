import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import '/constants.dart';

class LoginScreen extends StatefulWidget {
  static const String id = "Login";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  String email = "";
  String password = "";
  bool loadingIcon = false;
  final _auth = FirebaseAuth.instance;
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.easeInOut);
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade50,
      body: ModalProgressHUD(
        inAsyncCall: loadingIcon,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Hero(
                    tag: 'logo',
                    child: SizedBox(
                      height: animation.value * 200,
                      child: Image.asset('images/logo.png'),
                    ),
                  ),
                  SizedBox(height: 48.0),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      email = value;
                    },
                    textAlign: TextAlign.center,
                    decoration: kInputDecoration.copyWith(
                      hintText: 'Enter your email',
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    obscureText: true,
                    onChanged: (value) {
                      password = value;
                    },
                    textAlign: TextAlign.center,
                    decoration: kInputDecoration.copyWith(
                      hintText: 'Enter your password',
                    ),
                  ),
                  SizedBox(height: 24.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Material(
                      color: Colors.deepPurpleAccent,
                      borderRadius: BorderRadius.circular(30.0),
                      elevation: 6.0,
                      child: MaterialButton(
                        onPressed: () async {
                          loadingIcon = true;
                          try {
                            final user = await _auth.signInWithEmailAndPassword(
                              email: email.trim(),
                              password: password.trim(),
                            );
                            if (user.user != null) {
                              Navigator.pushNamed(context, ChatScreen.id);
                            } else {
                              print('User not found');
                            }
                            loadingIcon = false;
                          } catch (e) {
                            print('Login Error: $e');
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Login failed. Please check your credentials.",
                                ),
                                backgroundColor: Colors.redAccent,
                              ),
                            );
                          }
                        },
                        minWidth: 200.0,
                        height: 50.0,
                        child: Text(
                          'Log In',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
