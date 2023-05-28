// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:expenses_app/ui_parts/screens/auth/auth_decision_screen.dart';
import 'package:expenses_app/models/transaction_model/transaction_model.dart';
import 'package:expenses_app/providers/firestore_provider.dart';
import 'package:expenses_app/ui_parts/screens/chart/chart.dart';
import 'package:expenses_app/ui_parts/screens/transaction_screens/components/new_transactions.dart';
import 'package:expenses_app/ui_parts/screens/transaction_screens/components/no_transactions_widget.dart';
import 'package:expenses_app/ui_parts/screens/transaction_screens/components/transaction_list_part.dart';
import 'package:expenses_app/ui_parts/widgets/custom_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatefulWidget {
  const TransactionList({super.key});

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  final FirestoreProvider _firestoreProvider = FirestoreProvider();
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => const NewTransactions(),
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text(
          "Personal Expenses",
          style: TextStyle(fontSize: 20),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _logout();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: StreamBuilder<List<TransactionModel?>>(
        stream: _firestoreProvider.getTransactionsStream(),
        builder: (BuildContext context,
            AsyncSnapshot<List<TransactionModel?>> snapshot) {
          return Column(
            children: [
              Chart(snapshot.data ?? []),
              snapshot.connectionState == ConnectionState.waiting
                  ? const Center(
                      child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                    ))
                  : snapshot.data!.isEmpty
                      ? const NoTransactionsWidget()
                      : Expanded(
                          flex: 1,
                          child: TransactionListPart(
                            transactionList: snapshot.data!,
                          ),
                        ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const AuthDecisionScreen(),
        ),
        (route) => false,
      );
      CustomToast.showCustomToast(
        "Logout Successful",
        context,
      );
    } catch (e) {
      log('Something went wrong in log out: ${e.toString()}');
    }
  }
}
