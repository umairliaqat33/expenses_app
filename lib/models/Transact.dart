import 'package:expenses_app/widgets/chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

final _fireStore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;
User? user = _auth.currentUser;

class Transactions extends ChangeNotifier {
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

  postDetailsToFireStore(String titl, int amou, DateTime dat) async {
    //calling our fireStore
    //calling user model
    //sending values
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    Transactions transactions = Transactions();
    transactions.title = titl;
    transactions.amount = amou;
    transactions.date = dat;

    await firebaseFirestore
        .collection('user')
        .doc(user?.uid)
        .collection('expenses')
        .doc()
        .set(transactions.toMap());
    Fluttertoast.showToast(msg: "Transaction Added Successfully");
    notifyListeners();
  }

  void delete(DocumentSnapshot data) {
    _fireStore
        .collection('user')
        .doc(user!.uid)
        .collection('expenses')
        .doc(data.id)
        .delete();
    notifyListeners();
  }

  List<Transactions> sampleList = [];

  getList() async {
    //getting a list of transaction type from firebase using this complex function
    // sampleList.clear();
    await _fireStore
        .collection('user')
        .doc(user!.uid)
        .collection('expenses')
        .snapshots() //snapshot is actually is the right thing which is returning us all the values from firebase.
        .listen((snap) {
      sampleList.clear();
      snap.docs.forEach((d) {
        //forEach is used to give all the data in the form of a loop and gives us all data from firebase and we can store where ever we want.
        sampleList.add(
          Transactions(
              amount: d.get('amount'),
              date: DateTime.fromMicrosecondsSinceEpoch(
                  d.get('date').microsecondsSinceEpoch),
              //this is how we can convert timeStamp into dateTime
              title: d.get('title')),
        );
      });
    });
  }

  List<Transactions> get recentTransactions {
    getList(); //this getter is giving us the most recent transactions of 7 days from today.
    return sampleList.where((tx) {
      return tx.date!.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void clearit() {
    sampleList.clear();
  }
}
