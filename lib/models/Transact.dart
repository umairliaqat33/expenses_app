class Transactions {
  String? title;
  int? amount;
  DateTime? date;
  // final user = FirebaseAuth.instance.currentUser;

  Transactions({this.amount, this.date, this.title});
  List<Transactions> transaction = [];
  factory Transactions.fromMap(map) {
    return Transactions(
        title: map['title'], amount: map['amount'], date: map['date']);
  }

  //sending data to firebase
  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'date': date,
      'title': title,
    };
  }
}
