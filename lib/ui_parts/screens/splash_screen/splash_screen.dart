import 'dart:async';
import 'package:expenses_app/ui_parts/screens/auth/auth_decision_screen.dart';
import 'package:expenses_app/ui_parts/screens/transaction_screens/transaction_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void _createSplash() {
    Future.delayed(
      const Duration(
        seconds: 2,
      ),
      () {
        User? user = FirebaseAuth.instance.currentUser;
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => user == null
                ? const AuthDecisionScreen()
                : const TransactionList(),
          ),
          (route) => false,
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _createSplash();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Hero(
              tag: 'logo',
              child: Image.asset('assets/images/logo.png'),
            ),
          ],
        ),
      ),
    );
  }
}
