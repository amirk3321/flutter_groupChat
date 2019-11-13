import 'package:bloc/bloc.dart';

class SimpleBlocDelegate extends BlocDelegate{

  @override
  void onEvent(Bloc bloc, Object event) {
    print(event.toString());
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition.toString());
  }
}