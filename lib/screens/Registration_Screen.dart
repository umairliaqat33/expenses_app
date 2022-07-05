import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses_app/menu_screen.dart';
import 'package:expenses_app/models/constants.dart';
import 'package:expenses_app/screens/Login_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'welcome_screen.dart';
import 'package:expenses_app/models/user_model.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final C_pass_controller = TextEditingController();
  final L_name_Controller = TextEditingController();
  final F_name_Controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool showSpinner = false;

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
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => WelcomeScreen()));
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
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
                    style: TextStyle(color: Colors.black),
                    controller: F_name_Controller,
                    decoration: kMessageTextFieldDecoration.copyWith(
                      hintText: 'Enter Your First Name',
                      icon: Icon(Icons.account_circle),
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        // this will be checking if we have any value in it or not?
                        return "First name is required";
                      }
                      if (value == F_name_Controller.text) {
                        return "First and last name can not b same";
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    cursorColor: Colors.green,
                    keyboardType: TextInputType.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black),
                    controller: L_name_Controller,
                    decoration: kMessageTextFieldDecoration.copyWith(
                      hintText: 'Enter Your Last Name',
                      icon: Icon(Icons.account_circle),
                    ),
                  ),
                  SizedBox(
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
                    style: TextStyle(color: Colors.black),
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
                        return "Password must contain 6 characters minimum";
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.done,
                    cursorColor: Colors.green,
                    textAlign: TextAlign.center,
                    obscureText: true,
                    style: TextStyle(color: Colors.black),
                    controller: passController,
                    decoration: kMessageTextFieldDecoration.copyWith(
                      hintText: 'Enter Your Password',
                      icon: Icon(Icons.key),
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Field is required";
                      }
                      if (value != passController.text) {
                        return "Password do not match try again";
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.done,
                    cursorColor: Colors.green,
                    textAlign: TextAlign.center,
                    obscureText: true,
                    style: TextStyle(color: Colors.black),
                    controller: C_pass_controller,
                    decoration: kMessageTextFieldDecoration.copyWith(
                      hintText: 'Confirm Password',
                      icon: Icon(Icons.key),
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Material(
                      color: Colors.green,
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      elevation: 5.0,
                      child: MaterialButton(
                        onPressed: () {
                          setState(() {
                            showSpinner = true;
                          });
                          SignUp(emailController.text, passController.text);
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        splashColor: null,
                        minWidth: 200.0,
                        height: 42.0,
                        child: Text(
                          'Register',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Already have an account? '),
                      TextButton(
                        style: ButtonStyle(
                            splashFactory: NoSplash
                                .splashFactory //removing onclick splash color
                            ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        },
                        child: Text("LogIn"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void SignUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        postDetailsToFireStore();
      }).catchError((e) {
        Fluttertoast.showToast(msg: e.toString());
      });
    }
  }

  postDetailsToFireStore() async {
    //calling our fireStore
    //calling user model
    //sending values
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    UserModel userModel = UserModel();
    userModel.email = user!.email;
    userModel.Fname = F_name_Controller.text;
    userModel.Lname = L_name_Controller.text;
    userModel.uid = user.uid;

    await firebaseFirestore
        .collection('user')
        .doc(user.uid)
        .set(userModel.toMap());

    Fluttertoast.showToast(msg: "Account Created Successfully");
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => WelcomeUserScreen()));
  }
}
