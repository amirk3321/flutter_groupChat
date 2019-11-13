
import 'package:flutter_group_chat/model/text_message.dart';
import 'package:flutter_group_chat/model/user.dart';

abstract class RapoBase{
  Future<void> signUp({String email, String password});
  Future<void> signIn({String email, String password});
  Future<bool> isSignIn();
  Future<String> getCurrentUID();
  Future<void> getCreateCurrentUser({
  String name,String accessToken,String email,String profileUrl,bool isOnline});
  Stream<List<User>> fetchUsers();
  Future<void> addStartCommunicationThroughChannelID();
  Future<void> sendMessage({TextMessage message});
  Stream<List<TextMessage>> messages();
}