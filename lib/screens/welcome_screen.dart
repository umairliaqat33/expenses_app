import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses_app/models/Transact.dart';
import 'package:flutter/material.dart';
import 'package:expenses_app/screens/MainScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:expenses_app/widgets/chart.dart';


class WelcomeUserScreen extends StatefulWidget {
  @override
  State<WelcomeUserScreen> createState() => _WelcomeUserScreenState();
}

class _WelcomeUserScreenState extends State<WelcomeUserScreen> {
  final user = FirebaseAuth.instance.currentUser;
  String lname = '';
  String fname = '';

  Time() {
    Timer(Duration(seconds: 5), () {
      //this timer function is used to switch to StartScreen class automatically after 10 seconds and it requires import 'dart:async';.
      Navigator.pushReplacement(
          context, //push replacement is used to replace the previous widget with the new one.
          MaterialPageRoute(builder: (context) => StartScreen()));
    });
  }

  Transactions transact=Transactions();
  @override
  void initState() {
    super.initState();
    transact.getList();
    transact.recentTransactions;
    Chart(transact.recentTransactions);

    getValues();
    Time();
  }

  void getValues() {
    FirebaseFirestore
        .instance //this is how we get data from firebase about a particular field as we can see in lname and fname
        .collection("user")
        .doc(user!.uid)
        .get()
        .then((value) {
      setState(() {
        lname = value.get('lastname');
        fname = value.get('firstname');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Transactions>(
      builder: (context, Transactions,child) {
      return Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.transparent,
        //   elevation: 0,
        //   leading: IconButton(
        //     icon: Icon(
        //       Icons.arrow_back,
        //       color: Colors.green,
        //     ),
        //     onPressed: () {
        //       Navigator.of(context).pop();
        //     },
        //   ),
        // ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: Image.asset('assets/images/logo.png'),
              ),
              Text(
                "Welcome",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  fontFamily: 'Quicksand',
                ),
              ),
              Text(
                "${fname} ${lname}",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  fontFamily: 'Quicksand',
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.symmetric(vertical: 16.0),
              //   child: Material(
              //     color: Theme.of(context).primaryColor,
              //     borderRadius: BorderRadius.circular(30.0),
              //     elevation: 5.0,
              //     child: MaterialButton(
              //       onPressed: () {
              //         Navigator.push(context,
              //             MaterialPageRoute(builder: (context) => StartScreen()));
              //       },
              //       minWidth: 200.0,
              //       height: 42.0,
              //       child: Text(
              //         "Start Adding Expenses",
              //         style: TextStyle(color: Colors.white),
              //       ),
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      );
      }
    );
  }
}
