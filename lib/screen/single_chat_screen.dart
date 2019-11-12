import 'dart:async';

import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


class SingleChatScreen extends StatefulWidget {
  final String name;
  final String uid;
  final String otherUID;
  final String senderName;
  final String receiverName;
  final String channelId;

  SingleChatScreen(
      {Key key,
        this.name,
        this.uid,
        this.otherUID,
        this.senderName,
        this.receiverName,
        this.channelId})
      : super(key: key);

  @override
  _SingleChatScreenState createState() => _SingleChatScreenState();
}

class _SingleChatScreenState extends State<SingleChatScreen> {
  bool _isLocationEnable = false;
  String _resultText="";
  TextEditingController  _messageController;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _messageController = TextEditingController(text: _resultText);

    _messageController.addListener(() {
      if (mounted)
        setState(() {});
    });
    super.initState();
  }
  final messages=["hello","how are you"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("name"),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background.jpeg"),
            repeat: ImageRepeat.noRepeat,
            fit: BoxFit.cover
          )
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Flexible(
               child: ListView.builder(
                 itemCount: messages.length,
                   itemBuilder: (BuildContext context,int index){
                 return Text(
                   messages[index]
                 );
               }),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0.5, 0.2),
                        color: Colors.black54,
                        blurRadius: .2,
                      )
                    ],
                    color: Colors.grey[100]),
                child: Row(
                  children: <Widget>[
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.image),
                    ),
                    Flexible(
                      child: TextField(
                        controller: _messageController,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "type feel free.. :) <3"),
                      ),
                    ),
                    _messageController.text.isEmpty ?IconButton(
                      icon: Icon(
                        Icons.keyboard_voice,
                        color: Colors.red[700],
                      ), onPressed: () {},
                    ) : Text(""),
                    IconButton(
                      icon: Icon(
                        Icons.send,
                        color: _messageController.text.isEmpty
                            ? Colors.green[200]
                            : Colors.green[700],
                      ), onPressed: () {},
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Column messageLayout({text, time, color, align, boxAlign, nip}) => Column(
    crossAxisAlignment: boxAlign,
    children: <Widget>[
      Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.all(3),
        child: Bubble(
          color: color,
          nip: nip,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                text,
                textAlign: align,
                style: TextStyle(fontSize: 18),
              ),
              Text(
                time,
                textAlign: align,
                style: TextStyle(fontSize: 14),
              )
            ],
          ),
        ),
      )
    ],
  );


  @override
  void dispose() {
    _scrollController.dispose();
    _messageController.dispose();
    super.dispose();
  }
}