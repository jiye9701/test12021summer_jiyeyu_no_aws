// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test12021summer_jiyeyu/auth/auth_cubit.dart';
import 'package:test12021summer_jiyeyu/auth/auth_repository.dart';
import 'package:test12021summer_jiyeyu/auth/form_submission_status.dart';
import 'package:test12021summer_jiyeyu/auth/login/login_bloc.dart';
import 'package:test12021summer_jiyeyu/auth/login/login_event.dart';
import 'package:test12021summer_jiyeyu/auth/login/login_state.dart';

class LoginView extends StatelessWidget
{
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider
        (
        create: (context) => LoginBloc(
          authRepo: context.read<AuthRepository>(),
          authCubit: context.read<AuthCubit>(),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            _loginForm(),
          _showSignUpButton(context)
          ],
        ),
      ),
    );
  }

  Widget _loginForm()
  {
    return BlocListener<LoginBloc, LoginState>
  (listener: (context, state)
    {
      final formStatus = state.formStatus;

      if
      (formStatus is SubmissionFailed)
      {
        _showSnackBar (context, formStatus.exception.toString());
      }
      },
  child: Form(
      key: _formKey,
      child: Padding(

        padding: EdgeInsets.symmetric(horizontal: 50),
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [_usernameField(),
            _passwordField(),
            _loginButton(),
          ],
        ),
      ),
    ),
  );
  }


  //User
  Widget _usernameField()
  {
    return BlocBuilder<LoginBloc, LoginState> (builder: (context, state)
    {
      return TextFormField
        (
        decoration: InputDecoration
          (
          icon: Icon(Icons.person),
          hintText: 'UserName',
        ),
        validator: (value) => state.isValidUsername ? null: 'Username is too short',
        onChanged: (value) => context.read<LoginBloc>().add(
          LoginUsernameChanged(username: value),
        ),
      );
    });
  }


  //PWD
  Widget _passwordField()
  {
    return BlocBuilder<LoginBloc, LoginState> (builder: (context, state)
    {
      return TextFormField
        (
        obscureText: true,
        decoration: InputDecoration
          (
          icon: Icon(Icons.security),
          hintText: 'Password',
        ),
        validator: (value) => state.isValidPassword ? null:'Password is too short',
        onChanged: (value) => context.read<LoginBloc>().add(
          LoginPasswordChanged(password: value),
        ),
      );
    });
  }

  //Login
  Widget _loginButton() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return state.formStatus is FormSubmitting
          ? CircularProgressIndicator()
          : ElevatedButton(

        onPressed: () {
          if (_formKey.currentState.validate())
            {
              context.read<LoginBloc>().add(LoginSubmitted());
            }
        },
        child: Text('Login'),
      );
    });
  }

  //SignUp

  Widget _showSignUpButton(BuildContext context)
  {
    return SafeArea(child: TextButton(
      child: Text('You do not have an account? Sign up.'),
      onPressed: () => context.read<AuthCubit>().showSignUp(),
    ),
    );
  }



  void _showSnackBar (BuildContext context, String message)
  {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}