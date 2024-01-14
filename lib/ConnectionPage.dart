import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'MyAppState.dart';
import 'BigCard.dart';

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
