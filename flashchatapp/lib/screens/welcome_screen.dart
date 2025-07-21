import 'login_screen.dart';
import 'registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'Welcome';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> logoAnimation;
  late Animation<Color?> backgroundAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    logoAnimation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeOutBack,
    );

    backgroundAnimation = ColorTween(
      begin: Colors.deepPurple.shade800,
      end: Colors.white,
    ).animate(controller);

    controller.addListener(() {
      setState(() {});
    });

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
      backgroundColor: backgroundAnimation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  flex: 2,
                  child: Hero(
                    tag: 'logo',
                    child: Container(
                      height: logoAnimation.value * 100,
                      child: Image.asset('images/logo.png'),
                    ),
                  ),
                ),
                // spacing between logo and text
                Flexible(
                  flex: 3,
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        'Flash Chat',
                        textStyle: TextStyle(
                          fontSize: 38.0, // slightly smaller
                          fontWeight: FontWeight.w900,
                          color: Colors.deepPurple.shade700,
                        ),
                        speed: Duration(milliseconds: 100),
                      ),
                    ],
                    isRepeatingAnimation: false,
                  ),
                ),
              ],
            ),

            SizedBox(height: 48.0),
            // Login Button
            RoundButton(
              color: [Colors.purpleAccent, Colors.deepPurple],
              title: 'Log In',
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),

            RoundButton(
              color: [Colors.orangeAccent, Colors.deepOrange],
              title: 'Register',
              onPressed: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class RoundButton extends StatelessWidget {
  final List<Color> color;
  final VoidCallback onPressed;
  final String title;

  RoundButton({
    required this.color,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: color,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(30.0),
          boxShadow: [
            BoxShadow(
              color: Colors.deepPurple.withOpacity(0.4),
              offset: Offset(0, 8),
              blurRadius: 8,
            ),
          ],
        ),
        child: MaterialButton(
          onPressed: onPressed,
          height: 50,
          child: Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
