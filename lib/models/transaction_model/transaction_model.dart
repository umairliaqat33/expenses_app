import 'package:json_annotation/json_annotation.dart';

part 'transaction_model.g.dart';

@JsonSerializable()
class TransactionModel {
  final String title;
  final int amount;
  final DateTime date;
  String? id;
  TransactionModel({
    required this.amount,
    required this.date,
    required this.title,
    this.id,
  });
  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionModelToJson(this);

  // getList() async {
  //   User? user = await FirebaseAuth.instance.currentUser;
  //   await _fireStore
  //       .collection('user')
  //       .doc(user!.uid)
  //       .collection('expenses')
  //       .snapshots() //snapshot is actually is the right thing which is returning us all the values from firebase.
  //       .listen((snap) {
  //     sampleList.clear();
  //     snap.docs.forEach((d) {
  //       //forEach is used to give all the data in the form of a loop and gives us all data from firebase and we can store where ever we want.
  //       sampleList.add(
  //         Transactions(
  //             amount: d.get('amount'),
  //             date: DateTime.fromMicrosecondsSinceEpoch(
  //                 d.get('date').microsecondsSinceEpoch),
  //             //this is how we can convert timeStamp into dateTime
  //             title: d.get('title')),
  //       );
  //     });
  //   });
  // }

  // List<Transactions> get recentTransactions {
  //   getList(); //this getter is giving us the most recent transactions of 7 days from today.
  //   return sampleList.where((tx) {
  //     return tx.date!.isAfter(
  //       DateTime.now().subtract(
  //         Duration(days: 7),
  //       ),
  //     );
  //   }).toList();
  // }

  // void clearIt() {
  //   sampleList.clear();
  // }
}
