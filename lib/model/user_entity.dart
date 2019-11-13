import 'package:cloud_firestore/cloud_firestore.dart';


class UserEntity{
  final String accessToken;
  final String name;
  final String email;
  final String profileUrl;
  final bool isOnline;
  final String uid;


  UserEntity(this.accessToken, this.name, this.email, this.profileUrl,
      this.isOnline,this.uid);


  UserEntity fromJson(Map<String,dynamic> json){
    return UserEntity(
      json['accessToken'] as String,
      json['name'] as String,
      json['email'] as String,
      json['profileUrl'] as String,
      json['isOnline'] as bool,
      json['uid'] as String,
    );
  }
  Map<String,dynamic> toMap() => {
    "accessToken" :accessToken,
    "name" :name,
    "email" :email,
    "profileUrl" :profileUrl,
    "isOnline" :isOnline,
  };


  static UserEntity fromSnapshot(DocumentSnapshot snapshot){
    return UserEntity(
      snapshot.data['accessToken'],
      snapshot.data['name'],
      snapshot.data['email'],
      snapshot.data['profileUrl'],
      snapshot.data['isOnline'],
      snapshot.data['uid'],
    );
  }

  Map<String,dynamic> toDocument() => {
    "accessToken" :accessToken,
    "name" :name,
    "email" :email,
    "profileUrl" :profileUrl,
    "isOnline" :isOnline,
    "uid" :uid,
  };
}