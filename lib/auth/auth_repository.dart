import 'package:flutter/cupertino.dart';

class AuthRepository
{
  Future<String> attemptAutoLogin() async
  {
    await Future.delayed(Duration(seconds: 1));
    throw Exception( ('not signed in'));
  }

  Future login({
    @required String username,
    @required String password,
}) async
  {
    print('attempting login');

    //3초동안 동그라미 로그인중..이라는 느낌
    await Future.delayed(Duration(seconds: 3));
    return 'abc';

    // print('logged in');
    // throw Exception('failed log in');
  }
//1
  Future signUp({

    @required String username,
    @required String email,
    @required String password,

}) async{
    await Future.delayed(Duration(seconds: 2));
  }
//2
  Future confirmSingUp({

    @required String username,
    @required String confirmationCode,

  }) async{
    await Future.delayed(Duration(seconds: 2));
    return 'abc';

  }

  Future<void> signOut() async{
    await Future.delayed((Duration(seconds: 2)));
  }

}