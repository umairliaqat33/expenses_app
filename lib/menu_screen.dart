import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:expenses_app/widgets/RoundButton.dart';
import 'screens/Login_Screen.dart';
import 'screens/Registration_Screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );
    animation = ColorTween(
      begin: Colors.green,
      end: Colors.white,
    ).animate(controller);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: animation.value,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Column(
                children: [
                  Row(
                    children: <Widget>[
                      Flexible(
                        fit: FlexFit.tight,
                        child: Hero(
                          tag: 'logo',
                          child: Image.asset('assets/images/logo.png'),
                        ),
                      ),
                      AnimatedTextKit(
                        isRepeatingAnimation: true,
                        animatedTexts: [
                          TypewriterAnimatedText(
                            'My Expenses',
                            speed: Duration(milliseconds: 100),
                            textStyle: TextStyle(
                                fontSize: 35, fontWeight: FontWeight.bold),
                          ),
                        ],
                        onTap: () {},
                      ),
                    ],
                  ),
                  AnimatedTextKit(animatedTexts: [
                    WavyAnimatedText(
                      'Keep account of every thing',
                      speed: Duration(milliseconds: 100),
                      textStyle: TextStyle(fontSize: 25),
                    ),
                  ])
                ],
              ),
              SizedBox(
                height: 48.0,
              ),
              RoundedButton(Colors.green, 'Registration', () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RegistrationScreen()));
              }),
              RoundedButton(Colors.green, 'Login', () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              }),
            ],
          ),
        ),
      ),
    );
  }
}
