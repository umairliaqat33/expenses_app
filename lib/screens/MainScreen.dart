import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses_app/menu_screen.dart';
import 'package:expenses_app/widgets/new_transactions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../widgets/transaction_list.dart';
import '../models/Transact.dart';
import '../widgets/new_transactions.dart';
import '../widgets/chart.dart';
final _fireStore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;
User? user=_auth.currentUser;

class StartScreen extends StatefulWidget {
  // const StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  Transactions transactions = Transactions();
  List<Transactions> sampleList = [];
  func() async{                   //getting a list of transaction type from firebase using this complex function
    await  _fireStore
        .collection('user')
        .doc(user!.uid)
        .collection('expenses')
        .snapshots()            //snapshot is actually is the right thing which is returning us all the values from firebase.
        .listen((snap) {
      snap.docs.forEach((d) {     //forEach is used to give all the data in the form of a loop and gives us all data from firebase and we can store where ever we want.
        sampleList.add(
          Transactions(
              amount: d.get('amount'),
              date: DateTime.fromMicrosecondsSinceEpoch(d.get('date').microsecondsSinceEpoch),    //this is how we can convert timeStamp into dateTime
              title: d.get('title')),
        );
      });
    });
  }

  List<Transactions> get _recentTransactions {          //this getter is giving us the most recent transactions of 7 days from today.
    return sampleList.where((tx) {
      return tx.date!.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  @override
  void initState(){
    super.initState();
    func();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AlertDialog(
            title: Text("Add new transaction"),

          );
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
      body: SingleChildScrollView(      //this will provide us a scroll screen doesn't matter how many widgets appear
        child: Column(
          children: <Widget>[
            Chart(_recentTransactions),
            TransactionList(),
          ],
        ),
      ),
    );
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();          //signOut function called
    Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => WelcomeScreen()))
        .catchError((e) {
      Fluttertoast.showToast(msg: e);
    });
  }
}
