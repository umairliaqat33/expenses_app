import 'package:expenses_app/menu_screen.dart';
import 'package:expenses_app/widgets/new_transactions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../widgets/transaction_list.dart';
import '../models/Transact.dart';
import '../widgets/chart.dart';

final _auth = FirebaseAuth.instance;
User? user = _auth.currentUser;

class StartScreen extends StatefulWidget {
  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  Future<Null> getRefresh() async {
    await Future.delayed(Duration(seconds: 3));
  }

  Transactions transact = Transactions();

  @override
  void initState() {
    transact.getList();
    transact.recentTransactions;
    Chart(transact.recentTransactions);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final media=MediaQuery.of(context);
    bool isPortrait = media.orientation==Orientation.portrait;
    final appBar = AppBar(
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
        ),
      ],
    );

    return Consumer<Transactions>(builder: (context, Transactions, child) {
      return Scaffold(
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Transactions.sampleList.clear();
            showModalBottomSheet(
                context: context, builder: (context) => NewTransactions());
          },
          child: Icon(Icons.add),
        ),
        appBar: appBar,
        body: RefreshIndicator(
          onRefresh: getRefresh,
          child: ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return SingleChildScrollView(
                  //this will provide us a scroll screen doesn't matter how many widgets appear
                  child: Column(
                    children: <Widget>[
                      Container(
                          height: (media.size.height ) *
                              ( isPortrait ? 0.28 : 0.6),
                          child: Chart(Transactions.recentTransactions)),
                      Container(
                          height: (media.size.height -
                                  appBar.preferredSize.height -
                                  media.padding.top) *
                              ( isPortrait ? 0.6 : 0.7),
                          child: TransactionList()),
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
