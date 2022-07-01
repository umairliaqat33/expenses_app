import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  String label = "";
  var spending = null;
  double totalSendingPercen = 0.0;

  ChartBar(this.label, this.spending, this.totalSendingPercen);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 20,
          child: FittedBox(
            child: Text(
              "Rs.${spending}",
              style: ThemeData.light().textTheme.bodyLarge,
            ),
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Container(
          width: 10,
          height: 60,
          child: Stack(
            //Stack works in a way that the bottom most widget is the first widget in widget tree, it goes bottom to top
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  color: Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                heightFactor: totalSendingPercen,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          label,
          style: ThemeData.light().textTheme.bodyLarge,
        ),
      ],
    );
  }
}
