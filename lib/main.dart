import 'package:expenses_app/screens/WelcomeScreen.dart';
import 'package:expenses_app/widgets/new_transactions.dart';
import 'package:flutter/material.dart';
import './widgets/transaction_list.dart';
import 'models/Transact.dart';
import 'widgets/chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily:
            'Quicksand', //this is how we use fonts for the whole project. To use individually so look in Appbar widget.
        primarySwatch: Colors.green,
        primaryColor: Colors.green,
        // accentColor: Colors.yellowAccent,
      ),
      title: "Personal Expenses",
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily:
            'Quicksand', //this is how we use fonts for the whole project. To use individually so look in Appbar widget.
        primarySwatch: Colors.green,
        primaryColor: Colors.green,
        // accentColor: Colors.yellowAccent,
      ),
      initialRoute: '/',
      routes: {
        '/': (context)=>WelcomeScreen(),

      },
    );
  }
}
