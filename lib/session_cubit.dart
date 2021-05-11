import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test12021summer_jiyeyu/auth/auth_credentials.dart';
import 'package:test12021summer_jiyeyu/auth/auth_repository.dart';
import 'package:test12021summer_jiyeyu/session_state.dart';

class SessionCubit extends Cubit<SessionState>
{
  final AuthRepository authRepo;

  SessionCubit({this.authRepo}): super (UnknownSessionState())
  {
    attemptAutoLogin();
  }

  void attemptAutoLogin() async
  {
    try {
      final userId = await authRepo.attemptAutoLogin();
      //final user = dataRepo.getUser(userId); --later

      final user = userId;
      emit(Authenticated(user: user));
    }
    on Exception {
      emit(Unauthenticated());
    }
  }

  void showAuth() => emit (Unauthenticated());
  void showSession (AuthCredentials credentials)
  {
    // final user = dataRep.getUser(credentials.userId); --later
    final user = credentials.username;
    emit (Authenticated(user: user));
  }

  void signOut(){
    authRepo.signOut();
    emit(Unauthenticated());

  }
}