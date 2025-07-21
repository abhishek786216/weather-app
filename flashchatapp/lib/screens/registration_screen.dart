import 'package:firebase_core/firebase_core.dart';
import '/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = "Registration";
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen>
    with SingleTickerProviderStateMixin {
  String email = '';
  String password = '';
  bool loadingIcon = false;
  final _auth = FirebaseAuth.instance;
  late AnimationController controller;
  late Animation<double> animation;

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

  InputDecoration _buildInputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white.withOpacity(0.9),
      contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: BorderSide(color: Colors.deepPurpleAccent, width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: BorderSide(color: Colors.deepPurpleAccent, width: 2.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: loadingIcon,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 600),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo, Colors.deepPurpleAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Center(
            child: SingleChildScrollView(
              child: FadeTransition(
                opacity: animation,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Hero(
                      tag: 'logo',
                      child: Container(
                        height: 120.0,
                        child: Image.asset('images/logo.png'),
                      ),
                    ),
                    SizedBox(height: 40.0),
                    TextField(
                      onChanged: (value) => email = value,
                      keyboardType: TextInputType.emailAddress,
                      decoration: _buildInputDecoration('Enter your email'),
                    ),
                    SizedBox(height: 12.0),
                    TextField(
                      onChanged: (value) => password = value,
                      obscureText: true,
                      decoration: _buildInputDecoration('Enter your password'),
                    ),
                    SizedBox(height: 24.0),
                    Material(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.0),
                      elevation: 6.0,
                      child: MaterialButton(
                        onPressed: () async {
                          setState(() {
                            loadingIcon = true;
                          });
                          try {
                            final newUser = await _auth
                                .createUserWithEmailAndPassword(
                                  email: email,
                                  password: password,
                                );

                            if (newUser != null) {
                              Navigator.pushNamed(context, ChatScreen.id);
                            }
                            setState(() {
                              loadingIcon = false;
                            });
                          } catch (e) {
                            print(e);
                          }
                        },
                        minWidth: 200.0,
                        height: 45.0,
                        child: Text(
                          'Register',
                          style: TextStyle(
                            color: Colors.deepPurpleAccent,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
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
      ),
    );
  }
}
