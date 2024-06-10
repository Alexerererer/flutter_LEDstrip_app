import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'MyAppState.dart';
import 'FirstPage.dart';
import 'MyHomePage.dart';
import 'ColorPickerPage.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) =>  FirstPage(),
          '/home': (context) =>  MyHomePage(),
          '/picker': (context) => ColorPickerPage(),
        },
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        ),
      ),
    );
  }
}

