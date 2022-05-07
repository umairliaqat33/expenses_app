import 'package:expenses_app/models/constants.dart';
import 'package:expenses_app/screens/Login_Screen.dart';
import 'package:flutter/material.dart';
import 'welcome_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final C_pass_controller = TextEditingController();
  final L_name_Controller = TextEditingController();
  final F_name_Controller = TextEditingController();

  // bool showSpinner=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.green,),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
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
            // SizedBox(
            //   height: 8.0,
            // ),
            TextField(
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
            TextField(
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
            TextField(
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
            TextField(
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
            TextField(
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => WelcomeUserScreen()));
                  },
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
                      splashFactory:
                          NoSplash.splashFactory //removing onclick splash color
                      ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: Text("LogIn"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
