import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test12021summer_jiyeyu/session_cubit.dart';

class SessionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Hello'),
            TextButton(
              child: Text('sign out'),
              onPressed: () =>BlocProvider.of<SessionCubit>(context).signOut(),
            )
          ],
        )
      ),
    );
  }
}