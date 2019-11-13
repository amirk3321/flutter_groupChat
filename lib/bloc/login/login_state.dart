import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class InitialLoginState extends LoginState {
  @override
  List<Object> get props => [];
}
class LoadingState extends LoginState {
  @override
  List<Object> get props => [];
}
class SuccessState extends LoginState {
  @override
  List<Object> get props => [];
}
class FailureState extends LoginState {
  @override
  List<Object> get props => [];
}

