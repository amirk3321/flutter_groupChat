import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_group_chat/model/text_message_entity.dart';

class TextMessage extends Equatable{
  final String recipientId;
  final String senderId;
  final String senderName;
  final String type;
  final Timestamp time;
  final String content;
  final String receiverName;

  TextMessage(
      {this.recipientId = '',
      this.senderId = '',
      this.senderName = '',
      this.type = "TEXT",
      this.time,
      this.content='',
      this.receiverName=''});

  @override
  List<Object> get props => [recipientId,senderId,senderName,type,time,content,receiverName];

  TextMessage copyWith({
    String recipientId,
    String senderId,
    String senderName,
    String type,
    Timestamp time,
    String content,
    String receiverName,
  }) {
    return TextMessage(
      recipientId: recipientId ?? this.recipientId,
      senderId: senderId ?? this.senderId,
      senderName: senderName ?? this.senderName,
      type: type ?? this.type,
      time: time ?? this.time,
      content: content ?? this.content,
      receiverName: receiverName ?? this.receiverName,
    );
  }


  TextMessageEntity toEntity() =>
      TextMessageEntity(recipientId, senderId, senderName, type, time,content,receiverName);

  static TextMessage fromEntity(TextMessageEntity messageEntity) => TextMessage(
        recipientId: messageEntity.recipientId,
        senderId: messageEntity.senderId,
        senderName: messageEntity.senderName,
        type: messageEntity.type,
        time: messageEntity.time,
        content:messageEntity.content,
        receiverName: messageEntity.receiverName,
      );


}
