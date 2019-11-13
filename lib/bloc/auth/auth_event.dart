import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class AppStarted extends AuthEvent{
  @override
  List<Object> get props => [];
}
class LoggedInEvent extends AuthEvent{
  @override
  // TODO: implement props
  List<Object> get props => [];
}
class LoggedOutEvent extends AuthEvent{
  @override
  // TODO: implement props
  List<Object> get props => [];
}
