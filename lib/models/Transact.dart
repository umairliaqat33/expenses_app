import 'package:flutter/material.dart';

class Transaction {
  @required
  final String id;
  @required
  final String title;
  @required
  final String amount;
  @required
  final DateTime date;

  Transaction(this.amount, this.date, this.id, this.title);
}
