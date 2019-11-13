import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_group_chat/repository/firebase_repository.dart';
import './bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FireRepository _repository;

  AuthBloc({FireRepository fireRepository})
      : assert(fireRepository != null),
        _repository = fireRepository;

  @override
  AuthState get initialState => UnInitialized();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AppStarted){
      yield* _mapOfAppStartedToState();
    }else if (event is LoggedInEvent){
      yield* _mapOfLoggedInEventToState();
    }else if (event is LoggedOutEvent){
      yield* _mapOfLoggedOutEventToState();
    }

  }

  Stream<AuthState> _mapOfAppStartedToState() async*{
    try{
      final bool isSignIn=await _repository.isSignIn();
      if (isSignIn)
      yield Authenticated(uid: await _repository.getCurrentUID());
    }catch(_){
      yield UnAuthenticated();
    }
  }

  Stream<AuthState> _mapOfLoggedInEventToState() async*{
    yield Authenticated(uid: await _repository.getCurrentUID());
  }

  Stream<AuthState> _mapOfLoggedOutEventToState() async*{
    yield UnAuthenticated();
  }
}
