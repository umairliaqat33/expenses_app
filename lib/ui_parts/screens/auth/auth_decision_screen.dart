import 'package:expenses_app/ui_parts/screens/auth/login_screen.dart';
import 'package:expenses_app/ui_parts/screens/auth/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:expenses_app/ui_parts/widgets/round_button.dart';

// AuthDecisionScreen
// SingleTickerProviderStateMixin

class AuthDecisionScreen extends StatefulWidget {
  const AuthDecisionScreen({super.key});

  @override
  State<AuthDecisionScreen> createState() => _AuthDecisionScreenState();
}

class _AuthDecisionScreenState extends State<AuthDecisionScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 3),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
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
                          speed: const Duration(milliseconds: 100),
                          textStyle: const TextStyle(
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
                    speed: const Duration(milliseconds: 100),
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                ])
              ],
            ),
            const SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              onPressed: () {
                controller.dispose();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RegistrationScreen(),
                  ),
                );
              },
              color: Theme.of(context).primaryColor,
              title: 'Registration',
            ),
            RoundedButton(
              color: Colors.green,
              title: 'Login',
              onPressed: () {
                controller.dispose();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
