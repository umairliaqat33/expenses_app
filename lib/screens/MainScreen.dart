import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses_app/menu_screen.dart';
import 'package:expenses_app/widgets/new_transactions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../widgets/transaction_list.dart';
import '../models/Transact.dart';
import '../widgets/new_transactions.dart';
import '../widgets/chart.dart';

final _fireStore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;
User? user = _auth.currentUser;

class StartScreen extends StatefulWidget {
  // const StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  Future<Null> getRefresh() async {
    await Future.delayed(Duration(seconds: 3));
  }

  @override
  Widget build(BuildContext context) {
    // print(sampleList.length);
    return Consumer<Transactions>(builder: (context, Transactions, child) {
      return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Transactions.sampleList.clear();
            showModalBottomSheet(
                context: context, builder: (context) => NewTransactions());
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
        body: RefreshIndicator(
          onRefresh: getRefresh,
          child: ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return SingleChildScrollView(
                  //this will provide us a scroll screen doesn't matter how many widgets appear
                  child: Column(
                    children: <Widget>[
                      Chart(Transactions.recentTransactions),
                      TransactionList(),
                    ],
                  ),
                );
              }),
        ),
      );
    });
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut(); //signOut function called
    Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => WelcomeScreen()))
        .catchError((e) {
      Fluttertoast.showToast(msg: e);
    });
  }
}
