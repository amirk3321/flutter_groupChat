import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class SubmittedLoginFromEvent extends LoginEvent{
  final String email;
  final String password;
  SubmittedLoginFromEvent({this.email,this.password});
  @override
  List<Object> get props => [email,password];
}
class SubmittedRegistrationFromEvent extends LoginEvent{
  final String email;
  final String password;
  final String name;
  SubmittedRegistrationFromEvent({this.email,this.password,this.name});
  @override
  List<Object> get props => [email,password,name];
}