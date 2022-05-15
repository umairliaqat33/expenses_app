import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses_app/models/Transact.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

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
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
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

  // void submitData() {
  //   final enteredTitle = titleController.text;
  //   final enteredAmount = amountController.text;
  //   // if (enteredTitle.isEmpty || enteredAmount.isEmpty || selectedDate == null) {
  //   //   return;
  //   // }
  //   // widget.addtx(enteredTitle, enteredAmount, selectedDate);
  //   Navigator.of(context).pop();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF757575),
      child: AlertDialog(
        actions: [Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
          ),
          // height: 500,
          child: Card(
            elevation: 5,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              padding: EdgeInsets.all(10),
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
                    controller: titleController,
                    validator: (value){
                      if(value!.isEmpty){
                        return "Title is required";
                      }
                    },
                    // onSubmitted: (_) =>
                        // submitData(), //here the underscore means that we don't really need this argument we are just using it because of syntax
                  ),
                  TextFormField(
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    validator: (value){
                      if(value!.isEmpty){
                        return "Title is required";
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
                    // onChanged: (_) =>
                        // submitData(), //here the underscore means that we don't really need this argument we are just using it because of syntax
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text("Make Sure to select your own date",style: TextStyle(
                      color: Colors.green,
                    ),),
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
                            DatePicker();
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
                      postDetailsToFireStore();
                      Navigator.of(context).pop();
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
        ),
        ]
      ),
    );
  }

  postDetailsToFireStore() async {
    //calling our fireStore
    //calling user model
    //sending values
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    Transactions transactions = Transactions();
    transactions.title = titleController.text;
    transactions.amount =int.parse(amountController.text) ;
    transactions.date = selectedDate;

    await firebaseFirestore
        .collection('user')
        .doc(user?.uid)
        .collection('expenses')
        .doc()
        .set(transactions.toMap());

    Fluttertoast.showToast(msg: "Transaction Added Successfully");
  }
}