import 'package:flutter/material.dart';

class NoTransactionsWidget extends StatelessWidget {
  const NoTransactionsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "No transaction yet!",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(
          width: double.infinity,
          height: 10,
        ),
        SizedBox(
          height: 200,
          child: Image.asset(
            "assets/images/waiting.png",
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
