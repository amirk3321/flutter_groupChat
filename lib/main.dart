
import 'package:flutter/material.dart';
import 'package:flutter_group_chat/screen/login_screen.dart';

void main() => runApp(myApp());


class myApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>myAppState();
}

class myAppState extends State<myApp>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "Flutter Demo",
      theme: ThemeData(primarySwatch: Colors.red),
      home: LoginScreen()
    );
  }
}