import 'package:equatable/equatable.dart';
import 'package:flutter_group_chat/model/text_message.dart';

abstract class CommunicationEvent extends Equatable {
  const CommunicationEvent();
}

class JoinChatRoom extends CommunicationEvent{
  @override
  // TODO: implement props
  List<Object> get props => [];
}
class SendTextMessage extends CommunicationEvent{
  final TextMessage message;
  SendTextMessage({this.message});
  @override
  // TODO: implement props
  List<Object> get props => [message];
}
class MessagesLoad extends CommunicationEvent{
  @override
  // TODO: implement props
  List<Object> get props => [];
}
class MessagesUpdated extends CommunicationEvent{
  final List<TextMessage> messages;
  MessagesUpdated({this.messages});
  @override
  // TODO: implement props
  List<Object> get props => [messages];
}