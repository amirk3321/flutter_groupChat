import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_group_chat/model/text_message.dart';
import 'package:flutter_group_chat/model/text_message_entity.dart';
import 'package:flutter_group_chat/model/user.dart';
import 'package:flutter_group_chat/model/user_entity.dart';
import 'package:flutter_group_chat/repository/rapo_base.dart';

class FireRepository extends RapoBase {
  //auth functionality

  //instance of auth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //firestore instance
  final _userCollection = Firestore.instance.collection("user");

  //groupChat Collection instance
  final _groupChatCollection = Firestore.instance.collection("groupChat");

  //channelID all user communicate with each other through this Id.
  final String _channelID = "qPYMUExYWUHJYET7qBUT";

  //Cloud FireStore Instance to accessing storage bucket
  static final _storage=FirebaseStorage.instance;
  final _storageRef=_storage.ref().child("images");
  @override
  Future<void> signUp({String email, String password}) async => await _auth
      .createUserWithEmailAndPassword(email: email, password: password);

  @override
  Future<void> signIn({String email, String password}) async =>
      await _auth.signInWithEmailAndPassword(email: email, password: password);

  @override
  Future<bool> isSignIn() async => (await _auth.currentUser()).uid != null;

  @override
  Future<String> getCurrentUID() async => (await _auth.currentUser()).uid;

  //FireBase Database
  //1st time user id created

  @override
  Future<void> getCreateCurrentUser(
      {String name,
      String accessToken,
      String email,
      String profileUrl,
      bool isOnline}) async {
    _userCollection
        .document((await _auth.currentUser()).uid)
        .get()
        .then((user) async {
      if (!user.exists) {
        _userCollection.document((await _auth.currentUser()).uid).setData(User(
                name: name,
                email: email,
                profileUrl: profileUrl,
                accessToken: accessToken,
                uid: (await _auth.currentUser()).uid,
                isOnline: false)
            .toEntity()
            .toDocument());
        return;
      } else
        print("userAlread Exists");
      return;
    });
  }

  @override
  Stream<List<User>> fetchUsers() {
    return _userCollection.snapshots().map(
          (snapshot) => snapshot.documents
              .map((docSnapshot) =>
                  User().fromEntity(UserEntity.fromSnapshot(docSnapshot)))
              .toList(),
        );
  }

  //if channelId is not exists then add
  @override
  Future<void> addStartCommunicationThroughChannelID() async {
    _userCollection
        .document((await _auth.currentUser()).uid)
        .collection("engageGroupChannel")
        .document(_channelID)
        .get()
          ..then((communication) async {
            if (communication.exists) {
              return;
            }
            await _userCollection
                .document((await _auth.currentUser()).uid)
                .collection("engageGroupChannel")
                .document(_channelID)
                .setData({"channelId": _channelID});
            return;
          });
  }

  @override
  Future<void> sendMessage({TextMessage message}) async {
    await _groupChatCollection
        .document(_channelID)
        .collection("messages")
        .add(message.toEntity().toDocument());
  }
  @override
  Stream<List<TextMessage>> messages() {
    return _groupChatCollection
        .document(_channelID)
        .collection("messages")
        .orderBy('time')
        .snapshots()
        .map((snapshot) => snapshot.documents
            .map((docSnapshot) => TextMessage.fromEntity(
                TextMessageEntity.fromSnapshot(docSnapshot)))
            .toList());
  }

  //FireStorage
  //upload image
  Future<void> uploadImages({File imageFile,Function onComplete(String path)})async{
    final ref=_storage.ref().child("images/${DateTime.now().millisecondsSinceEpoch}.png");
    ref.putFile(imageFile).onComplete.then((image)async{
      final path=await ref.getDownloadURL();
      print("imageFileTest ${path.toString()}");
      onComplete(path);
    });
  }
}
