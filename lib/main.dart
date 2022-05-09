import 'package:expenses_app/screens/menu_screen.dart';
import 'package:expenses_app/widgets/new_transactions.dart';
import 'package:flutter/material.dart';
import './widgets/transaction_list.dart';
import 'models/Transact.dart';
import 'widgets/chart.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
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
      home: FutureBuilder(
        future: _fbApp,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print("You have an error ${snapshot.error.toString()}");
            return Text("Something went wrong");
          } else if (snapshot.hasData) {
            return MyHomePage();
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
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
        '/': (context) => WelcomeScreen(),
      },
    );
  }
}
