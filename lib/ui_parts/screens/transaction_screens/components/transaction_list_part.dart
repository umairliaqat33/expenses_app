import 'package:expenses_app/models/transaction_model/transaction_model.dart';
import 'package:expenses_app/providers/firestore_provider.dart';
import 'package:expenses_app/ui_parts/widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionListPart extends StatelessWidget {
  final List<TransactionModel?> transactionList;
  TransactionListPart({
    Key? key,
    required this.transactionList,
  }) : super(key: key);
  final FirestoreProvider _firestoreProvider = FirestoreProvider();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: transactionList.length,
        itemBuilder: (context, index) {
          TransactionModel? transaction = transactionList[index];
          String title = transaction?.title ?? "No title found";
          int amount = transaction?.amount ?? 0;
          DateTime? date = transaction?.date ?? DateTime.now();
          return Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    padding: const EdgeInsets.all(5),
                    child: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: FittedBox(
                          child: Text(
                            'Rs ${amount.toStringAsFixed(0)}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            DateFormat.yMMMd().format(date),
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () => _deleteTransaction(
                        transaction!.id!,
                        context,
                      ),
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _deleteTransaction(
    String id,
    BuildContext context,
  ) {
    _firestoreProvider.deleteTransaction(
      id,
    );
    CustomToast.showCustomToast("Transaction Deleted", context);
  }
}
