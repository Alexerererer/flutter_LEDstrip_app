import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'MyAppState.dart';

class FormCheckbox extends StatefulWidget {
  const FormCheckbox({super.key, required this.setting});
  final String setting;

  @override
  State<FormCheckbox> createState() => _FormCheckboxState();
}

class _FormCheckboxState extends State<FormCheckbox> {
  bool isChecked = false;


  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    isChecked = appState.message[widget.setting] as bool;

    return Checkbox(
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
          appState.message[widget.setting] = isChecked;
          appState.notifyListeners();
          print(appState.message);
        });
      },
    );
  }
}
