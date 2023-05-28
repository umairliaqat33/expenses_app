import 'package:expenses_app/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider {
  final AuthService _authService = AuthService();
  Future<UserCredential?> createAccountAndSignIn(
    String email,
    String password,
    String lName,
    String fName,
  ) async {
    try {
      return await _authService.createAccount(email, password, fName, lName);
    } catch (e) {
      rethrow;
    }
  }

  Future<UserCredential?> signInUser(
    String email,
    String password,
  ) async {
    try {
      return await _authService.signInUser(
        email,
        password,
      );
    } catch (e) {
      rethrow;
    }
  }
}
