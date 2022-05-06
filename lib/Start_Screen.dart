import 'package:expenses_app/widgets/new_transactions.dart';
import 'package:flutter/material.dart';
import './widgets/transaction_list.dart';
import 'models/Transact.dart';
import 'widgets/chart.dart';

class StartScreen extends StatefulWidget {
  // const StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  final List<Transaction> _userTransaction = [
    // Transaction("99", DateTime.now(), "E1", "First Expense"),
  ];

  List<Transaction> get _recentTransactions {
    return _userTransaction.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransactions(String txtitle, String txamount,DateTime chosenDate) {
    final newTx = Transaction(
        txamount, chosenDate, DateTime.now().toString(), txtitle);
    setState(() {
      _userTransaction.add(newTx);
    });
  }
  void deleteTransaction(String id){
    setState(() {
      _userTransaction.remove((tx) => tx.id==id);
    });
  }

  void _StartNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (BuildContext context) =>
            NewTransactions(_addNewTransactions));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _StartNewTransaction(context),
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
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) =>
                      NewTransactions(_addNewTransactions));
            },
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(_recentTransactions),
            TransactionList(_userTransaction,deleteTransaction),
          ],
        ),
      ),
    );
  }
}
