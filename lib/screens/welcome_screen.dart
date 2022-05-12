import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:expenses_app/MainScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:expenses_app/models/user_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'menu_screen.dart';

class WelcomeUserScreen extends StatefulWidget {
  @override
  State<WelcomeUserScreen> createState() => _WelcomeUserScreenState();
}

class _WelcomeUserScreenState extends State<WelcomeUserScreen> {
  final user = FirebaseAuth.instance.currentUser;
  String lname = '';
  String fname = '';
  @override
  void initState() {
    super.initState();
    getValues();
  }
  void getValues(){

    FirebaseFirestore.instance
        .collection("user")
        .doc(user!.uid)
        .get()
        .then((value) {
      setState(() {
        lname = value.get('lastname');
        // print(lname);
        fname = value.get('firstname');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.green,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
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
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(30.0),
                elevation: 5.0,
                child: MaterialButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => StartScreen()));
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    "Start Adding Expenses",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.push(
            context, MaterialPageRoute(builder: (context) => WelcomeScreen()))
        .catchError((e) {
      Fluttertoast.showToast(msg: e);
    });
  }
}
