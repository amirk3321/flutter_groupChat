
import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter_group_chat/model/user_entity.dart';

class User extends Equatable{
  final String accessToken;
  final String name;
  final String email;
  final String profileUrl;
  final bool isOnline;
  final String uid;

  const User({
    this.accessToken='',
    this.name='',
    this.email='',
    this.profileUrl='',
    this.isOnline=false,
    this.uid='',
  });

  @override
  List<Object> get props => [accessToken,name,email,profileUrl,isOnline,uid];


  UserEntity toEntity() =>
      UserEntity(accessToken,name,email,profileUrl,isOnline,uid);

  User fromEntity(UserEntity entity){
    return User(
      accessToken: entity.accessToken,
      name: entity.name,
      email: entity.email,
      profileUrl: entity.profileUrl,
      isOnline: entity.isOnline,
      uid: entity.uid,
    );
  }
}