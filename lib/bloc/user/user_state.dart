import 'package:equatable/equatable.dart';
import 'package:flutter_group_chat/model/user.dart';

abstract class UserState extends Equatable {
  const UserState();
}

class UserLoading extends UserState {
  @override
  List<Object> get props => [];
}
class UserLoaded extends UserState{
  final List<User> users;
  UserLoaded({this.users});
  @override
  // TODO: implement props
  List<Object> get props => [users];
}

