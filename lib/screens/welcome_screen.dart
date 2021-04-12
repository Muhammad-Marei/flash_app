import 'package:flutter/material.dart';
import 'registration_screen.dart';
import 'login_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_app/component/bottom_style.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  static String id = "WelcomeScreen";
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
      vsync: this, duration: Duration(seconds: 1),
      // lowerBound: 50,
      // upperBound: 100,
      // lowerBound: 50,
    );
    animation = ColorTween(begin: Colors.blueGrey, end: Colors.blue)
        .animate(controller /*0:1*/);
    controller.forward();

    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
  int loading ;
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: "logo",
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          child: Image.asset('images/logo.png'),
                          height: (controller.value) * 100,
                        ),

                        Text(
                          "${(100 * controller.value).toInt()}%",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                          ),
                        )
                      ],
                    ),
                    height: 120.0,
                  ),
                ),
                ColorizeAnimatedTextKit(
                  text: ["flash chat"],
                  textStyle: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                  colors: [
                    Colors.white54,
                    Colors.purple,
                    Colors.blue,
                    Colors.yellow,
                    Colors.red,
                  ],
                  textAlign: TextAlign.start,
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            BottomStyle(
              text: 'Register',
              color: Colors.blueAccent,
              onpressed: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
//Go to registration screen.
              },
            ),
            BottomStyle(
              text: 'Log In',
              color: Colors.lightBlueAccent,
              onpressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
