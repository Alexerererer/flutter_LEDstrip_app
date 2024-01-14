import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import "dart:convert";

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
