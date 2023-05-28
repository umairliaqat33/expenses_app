// ignore_for_file: unnecessary_null_comparison

import 'dart:io';

import 'package:expenses_app/models/userModel/user_model.dart';
import 'package:expenses_app/services/firestore_service.dart';
import 'package:expenses_app/utils/exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = FirestoreService();
  User? user;
  Future<UserCredential?> createAccount(
    String email,
    String password,
    String fName,
    String lName,
  ) async {
    UserCredential? userCredential;
    try {
      userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = _firebaseAuth.currentUser;
      if (userCredential != null) {
        _firestoreService.postUserDataToFirestore(
          UserModel(
            FName: fName,
            LName: lName,
            email: email,
            uid: user!.uid,
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw EmailAlreadyExistException('Email already in use');
      } else {
        throw UnknownException('Something went wrong${e.code} ${e.message}');
      }
    } on SocketException catch (e) {
      throw NoInternetException("No internet ${e.message}");
    } on FormatException catch (e) {
      throw FormatParsingException(
          "Something went wrong in fetching data ${e.message}");
    }
    return userCredential;
  }

  Future<UserCredential?> signInUser(String email, String password) async {
    UserCredential? userCredential;
    try {
      userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == "wrong-password") {
        throw WrongPasswordException("Email or password is incorrect");
      } else if (e.code == "user-not-found") {
        throw UserNotFoundException('User not found');
      } else if (e.code == "network-request-failed") {
        throw SocketException("${e.code}${e.message}");
      } else {
        throw UnknownException('Something went wrong ${e.code} ${e.message}');
      }
    }
    return userCredential;
  }
}
