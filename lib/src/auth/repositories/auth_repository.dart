import 'dart:async';

import 'package:greengrocer/src/auth/repositories/auth_errors.dart'
    as auth_Errors;
import 'package:greengrocer/src/auth/results/auth_result.dart';
import 'package:greengrocer/src/common/constants/endpoints.dart';
import 'package:greengrocer/src/profile/models/user_model.dart';
import 'package:greengrocer/src/services/http_manager.dart';

class AuthRepository {
  final HttpManager _httpManager = HttpManager();
  //
  Future<AuthResult> validateToken(String token) async {
    //
    final result = await _httpManager.restRequest(
        url: Endpoints.validateToken,
        method: HttpMethods.post,
        headers: {'X-Parse-Session-Token': token});

    return handleUserOrError(result);
  }

  AuthResult handleUserOrError(Map<dynamic, dynamic> result) {
    if (result['result'] != null) {
      final user = UserModel.fromMap(result['result']);
      return AuthResult.sucess(user);
    } else {
      return AuthResult.error(auth_Errors.authErrorsString(result['error']));
    }
  }

  Future<AuthResult> signUp(UserModel user) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.signup,
      method: HttpMethods.post,
      body: user.toMap(),
    );
    return handleUserOrError(result);
  }

  Future signIn({required String email, required String password}) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.signin,
      method: HttpMethods.post,
      body: {
        "email": email,
        "password": password,
      },
    );

    return handleUserOrError(result);
  }
}
