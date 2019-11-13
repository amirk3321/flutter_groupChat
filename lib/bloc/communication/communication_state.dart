import 'package:equatable/equatable.dart';
import 'package:flutter_group_chat/model/text_message.dart';

abstract class CommunicationState extends Equatable {
  const CommunicationState();
}

class LoadingCommunication extends CommunicationState {
  @override
  List<Object> get props => [];
}
class LoadedCommunication extends CommunicationState {
  final List<TextMessage> messages;
  LoadedCommunication({this.messages});
  @override
  List<Object> get props => [messages];
}
