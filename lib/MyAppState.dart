

import 'package:flutter/material.dart';
import 'dart:io';
import "dart:convert";

import 'package:shared_preferences/shared_preferences.dart';

class MyAppState extends ChangeNotifier {
  final JsonEncoder encoder = JsonEncoder();
  final serverIp = "192.168.1.15";
  final port = 43433;
  Socket? socket;
  var socketPlaceholder = true;
  var message = {'mode':'greeting','primaryColor': Colors.blue.value,'secondaryColor' : Colors.blue.value,'intensity': 128,'secondaryColorExists': false,'animation' : false};
  var messageToSend = {'mode':'greeting','primaryColor': Colors.blue.value.toString(),'secondaryColor' : Colors.blue.value.toString(),'intensity': '128','secondaryColorExists': 'false','animation' : 'false'};

  void connectTCP(String mode) async{
    try {
      message['mode'] = mode;
      messageToSend['mode'] = mode;
      messageToSend['primaryColor'] = message['primaryColor'].toString();
      messageToSend['secondaryColor'] = message['secondaryColor'].toString();
      messageToSend['intensity'] = message['intensity'].toString();
      messageToSend['secondaryColorExists'] = message['secondaryColorExists'].toString();
      messageToSend['animation'] = message['animation'].toString();
      socket = await Socket.connect(serverIp, port);
      socket!.writeln(encoder.convert(message));
      print(message);
      socket!.listen((data) {
        if(data.isNotEmpty) {
          print(data);
          socketPlaceholder = false;
        }
        notifyListeners();
        socket!.destroy();
      });
    } on Exception catch (e) {
      print(e);
    }

  }

  void loadConf() async{
    final prefs = await SharedPreferences.getInstance();

    message['primaryColor'] =  prefs.getInt('primaryColor') ?? Colors.blue.value;
    message['secondaryColor'] =  prefs.getInt('secondaryColor') ?? Colors.blue.value;
    message['intensity'] = prefs.getInt('intensity') ?? 128;
    message['secondaryColorExists'] = prefs.getBool('secondaryColorExists') ?? false;
    message['animation'] = prefs.getBool('animation') ?? false;
  }

  void saveConf() async{
    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt('primaryColor',message['primaryColor'] as int);
    await prefs.setInt('secondaryColor',message['secondaryColor'] as int);
    await prefs.setInt('intensity', message['intensity'] as int);
    await prefs.setBool('secondaryColorExists', message['secondaryColorExists'] as bool);
    await prefs.setBool('animation', message['animation'] as bool);
  }

  void disconnectTCP(){
    if(socket != null) {
      socket!.destroy();
      socketPlaceholder = true;
    }
  }

  void getNext() async {

    notifyListeners();
  }

}
