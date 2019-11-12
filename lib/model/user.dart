
import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter_group_chat/model/user_entity.dart';

class User extends Equatable{
  final String accessToken;
  final String name;
  final String email;
  final String profileUrl;
  final bool isOnline;

  const User({
    this.accessToken='',
    this.name='',
    this.email='',
    this.profileUrl='',
    this.isOnline=false,
  });

  @override
  List<Object> get props => [accessToken,name,email,profileUrl,isOnline];

  @override
  String toString() {
    return 'User{accessToken: $accessToken, name: $name, email: $email, profileUrl: $profileUrl, isOnline: $isOnline}';
  }

  UserEntity toEntity() =>
      UserEntity(accessToken,name,email,profileUrl,isOnline);

  User fromEntity(UserEntity entity){
    return User(
      accessToken: entity.accessToken,
      name: entity.name,
      email: entity.email,
      profileUrl: entity.profileUrl,
      isOnline: entity.isOnline,
    );
  }
}