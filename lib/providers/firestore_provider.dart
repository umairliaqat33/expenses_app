import 'package:expenses_app/models/transaction_model/transaction_model.dart';
import 'package:expenses_app/models/userModel/user_model.dart';
import 'package:expenses_app/services/firestore_service.dart';

class FirestoreProvider {
  final FirestoreService _firestoreService = FirestoreService();
  Future<UserModel?> getUserData() async {
    return await _firestoreService.getUserData();
  }

  Stream<List<TransactionModel?>> getTransactionsStream() {
    return _firestoreService.getTransactionStream();
  }

  void deleteTransaction(String transactionId) {
    _firestoreService.deleteTransactionById(transactionId);
  }

  void addTransaction(TransactionModel transactionModel) {
    _firestoreService.addTransaction(transactionModel);
  }
}
