import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test12021summer_jiyeyu/auth/auth_cubit.dart';
import 'package:test12021summer_jiyeyu/auth/auth_repository.dart';
import 'package:test12021summer_jiyeyu/auth/form_submission_status.dart';
import 'package:test12021summer_jiyeyu/auth/sign_up/sign_up_bloc.dart';
import 'package:test12021summer_jiyeyu/auth/sign_up/sign_up_event.dart';
import 'package:test12021summer_jiyeyu/auth/sign_up/sign_up_state.dart';

class SignUpView extends StatelessWidget
{
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider
        (
        create: (context) => SignUpBloc(
          authRepo: context.read<AuthRepository>(),
          authCubit: context.read<AuthCubit>(),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            _signUpForm(),
          _showLoginButton(context)
          ],
        ),
      ),
    );
  }

  Widget _signUpForm()
  {
    return BlocListener<SignUpBloc, SignUpState>
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
            _emailField(),
            _passwordField(),
            _signUpButton(),
          ],
        ),
      ),
    ),
  );
  }


  //User
  Widget _usernameField()
  {
    return BlocBuilder<SignUpBloc, SignUpState> (builder: (context, state)
    {
      return TextFormField
        (
        decoration: InputDecoration
          (
          icon: Icon(Icons.person),
          hintText: 'UserName',
        ),
        validator: (value) => state.isValidUsername ? null: 'Username is too short',
        onChanged: (value) => context.read<SignUpBloc>().add(
          SignUpUsernameChanged(username: value),
        ),
      );
    });
  }

  //Email
  Widget _emailField()
  {
    return BlocBuilder<SignUpBloc, SignUpState> (builder: (context, state)
    {
      return TextFormField
        (
        decoration: InputDecoration
          (
          icon: Icon(Icons.person),
          hintText: 'Email',
        ),
        //user
        validator: (value) => state.isValidEmail ? null: 'Invalid email',
        onChanged: (value) => context.read<SignUpBloc>().add(
          SignUpEmailChanged(email: value),
        ),
      );
    });
  }

  //PWD
  Widget _passwordField()
  {
    return BlocBuilder<SignUpBloc, SignUpState> (builder: (context, state)
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
        onChanged: (value) => context.read<SignUpBloc>().add(
          SignUpPasswordChanged(password: value),
        ),
      );
    });
  }

  //SignUp
  Widget _signUpButton() {
    return BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
      return state.formStatus is FormSubmitting
          ? CircularProgressIndicator()
          : ElevatedButton(

        onPressed: () {
          if (_formKey.currentState.validate())
            {
              context.read<SignUpBloc>().add(SignUpSubmitted());
            }
        },
        child: Text('SignUp'),
      );
    });
  }

  //Login

  Widget _showLoginButton(BuildContext context)
  {
    return SafeArea(child: TextButton(
      child: Text('Already have an account? Sign in.'),
        onPressed: () => context.read<AuthCubit>().showLogin(),
    ),
    );
  }



  void _showSnackBar (BuildContext context, String message)
  {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}