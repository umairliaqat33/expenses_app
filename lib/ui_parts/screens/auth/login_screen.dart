// ignore_for_file: import_of_legacy_library_into_null_safe, unnecessary_null_comparison, use_build_context_synchronously

import 'package:expenses_app/providers/auth_provider.dart';
import 'package:expenses_app/ui_parts/screens/auth/auth_decision_screen.dart';
import 'package:expenses_app/ui_parts/screens/auth/registration_screen.dart';
import 'package:expenses_app/ui_parts/screens/transaction_screens/transaction_list.dart';
import 'package:expenses_app/ui_parts/widgets/round_button.dart';
import 'package:expenses_app/utils/exceptions.dart';
import 'package:expenses_app/ui_parts/widgets/custom_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:expenses_app/models/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final AuthProvider _authProvider = AuthProvider();
  bool _showSpinner = false;
  bool _textVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.green,
          ),
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const AuthDecisionScreen()));
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: SizedBox(
                    height: 200.0,
                    child: Image.asset('assets/images/logo.png'),
                  ),
                ),
                const SizedBox(
                  height: 48.0,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Field required";
                    }
                    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                        .hasMatch(value)) {
                      return "Enter a valid email";
                    }
                    return null;
                  },
                  cursorColor: Colors.green,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  controller: emailController,
                  decoration: kMessageTextFieldDecoration.copyWith(
                    hintText: 'Enter Your Email',
                    icon: const Icon(Icons.email),
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                  validator: (value) {
                    RegExp regex = RegExp(r"^.{6,}$");
                    if (value!.isEmpty) {
                      return "Field is required";
                    }
                    if (!regex.hasMatch(value)) {
                      return "Password must contain 6 characters minimum";
                    }
                    return null;
                  },
                  cursorColor: Colors.green,
                  textInputAction: TextInputAction.done,
                  obscureText: _textVisible,
                  textAlign: TextAlign.center,
                  controller: passController,
                  decoration: kMessageTextFieldDecoration.copyWith(
                    hintText: 'Enter Your Password',
                    icon: const Icon(Icons.vpn_key),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _textVisible = !_textVisible;
                        });
                      },
                      icon: _textVisible
                          ? SvgPicture.asset(
                              'assets/images/password_visibility_off.svg')
                          : SvgPicture.asset(
                              'assets/images/password_visibility_on.svg'),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24.0,
                ),
                _showSpinner
                    ? Container(
                        margin: const EdgeInsets.only(
                          left: 120,
                          right: 120,
                        ),
                        child: const CircularProgressIndicator(
                          color: Colors.green,
                        ),
                      )
                    : SizedBox(
                        width: double.infinity,
                        child: RoundedButton(
                          color: Theme.of(context).primaryColor,
                          onPressed: () {
                            setState(() {
                              _showSpinner = true;
                            });
                            _signIn(emailController.text, passController.text);
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                          title: 'Login',
                        ),
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('Don\'t have an account? '),
                    TextButton(
                      style: const ButtonStyle(
                          splashFactory: NoSplash
                              .splashFactory //removing onClick splash color
                          ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegistrationScreen(),
                          ),
                        );
                      },
                      child: const Text("SignUp"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _signIn(String email, String password) async {
    try {
      if (_formKey.currentState!.validate()) {
        UserCredential? userCredential = await _authProvider.signInUser(
          email,
          password,
        );
        if (userCredential != null) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const TransactionList(),
            ),
            (route) => false,
          );
          CustomToast.showCustomToast("Login Successful", context);
          _showSpinner = false;
          setState(() {});
        } else {
          CustomToast.showCustomToast("Login failed", context);
          setState(() {
            _showSpinner = false;
          });
        }
      }
    } on WrongPasswordException catch (e) {
      CustomToast.showCustomToast(e.message, context);
    } on UserNotFoundException catch (e) {
      CustomToast.showCustomToast(e.message, context);
    } on NoInternetException catch (e) {
      CustomToast.showCustomToast(e.message, context);
    } on UnknownException catch (e) {
      CustomToast.showCustomToast(e.message, context);
    }
    setState(() {
      _showSpinner = false;
    });
  }
}
