import 'package:firebase_login_flutter/authentication_bloc/authentication_bloc.dart';
import 'package:firebase_login_flutter/home_screen.dart';
import 'package:firebase_login_flutter/repositories/user_repository.dart';
import 'package:firebase_login_flutter/simple_bloc_observer.dart';
import 'package:firebase_login_flutter/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  final UserRepository userRepository = UserRepository();
  runApp(BlocProvider(
    create: (BuildContext context) {
      AuthenticationBloc(userRepository: userRepository)
        ..add(AuthenticationStarted());
    },
  ));
}

class App extends StatelessWidget {
  final UserRepository _userRepository;

  App({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if(state is AuthenticationInitial){
              return SplashScreen();
            }

            if(state is AuthenticationSuccess){
              return HomeScreen(name: state.displayName);
            }

            return Container();
      }),
    );
  }
}
