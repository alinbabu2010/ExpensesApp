import 'package:expenses_app/widgets/user_transactions.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter App"),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start, children: [
        Container(
          width: double.infinity,
          child: const Card(
            color: Colors.blueAccent,
            elevation: 5,
            child: Text("Chart!"),
          ),
        ),
        const UserTransactions()
      ]),
    );
  }
}
