// ignore_for_file: import_of_legacy_library_into_null_safe, use_build_context_synchronously

import 'package:expenses_app/ui_parts/screens/auth/auth_decision_screen.dart';
import 'package:expenses_app/models/constants.dart';
import 'package:expenses_app/providers/auth_provider.dart';
import 'package:expenses_app/ui_parts/screens/auth/login_screen.dart';
import 'package:expenses_app/ui_parts/screens/transaction_screens/transaction_list.dart';
import 'package:expenses_app/ui_parts/widgets/round_button.dart';
import 'package:expenses_app/utils/exceptions.dart';
import 'package:expenses_app/ui_parts/widgets/custom_toast.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _lNameController = TextEditingController();
  final _fNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _showSpinner = false;
  final AuthProvider _authProvider = AuthProvider();

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: SizedBox(
                    height: 200.0,
                    child: Image.asset('assets/images/logo.png'),
                  ),
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      // this will be checking if we have any value in it or not?
                      return "First name is required";
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  cursorColor: Colors.green,
                  keyboardType: TextInputType.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.black),
                  controller: _fNameController,
                  decoration: kMessageTextFieldDecoration.copyWith(
                    hintText: 'Enter Your First Name',
                    icon: const Icon(Icons.account_circle),
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      // this will be checking if we have any value in it or not?
                      return "First name is required";
                    }
                    if (value == _fNameController.text) {
                      return "First and last name can not b same";
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  cursorColor: Colors.green,
                  keyboardType: TextInputType.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.black),
                  controller: _lNameController,
                  decoration: kMessageTextFieldDecoration.copyWith(
                    hintText: 'Enter Your Last Name',
                    icon: const Icon(Icons.account_circle),
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      // this will be checking if we have any value in it or not?
                      return "Field required";
                    }
                    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                        .hasMatch(value)) {
                      // this will be checking whether the value in it is an email or not?
                      return "Enter a valid email";
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  cursorColor: Colors.green,
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.black),
                  controller: _emailController,
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
                  textInputAction: TextInputAction.done,
                  cursorColor: Colors.green,
                  textAlign: TextAlign.center,
                  obscureText: true,
                  style: const TextStyle(color: Colors.black),
                  controller: _passController,
                  decoration: kMessageTextFieldDecoration.copyWith(
                    hintText: 'Enter Your Password',
                    icon: const Icon(Icons.key),
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                _showSpinner
                    ? const SizedBox(
                        height: 50,
                        width: 50,
                        child: CircularProgressIndicator(
                          color: Colors.green,
                        ),
                      )
                    : RoundedButton(
                        color: Theme.of(context).primaryColor,
                        onPressed: () async => _signUp(
                          _emailController.text,
                          _passController.text,
                          _fNameController.text,
                          _lNameController.text,
                        ),
                        title: 'Register',
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('Already have an account? '),
                    TextButton(
                      style: const ButtonStyle(
                          splashFactory: NoSplash
                              .splashFactory //removing onClick splash color
                          ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()));
                      },
                      child: const Text("LogIn"),
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

  void _signUp(
    String email,
    String password,
    String fName,
    String lName,
  ) async {
    try {
      if (_formKey.currentState!.validate()) {
        FocusManager.instance.primaryFocus?.unfocus();
        setState(() {
          _showSpinner = true;
        });
        var userCredentials = await _authProvider.createAccountAndSignIn(
          email,
          password,
          lName,
          fName,
        );
        if (userCredentials != null) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const AuthDecisionScreen(),
            ),
            (route) => false,
          );
          CustomToast.showCustomToast("SignUp Successful", context);
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const TransactionList(),
            ),
            (route) => false,
          );
        } else {
          CustomToast.showCustomToast("SignUp Failed", context);
        }
      }
    } on EmailAlreadyExistException catch (e) {
      CustomToast.showCustomToast(e.message, context);
    } on NoInternetException catch (e) {
      CustomToast.showCustomToast(e.message, context);
    } on FormatParsingException catch (e) {
      CustomToast.showCustomToast(e.message, context);
    } on UnknownException catch (e) {
      CustomToast.showCustomToast(e.message, context);
    }
    setState(() {
      _showSpinner = false;
    });
  }
}
