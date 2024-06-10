import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Checkbox.dart';
import 'MyAppState.dart';

class ConstantModePage extends StatefulWidget {
  const ConstantModePage({Key? key}) : super(key: key);

  @override
  State<ConstantModePage> createState() => _ConstantModePageState();
}

class _ConstantModePageState extends State<ConstantModePage> {
  Color primaryColor = Colors.blue;
  Color secondaryColor = Colors.blue;




  @override
  Widget build(BuildContext context){
    var appState = context.watch<MyAppState>();
    final hide = appState.message["secondaryColorExists"] as bool;
    int primaryColor = appState.message['primaryColor'] as int;
    int secondaryColor = appState.message['secondaryColor'] as int;
    double currentSliderValue =  double.parse(appState.message['intensity'].toString());


    var colorRow = Visibility( maintainSize: true, maintainAnimation: true, maintainState: true, visible: hide, child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text("SecondaryColor:",style: TextStyle(fontSize: 20),),
        SizedBox(width: 10,),
        Padding(
            padding: const EdgeInsets.all(10),
            child : FloatingActionButton(onPressed: () {
              _navigateToColorPickerAndPickColor(context,secondaryColor,
                      (selectedColor) {
                        appState.message['secondaryColor'] = selectedColor.value;
                  });//passing var here
            },
              backgroundColor: Color(secondaryColor),)
        ),
      ],
    ),

    );

    var animationRow = Visibility( maintainSize: true, maintainAnimation: true, maintainState: true, visible: hide, child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text("Animation:",style: TextStyle(fontSize: 20),),
        SizedBox(width: 10,),
       FormCheckbox(setting: 'animation'),
      ],
    ),

    );
    /*if(hide){
      row = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("SecondaryColor:",style: TextStyle(fontSize: 20),),
          SizedBox(width: 10,),
          Padding(
              padding: const EdgeInsets.all(10),
              child : FloatingActionButton(onPressed: () {
                _navigateToColorPickerAndPickColor(context,secondaryColor,
                        (selectedColor) {
                      secondaryColor = selectedColor;
                    });//passing var here
              },
                backgroundColor: secondaryColor,)
          ),
        ],
      );
    }
    */


    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Intensity: ${currentSliderValue.round()}',style: TextStyle(fontSize: 20),),
          Row(mainAxisAlignment: MainAxisAlignment.center,children: [
            Slider(
              value:  currentSliderValue,
              max: 256,
              divisions: 256,
              label: currentSliderValue.round().toString(),
              onChanged: (double value) {
                setState(() {
                  currentSliderValue = value;
                  appState.message['intensity'] = currentSliderValue.round();
                });
              },
            ),


          ],),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("PrimaryColor:",style: TextStyle(fontSize: 20),),
              SizedBox(width: 10,),
              Padding(
                  padding: const EdgeInsets.all(10),
                  child : FloatingActionButton(onPressed: () {
                      _navigateToColorPickerAndPickColor(context,primaryColor,
                          (selectedColor) {
                            appState.message['primaryColor'] = selectedColor.value;
                          });//passing var here
                    },
                    backgroundColor: Color(primaryColor),)
                    ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("SecondaryColor:",style: TextStyle(fontSize: 20),),
              SizedBox(width: 10,),
              FormCheckbox(setting: 'secondaryColorExists'),
              ElevatedButton(onPressed: () {print(appState.message.toString()); print(Color(appState.message['primaryColor'] as int));}, child: Text('test'))
            ],
          ),
          colorRow,
          animationRow,
          ElevatedButton(onPressed: () {
            appState.saveConf();
            Timer(Duration(milliseconds: 500), () {appState.connectTCP('constantMode');});
          }, child: Text('Update & send'))
        ],
      ),
    );
  }

  Future<void> _navigateToColorPickerAndPickColor (BuildContext context, int color,Function(Color) updateColor) async{ //color var goes after context

    final result = await Navigator.pushNamed(context, '/picker',arguments: Color(color)); //pass var here in arguments to send

    if (!mounted) return;

    setState(() {
      updateColor(result as Color);
    });

  }
}