import 'dart:async';

import 'package:bubble/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_group_chat/bloc/communication/bloc.dart';
import 'package:flutter_group_chat/model/text_message.dart';
import 'package:intl/intl.dart';


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


  TextEditingController  _messageController;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _messageController = TextEditingController();

    _messageController.addListener(() {
      if (mounted)
        setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: BlocBuilder<CommunicationBloc,CommunicationState>(
        builder: (context,state){
          if (state is LoadedCommunication){
            Timer(
                Duration(milliseconds: 100),
                    () => _scrollController
                    .jumpTo(_scrollController.position.maxScrollExtent));
            return Container(
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
                        controller: _scrollController,
                          itemCount: state.messages.length,
                          itemBuilder: (BuildContext context,int index){
                            return state.messages[index].senderId ==
                                widget.uid
                                ? messageLayout(
                              senderId:state.messages[index].senderId ,
                                senderName:state.messages[index].senderName ,
                                text:
                                state.messages[index].content,
                                time: DateFormat('hh:mm a')
                                    .format(state
                                    .messages[index].time
                                    .toDate()),
                                color: Colors.green[300],
                                align: TextAlign.left,
                                nip: BubbleNip.rightTop,
                                boxAlign: CrossAxisAlignment.end)
                                : messageLayout(
                              senderName: state.messages[index].senderName,
                                text:
                                state.messages[index].content,
                                time: DateFormat('hh:mm a')
                                    .format(state
                                    .messages[index].time
                                    .toDate()),
                                color: Colors.white,
                                align: TextAlign.left,
                                nip: BubbleNip.leftTop,
                                boxAlign:
                                CrossAxisAlignment.start);
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
                            ), onPressed: () {
                            BlocProvider.of<CommunicationBloc>(context)..add(
                                SendTextMessage(
                                    message: TextMessage(
                                      time: Timestamp.now(),
                                      senderId: widget.uid,
                                      content: _messageController.text,
                                      type: "TEXT",
                                      receiverName: "",
                                      recipientId: "",
                                      senderName:widget.name,
                                    )
                                )
                            );
                            _messageController.text="";
                          },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }
          return Container(child: Center(
            child: CircularProgressIndicator(),
          ),);
        },
      )
    );
  }


  Column messageLayout({text, time, color, align, boxAlign, nip,senderName,senderId}) => Column(
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
              widget.uid==senderId ? Text(
            "Me",
            textAlign: align,
            style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
          ): Text(
                senderName,
                textAlign: align,
                style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
              ),
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