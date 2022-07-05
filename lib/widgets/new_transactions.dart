import 'package:expenses_app/models/Transact.dart';
import 'package:expenses_app/widgets/chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/Transact.dart';

class NewTransactions extends StatefulWidget {
  // final Function addtx;
  // NewTransactions(this.addtx);

  @override
  State<NewTransactions> createState() => _NewTransactionsState();
}

class _NewTransactionsState extends State<NewTransactions> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  DateTime DatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        selectedDate = pickedDate;
      });
    });
    return selectedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Transactions>(builder: (context, Transactions, child) {
      return SingleChildScrollView(
        child: Container(
          color: Color(0xFF757575),
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                TextFormField(
                  // autofocus: true,
                  decoration: InputDecoration(
                      labelText: 'Title',
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green)),
                      labelStyle: TextStyle(color: Colors.green)),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Title is required";
                    }
                  },
                  controller: titleController,
                ),
                TextFormField(
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Amount is required";
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Amount',
                    labelStyle: TextStyle(color: Colors.green),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green)),
                  ),
                  keyboardType: TextInputType.number,
                  controller: amountController,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    "Make Sure to select your own date",
                    style: TextStyle(
                      color: Colors.green,
                    ),
                  ),
                ),
                Container(
                  // height: 70,
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          selectedDate == DateTime.now()
                              ? "No date chosen"
                              : "Picked Date: ${(DateFormat.yMd().format(selectedDate))}",
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Transactions.date = DatePicker();
                          FocusScope.of(context).unfocus();
                        },
                        child: Text(
                          "Chose Date",
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Transactions.postDetailsToFireStore(titleController.text,
                        int.parse(amountController.text), selectedDate);
                    Navigator.of(context).pop();
                    Transactions.getList();
                    Transactions.recentTransactions;
                    Chart(Transactions.recentTransactions);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                  ),
                  child: Text(
                    "Add Transaction",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
