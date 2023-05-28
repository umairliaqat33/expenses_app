import 'dart:developer';

import 'package:expenses_app/models/transaction_model/transaction_model.dart';
import 'package:expenses_app/providers/firestore_provider.dart';
import 'package:expenses_app/ui_parts/widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NewTransactions extends StatefulWidget {
  const NewTransactions({super.key});

  // final Function addTx;
  // NewTransactions(this.addTx);

  @override
  State<NewTransactions> createState() => _NewTransactionsState();
}

class _NewTransactionsState extends State<NewTransactions> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  final FirestoreProvider _firestoreProvider = FirestoreProvider();

  void _datePicker() {
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
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: const Color(0xFF757575),
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              right: 10,
              left: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Title',
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green)),
                    labelStyle: TextStyle(color: Colors.green)),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Title is required";
                  }
                  return null;
                },
                controller: _titleController,
              ),
              TextFormField(
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Amount is required";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Amount',
                  labelStyle: TextStyle(color: Colors.green),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green)),
                ),
                keyboardType: TextInputType.number,
                controller: _amountController,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  "Make Sure to select your own date",
                  style: TextStyle(
                    color: Colors.green,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _selectedDate == DateTime.now()
                            ? "No date chosen"
                            : "Picked Date: ${(DateFormat.yMd().format(_selectedDate))}",
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        _datePicker();
                      },
                      child: const Text(
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
                onPressed: () async => _addTransaction(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: const Text(
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
  }

  void _addTransaction() async {
    try {
      _firestoreProvider.addTransaction(
        TransactionModel(
          amount: int.parse(_amountController.text),
          date: _selectedDate,
          title: _titleController.text,
        ),
      );
      CustomToast.showCustomToast(
        "Transaction Added",
        context,
      );
      Navigator.of(context).pop();
    } catch (e) {
      log('Something went wrong in adding transaction: ${e.toString()}');
    }
  }
}
