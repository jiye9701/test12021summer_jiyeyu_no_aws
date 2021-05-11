import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test12021summer_jiyeyu/auth/auth_cubit.dart';
import 'package:test12021summer_jiyeyu/auth/auth_navigator.dart';
import 'package:test12021summer_jiyeyu/loading_view.dart';
import 'package:test12021summer_jiyeyu/session_cubit.dart';
import 'package:test12021summer_jiyeyu/session_state.dart';
import 'package:test12021summer_jiyeyu/session_view.dart';

class AppNavigator extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {

    return BlocBuilder<SessionCubit, SessionState>(builder: (context, state)
      {
    // TODO: implement build
    return Navigator(
      pages: [

        //Show loading screen
        if (state is UnknownSessionState)
          MaterialPage(child: LoadingView()),

        //Show auth flow
        if (state is Unauthenticated)
          MaterialPage (
            child: BlocProvider(
              //update
      create: (context) => AuthCubit(sessionCubit: context.read<SessionCubit>()),
      child: AuthNavigator(),
            ),
          ),

        //Show session flow

        if (state is Authenticated)
          MaterialPage(child: SessionView())

      ],
      onPopPage: (route, result) => route.didPop(result),
    );
});
}
}