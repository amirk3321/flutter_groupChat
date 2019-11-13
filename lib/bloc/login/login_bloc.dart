import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_group_chat/repository/firebase_repository.dart';
import './bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final FireRepository _repository;

  LoginBloc({FireRepository fireRepository}) : assert(fireRepository!=null) , _repository=fireRepository;

  @override
  LoginState get initialState => InitialLoginState();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    yield LoadingState();
    if (event is SubmittedLoginFromEvent){
      yield* _mapOfSubmittedEventToState(event);
    }else if (event is SubmittedRegistrationFromEvent){
      yield* _mapOfSubmittedRegistrationFromEventToState(event);
    }
  }

  Stream<LoginState> _mapOfSubmittedEventToState(SubmittedLoginFromEvent event) async*{
    try{
      await _repository.signIn(email: event.email,password: event.password);
      yield SuccessState();
    }catch(_){
      yield FailureState();
    }
  }
  Stream<LoginState> _mapOfSubmittedRegistrationFromEventToState(
      SubmittedRegistrationFromEvent event) async* {
    try {
      await _repository.signUp(email: event.email, password: event.password);
      await _repository.getCreateCurrentUser(
        email: event.email,
        accessToken: '',
        profileUrl: '',
        isOnline: false,
        name: event.name,
      );
      yield SuccessState();
    } catch (_) {
      yield FailureState();
    }
  }
}
