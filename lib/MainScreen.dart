import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses_app/screens/menu_screen.dart';
import 'package:expenses_app/widgets/new_transactions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import './widgets/transaction_list.dart';
import 'widgets/new_transactions.dart';
import 'widgets/chart.dart';
final _fireStore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;
User? user=_auth.currentUser;

class StartScreen extends StatefulWidget {
  // const StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => NewTransactions()));
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "Personal Expenses",
          style: TextStyle(
              fontFamily:
                  'Open Sans' //this is how we can use fonts families in any individual widget.
              ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              logout();
            },
            icon: Icon(Icons.logout),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Chart(),
            TransactionList(),
          ],
        ),
      ),
    );
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => WelcomeScreen()))
        .catchError((e) {
      Fluttertoast.showToast(msg: e);
    });
  }
}
