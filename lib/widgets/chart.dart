import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:expenses_app/models/Transact.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'chart_bar.dart';

final _auth = FirebaseAuth.instance;
User? user = _auth.currentUser;

class Chart extends StatelessWidget {
  List<Transactions> recentTransaction;

  Chart(this.recentTransaction);



  List<Map<String, Object>> get groupedTransactionsValues {
    //we are using list type map because we have to return two things date and amount
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(
          days:
              index)); //in this line we are getting today's date and time and subtracting it from the number of day which is index and get the information of all week Days.
      int totalSum = 0;
      for (var i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i].date!.day == weekDay.day &&
            recentTransaction[i].date!.month == weekDay.month &&
            recentTransaction[i].date!.year == weekDay.year) {
          totalSum += recentTransaction[i].amount!;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  double get maxSpendi {
    return groupedTransactionsValues.fold(0, (sum, ite) {
      return sum + (ite['amount'] as int);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<Transactions>(
      builder: (context, Transactions, child) {
        // Transactions.sampleList.clear();
        return Card(
        elevation: 6,
        margin: EdgeInsets.all(20),
        child: Padding(
          padding: EdgeInsets.all(4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransactionsValues.map((data) {
              Transactions.clearit();
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                    data['day'].toString(),
                    data['amount'],
                    maxSpendi == 0.0
                        ? 0.0
                        : (double.parse(data['amount'].toString())) /
                            maxSpendi),
              );
            }).toList(),
          ),
        ),
      );
      }
    );
  }
}
