// ignore_for_file: must_be_immutable

import 'package:expenses_app/models/transaction_model/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'chart_bar.dart';

class Chart extends StatelessWidget {
  List<TransactionModel?> recentTransaction;

  Chart(this.recentTransaction, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.only(left: 4.0, right: 4.0),
        child: Column(
          children: [
            const Text(
              "Chart of last 7 days",
              style:
                  TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: groupedTransactionsValues.map((data) {
                // Transactions.clearIt();
                return Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(
                      data['day'].toString(),
                      data['amount'],
                      maxSpending == 0.0
                          ? 0.0
                          : (double.parse(data['amount'].toString())) /
                              maxSpending),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  List<Map<String, Object>> get groupedTransactionsValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      int totalSum = 0;
      for (var i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i]?.date.day == weekDay.day &&
            recentTransaction[i]?.date.month == weekDay.month &&
            recentTransaction[i]?.date.year == weekDay.year) {
          totalSum += recentTransaction[i]?.amount ?? 0;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  double get maxSpending {
    return groupedTransactionsValues.fold(0, (sum, ite) {
      return sum + (ite['amount'] as int);
    });
  }
}
