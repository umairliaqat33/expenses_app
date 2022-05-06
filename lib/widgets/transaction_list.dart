import 'package:expenses_app/models/Transact.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  // @override

  @override
  final List<Transaction> transactions;
  final Function delettx;
  TransactionList(this.transactions, this.delettx);

  Widget build(BuildContext context) {
    return transactions.isEmpty
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
        : Column(
            children: transactions.map((tx) {
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
                        decoration: BoxDecoration(
                            // border: Border.all(
                            //   color: Theme.of(context).primaryColorLight,
                            //   width: 2,
                            // ),
                            // borderRadius: BorderRadius.circular(5),
                            ),
                        child: CircleAvatar(
                          radius: 30,
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: FittedBox(
                              child: Text(
                                'Rs ${double.parse(tx.amount.toString()).toStringAsFixed(0)}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  // color: Theme.of(context).primaryColorDark,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tx.title,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            DateFormat.yMMMd().format(tx.date),
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                          child: Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          onPressed: () {
                            delettx(tx.id);
                          },
                          icon: Icon(Icons.delete),
                        ),
                      )),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
  }
}
