import 'package:expenses_app/models/transaction_model/transaction_model.dart';
import 'package:expenses_app/providers/firestore_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final FirestoreProvider _firestoreProvider = FirestoreProvider();
  bool _isHighest = false;
  bool _isLowest = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (states) => Colors.red,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      _isHighest = !_isHighest;
                      _isLowest = false;
                    });
                  },
                  child: const Text("Highest Expense"),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isLowest = !_isLowest;
                      _isHighest = false;
                    });
                  },
                  child: const Text("Lowest Expense"),
                ),
              ],
            ),
            StreamBuilder<List<TransactionModel?>>(
              stream: _firestoreProvider.getTransactionsStream(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<TransactionModel?>> snapshot) {
                List<DataRow> displayedDataCell = [];
                if (snapshot.hasData) {
                  if (_isHighest) {
                    TransactionModel? highest = snapshot.data
                        ?.reduce((a, b) => a!.amount > b!.amount ? a : b);

                    displayedDataCell.add(
                      DataRow(
                        cells: [
                          DataCell(
                            Text(
                              DateFormat.yMMMd()
                                  .format(highest!.date)
                                  .toString(),
                            ),
                          ),
                          DataCell(
                            Text(
                              highest.amount.toString(),
                            ),
                          ),
                          DataCell(
                            Text(
                              highest.title.toString(),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (_isLowest) {
                    TransactionModel? lowest = snapshot.data
                        ?.reduce((a, b) => a!.amount < b!.amount ? a : b);

                    displayedDataCell.add(
                      DataRow(
                        cells: [
                          DataCell(
                            Text(
                              DateFormat.yMMMd()
                                  .format(lowest!.date)
                                  .toString(),
                            ),
                          ),
                          DataCell(
                            Text(
                              lowest.amount.toString(),
                            ),
                          ),
                          DataCell(
                            Text(
                              lowest.title.toString(),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    for (var item in snapshot.data!) {
                      displayedDataCell.add(
                        DataRow(
                          cells: [
                            DataCell(
                              Text(
                                DateFormat.yMMMd()
                                    .format(item!.date)
                                    .toString(),
                              ),
                            ),
                            DataCell(
                              Text(
                                item.amount.toString(),
                              ),
                            ),
                            DataCell(
                              Text(
                                item.title.toString(),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  }
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                  ));
                }
                return FittedBox(
                  child: DataTable(
                    headingTextStyle: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    columns: const <DataColumn>[
                      DataColumn(
                        label: Text(
                          'Date',
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Amount',
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Optional Detail',
                        ),
                      ),
                    ],
                    rows: displayedDataCell,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
