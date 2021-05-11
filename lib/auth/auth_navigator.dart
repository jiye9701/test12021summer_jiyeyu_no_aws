import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test12021summer_jiyeyu/auth/auth_cubit.dart';
import 'package:test12021summer_jiyeyu/auth/confirm/confirmation_view.dart';
import 'package:test12021summer_jiyeyu/auth/login/login_view.dart';
import 'package:test12021summer_jiyeyu/auth/sign_up/sign_up_view.dart';

class AuthNavigator extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
      return Navigator(
        pages: [

          //Show login
          if (state == AuthState.login) MaterialPage(child: LoginView()),

          //Allow push animation
          if (state == AuthState.signUp ||
              state == AuthState.confirmSignUp)...[

                MaterialPage(child: SignUpView()),

            //Show confirm sign up
            if (state ==AuthState.confirmSignUp)
              MaterialPage(child: ConfirmationView())
          ]
        ],
        onPopPage: (route, result) => route.didPop(result),
      );
    });
  }
}