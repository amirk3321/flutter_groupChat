import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class UnInitialized extends AuthState {
  @override
  List<Object> get props => [];
}
class Authenticated extends AuthState{
  final String uid;
  Authenticated({this.uid});
  @override
  List<Object> get props => [uid];
}
class UnAuthenticated extends AuthState{
  @override
  List<Object> get props => [];
}

