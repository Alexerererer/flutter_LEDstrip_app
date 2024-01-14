import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'MyAppState.dart';
import 'FirstPage.dart';
import 'dart:io';
import "dart:convert";
import 'package:flutter_hsvcolor_picker/flutter_hsvcolor_picker.dart';

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
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        ),
        home: FirstPage(),
      ),
    );
  }
}

/*

class MyAppState extends ChangeNotifier {
  final JsonEncoder encoder = JsonEncoder();
  final serverIp = "192.168.1.15";
  final port = 43433;
  Socket? socket;
  var socketPlaceholder = true;
  final greeting = {'mode' : 'greeting'};


  void connectTCP() async{
      try {
        socket = await Socket.connect(serverIp, port);
        socket!.writeln(encoder.convert(greeting));
        print(greeting['mode']);
        socket!.listen((data) {
          if(data.isNotEmpty) {
           print(data);
           socketPlaceholder = false;
          }
          notifyListeners();
        });
      } on Exception catch (e) {
        print(e);
      }

  }

  void disconnectTCP(){
    socket!.destroy();
    socketPlaceholder = true;
  }

  void getNext() async {

    notifyListeners();
  }

}


class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();


    if(!appState.socketPlaceholder){ //Currently INVERTED, change this when you want it to work
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
                width: 100,
                child: CircularProgressIndicator(
                  strokeWidth: 10,
                ),
              ),
              SizedBox(height: 100,),
              BigCard(pair: "Connecting")
            ],
          ),
        ),
      );
    }

    Widget page;
    switch (selectedIndex) {
      case 0:
        page = GeneratorPage();
        break;
      case 1:
        page = ConstantModePage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }


    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Row(
            children: [
              SafeArea(
                child: NavigationRail(
                  extended: constraints.maxWidth >= 600,
                  destinations: [
                    NavigationRailDestination(
                      icon: Icon(Icons.home),
                      label: Text('Home'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.favorite),
                      label: Text('Favorites'),
                    ),
                  ],
                  selectedIndex: selectedIndex,
                  onDestinationSelected: (value) {
                    setState(() {
                      selectedIndex = value;
                    });

                  },
                ),
              ),
              Expanded(
                child: Container(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: page,
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}

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

class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();


    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BigCard(pair: "Connected"),
          SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  appState.disconnectTCP();
                  Navigator.pop(context);
                },
                child: Text('Disconnect'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ConstantModePage extends StatefulWidget {
  const ConstantModePage({Key? key}) : super(key: key);

  @override
  State<ConstantModePage> createState() => _ConstantModePageState();
}

class _ConstantModePageState extends State<ConstantModePage> {


  @override
  Widget build(BuildContext context){
    return Scaffold(

    );
  }
}

class ColorPickerPage extends StatefulWidget {
  const ColorPickerPage({Key? key}) : super(key: key);

  @override
  State<ColorPickerPage> createState() => _ColorPickerPageState();
}

class _ColorPickerPageState extends State<ColorPickerPage> {
  Color hex = Colors.blue;
  void onChanged(Color value) => hex = value;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            width: 300,
            child: Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(1.0),
                ),
              ),
              elevation: 4.0,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14.0,
                  vertical: 2.0,
                ),

                ///---------------------------------
                child: ColorPicker(
                  color: Colors.blue,
                    onChanged: (value) => super.setState(
                          () => onChanged(value),
                    ),
                ),


                ///---------------------------------
              ),
            ),
          ),
          Text(hex.toString())
        ],
      ),
    );
  }
}



class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final String pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onSecondary,
      letterSpacing: 1.0,

    );


    return Card(
      color: theme.colorScheme.secondary,
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(pair, style: style,),
      ),


    );
  }
}
*/