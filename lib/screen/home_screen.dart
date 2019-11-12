
import 'package:flutter/material.dart';
import 'package:flutter_group_chat/screen/single_chat_screen.dart';
import 'package:flutter_group_chat/screen/style/theme.dart' as theme;

class HomePage extends StatefulWidget {
    HomePage({Key key}) :super(key : key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height >= 775.0
              ? MediaQuery.of(context).size.height
              : 775.0,
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
                colors: [
                  theme.ThemeColors.loginGradientStart,
                  theme.ThemeColors.loginGradientEnd,
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 1.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Welcome XYZ Join Us For fun",style: TextStyle(
                fontFamily: 'rocks',
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),),
              SizedBox(height: 10,),
              FlatButton(
                padding: EdgeInsets.symmetric(horizontal: 40,vertical: 5),
                color: Colors.blue.withOpacity(.7),
                child: Text(
                  "Join",
                  style: TextStyle(
                    fontSize: 30
                  ),
                ),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (_) =>
                        SingleChatScreen()
                  ));
                },
              )
            ],
          )
        ),
      ),
    );
  }
}