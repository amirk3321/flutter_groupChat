import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_group_chat/repository/firebase_repository.dart';
import './bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  FireRepository _repository;
  UserBloc({FireRepository fireRepository}) : assert(fireRepository!=null) , _repository=fireRepository;

  @override
  UserState get initialState => UserLoading();

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is UserLoad){
      yield* _mapOfUserLoad();
    }else if(event is UserUpdated){
      yield* _mapOfUserUpdated(event);
    }
  }

  Stream<UserState> _mapOfUserLoad() async*{
    _repository.fetchUsers().listen((users){
      add(UserUpdated(users: users));
    });
  }

  Stream<UserState> _mapOfUserUpdated(UserUpdated event) async*{
    yield UserLoaded(users: event.users);
  }

}
