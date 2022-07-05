import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses_app/models/Transact.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'chart.dart';

final _fireStore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;
User? user = _auth.currentUser;

class TransactionList extends StatefulWidget {
  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  @override
  void initState() {
    setState(() {
      Transactions transact = Transactions();
      transact.getList();
      transact.recentTransactions;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Transactions>(builder: (context, Transactions, child) {
      return StreamBuilder<QuerySnapshot>(
        stream: _fireStore
            .collection('user')
            .doc(user!.uid)
            .collection('expenses')
            .orderBy('date', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          final media=MediaQuery.of(context);
          return snapshot.connectionState == ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                ))
              : snapshot.data!.docs.isEmpty
                  ? Column(
                      children: [
                        Text(
                          "No transaction yet!",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 200,
                          child: Image.asset(
                            "assets/images/waiting.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    )
                  : ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot data = snapshot.data!.docs[index];
                        String title = data.get("title");
                        int amount = data.get("amount");
                        Timestamp timestamp = data.get('date');
                        DateTime? date = DateTime.fromMicrosecondsSinceEpoch(
                            timestamp.microsecondsSinceEpoch);
                        return Card(
                          elevation: 4,
                          child: Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                  ),
                                  padding: EdgeInsets.all(5),
                                  child: CircleAvatar(
                                    radius: 30,
                                    child: Padding(
                                      padding: EdgeInsets.all(8),
                                      child: FittedBox(
                                        child: Text(
                                          'Rs ${amount.toStringAsFixed(0)}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  //it will help our text not to occupy space which is remaining after all other widgets.
                                  fit: FlexFit.tight,
                                  child: SingleChildScrollView(
                                    //this is used to make our text scrollable if text exceeds from limit
                                    scrollDirection: Axis.horizontal,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          title,
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          DateFormat.yMMMd().format(date),
                                          style: TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                    child: Align(
                                  alignment: Alignment.centerRight,
                                  child: media.size.width > 450
                                      ? TextButton.icon(
                                          onPressed: () {
                                            Transactions.getList();
                                            Transactions.recentTransactions;
                                            Chart(Transactions
                                                .recentTransactions);
                                            Transactions.delete(data);
                                          },
                                          icon: Icon(Icons.delete),
                                          label: Text("Delete"),
                                        )
                                      : IconButton(
                                          onPressed: () {
                                            Transactions.getList();
                                            Transactions.recentTransactions;
                                            Chart(Transactions
                                                .recentTransactions);
                                            Transactions.delete(data);
                                          },
                                          icon: Icon(Icons.delete),
                                        ),
                                )),
                              ],
                            ),
                          ),
                        );
                      });
        },
      );
    });
  }
}
