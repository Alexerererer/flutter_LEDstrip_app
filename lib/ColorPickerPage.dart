import 'package:flutter/material.dart';
import 'package:flutter_hsvcolor_picker/flutter_hsvcolor_picker.dart';


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
     Color startHex = ModalRoute.of(context)!.settings.arguments as Color;
    return Scaffold(
         body: Center(
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
                  color: startHex,
                  onChanged: (value) => super.setState(
                        () => onChanged(value),
                  ),
                ),


                ///---------------------------------
              ),
            ),
          ),
          ElevatedButton(onPressed: () {
            Navigator.pop(context,hex);
          },
              child: Text('Pick'))
        ],
      ),
    )
    );
  }
}