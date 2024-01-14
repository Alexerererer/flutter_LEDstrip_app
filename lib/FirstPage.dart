import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'MyAppState.dart';
import 'MyHomePage.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var appState = context.watch<MyAppState>();

    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 300,
          width: 300,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: CircleBorder()
            ),
            child: const Text('Connect',style: TextStyle(fontSize: 60),),
            onPressed: () {
              appState.connectTCP();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  MyHomePage()),
              );


            },
          ),
        ),
      ),
    );
  }
}