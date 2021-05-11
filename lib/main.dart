import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test12021summer_jiyeyu/app_navigator.dart';
import 'package:test12021summer_jiyeyu/auth/auth_repository.dart';
import 'package:test12021summer_jiyeyu/session_cubit.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RepositoryProvider
        (
        create: (context) => AuthRepository(),
        child: BlocProvider(
          create: (context) => SessionCubit(authRepo: context.read<AuthRepository>()),
          child: AppNavigator(),
        ),
      )
    );
  }
}