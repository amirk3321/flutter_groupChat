import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_group_chat/bloc/auth/bloc.dart';
import 'package:flutter_group_chat/bloc/communication/communication_bloc.dart';
import 'package:flutter_group_chat/repository/firebase_repository.dart';
import 'package:flutter_group_chat/screen/home_screen.dart';
import 'package:flutter_group_chat/screen/login_screen.dart';
import 'package:bloc/bloc.dart';
import 'bloc/bloc_delegate.dart';
import 'bloc/login/bloc.dart';
import 'bloc/user/bloc.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(myApp());
}

class myApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => myAppState();
}

class myAppState extends State<myApp> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          builder: (_) =>
              AuthBloc(fireRepository: FireRepository())..add(AppStarted()),
        ),
        BlocProvider<LoginBloc>(
          builder: (_) => LoginBloc(fireRepository: FireRepository()),
        ),
        BlocProvider<UserBloc>(
          builder: (_) =>
              UserBloc(fireRepository: FireRepository())..add(UserLoad()),
        ),
        BlocProvider<CommunicationBloc>(
          builder: (_) => CommunicationBloc(fireRepository: FireRepository()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Flutter Demo",
        theme: ThemeData(primarySwatch: Colors.red),
        routes: {
          '/': (context) {
            return BlocBuilder<AuthBloc, AuthState>(
              builder: (BuildContext context, AuthState state) {
                if (state is Authenticated) {
                  return HomePage(
                    uid: state.uid,
                  );
                }
                if (state is UnAuthenticated) {
                  return LoginScreen();
                }

                return Scaffold(
                  body: Container(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Loading..."),
                          CircularProgressIndicator(),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
