import 'dart:developer' as log;
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses_app/models/transaction_model/transaction_model.dart';
import 'package:expenses_app/models/userModel/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> postUserDataToFirestore(
    UserModel userModel,
  ) async {
    await _firebaseFirestore
        .collection('user')
        .doc(userModel.uid)
        .set(userModel.toJson());
  }

  Future<UserModel?> getUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    final data =
        await _firebaseFirestore.collection('user').doc(user!.uid).get();
    if (data.data() == null) return null;
    return UserModel.fromJson(data.data()!);
  }

  void addTransaction(TransactionModel transactionModel) {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      String docId = createRandomId();
      transactionModel.id = docId;
      _firebaseFirestore
          .collection('user')
          .doc(user!.uid)
          .collection('expenses')
          .doc(docId)
          .set(transactionModel.toJson());
    } catch (e) {
      log.log("Error in adding transaction ${e.toString()}");
    }
  }

  Stream<List<TransactionModel?>> getTransactionStream() {
    User? user = FirebaseAuth.instance.currentUser;
    return _firebaseFirestore
        .collection('user')
        .doc(user!.uid)
        .collection('expenses')
        .snapshots()
        .map((event) => event.docs
            .map(
              (e) => TransactionModel.fromJson(
                e.data(),
              ),
            )
            .toList());
  }

  void deleteTransactionById(String transactionId) async {
    User? user = FirebaseAuth.instance.currentUser;
    await _firebaseFirestore
        .collection('user')
        .doc(user!.uid)
        .collection('expenses')
        .doc(transactionId)
        .delete();
  }

  String createRandomId() {
    String chars =
        "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    return List.generate(30, (index) {
      final indexRandom = Random.secure().nextInt(chars.length);
      return chars[indexRandom];
    }).join('');
  }
}
