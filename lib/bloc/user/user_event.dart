import 'package:equatable/equatable.dart';
import 'package:flutter_group_chat/model/user.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class UserLoad extends UserEvent{
  @override
  // TODO: implement props
  List<Object> get props => [];
}
class UserUpdated extends UserEvent{
  final List<User> users;
  UserUpdated({this.users});
  @override
  // TODO: implement props
  List<Object> get props => [users];
}