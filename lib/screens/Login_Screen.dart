import 'package:expenses_app/screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:expenses_app/models/constants.dart';
import 'package:expenses_app/screens/Registration_Screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  // bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.green,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('assets/images/logo.png'),
                  ),
                ),
                SizedBox(
                  height: 48.0,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      // this will be checking if we have any value in it or not?
                      return "Field required";
                    }
                    // if (RegExp("^[a-ZA-Z0-9+_.-]+@[a-ZA-Z0-9.-]+.[a-z]")
                    //     .hasMatch(value)) {
                    //   // this will be checking whether the value in it is an email or not?
                    //   return "Enter a valid email";
                    // }
                    return null;
                  },
                  cursorColor: Colors.green,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  controller: emailController,
                  decoration: kMessageTextFieldDecoration.copyWith(
                    hintText: 'Enter Your Email',
                    icon: Icon(Icons.email),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                  validator: (value) {
                    RegExp regex = new RegExp(r"^.{6,}$");
                    if (value!.isEmpty) {
                      return "Field is required";
                    }
                    if (!regex.hasMatch(value)) {
                      return "Please enter a valid password of 6 minimum characters";
                    }
                    return null;
                  },
                  cursorColor: Colors.green,
                  textInputAction: TextInputAction.done,
                  obscureText: true,
                  textAlign: TextAlign.center,
                  controller: passController,
                  decoration: kMessageTextFieldDecoration.copyWith(
                    hintText: 'Enter Your Password',
                    icon: Icon(Icons.vpn_key),
                  ),
                ),
                SizedBox(
                  height: 24.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Material(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    elevation: 5.0,
                    child: MaterialButton(
                      onPressed: () {
                        singIn(emailController.text, passController.text);
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      minWidth: 200.0,
                      height: 42.0,
                      child: Text(
                        'Log In',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Don\'t have an account? '),
                    TextButton(
                      style: ButtonStyle(
                          splashFactory: NoSplash
                              .splashFactory //removing onclick splash color
                          ),
                      onPressed: () {},
                      child: Text("SignUp"),
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

  void singIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) {
        Fluttertoast.showToast(msg: "Login Successful");
      });
      Navigator.push(context,
              MaterialPageRoute(builder: (context) => WelcomeUserScreen()))
          .catchError((e) {
        Fluttertoast.showToast(msg: e.toString());
      });
    }else{
      Fluttertoast.showToast(msg: "Please check email or password and try again");
    }
  }
}
