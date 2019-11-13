import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_group_chat/app_constent.dart';
import 'package:flutter_group_chat/model/text_message.dart';
import 'package:flutter_group_chat/repository/firebase_repository.dart';
import './bloc.dart';

class CommunicationBloc extends Bloc<CommunicationEvent, CommunicationState> {
  final FireRepository _repository;
  CommunicationBloc({FireRepository fireRepository}) : assert(fireRepository!=null) , _repository=fireRepository;
  @override
  CommunicationState get initialState => LoadingCommunication();

  @override
  Stream<CommunicationState> mapEventToState(
    CommunicationEvent event,
  ) async* {
    if (event is JoinChatRoom){
      yield* _mapOfJoinChatRoomToState();
    }else if (event is SendTextMessage){
      yield* _mapOfSendTextMessageToState(event);
    }else if (event is MessagesLoad){
      yield* _mapOfMessagesLoadToState();
    }else if (event is MessagesUpdated){
      yield* _mapOfMessagesUpdatedToState(event);
    }else if (event is SendImageMessage){
      yield* _mapOfSendImageMessageToState(event);
    }
  }

  Stream<CommunicationState> _mapOfJoinChatRoomToState() async*{
    await _repository.addStartCommunicationThroughChannelID();
  }

  Stream<CommunicationState> _mapOfSendTextMessageToState(SendTextMessage event) async*{
    await _repository.sendMessage(message: event.message);
  }

  Stream<CommunicationState> _mapOfMessagesLoadToState() async*{
    _repository.messages().listen((messages){
      add(MessagesUpdated(messages: messages));
    });
  }
  Stream<CommunicationState> _mapOfMessagesUpdatedToState(MessagesUpdated event) async*{
    yield LoadedCommunication(messages: event.messages);
  }

  Stream<CommunicationState> _mapOfSendImageMessageToState(SendImageMessage event) async*{
    _repository.uploadImages(imageFile: event.file,onComplete: (path){
      _repository.sendMessage(
        message: TextMessage(
          type: AppConst.image,
          time: Timestamp.now(),
          content: path,
          senderName:event.senderName,
          senderId: event.senderUid,
          recipientId: "",
          receiverName: "",
        )
      );
      return;
    });
  }


}
