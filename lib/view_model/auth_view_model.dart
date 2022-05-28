import 'package:flutter/foundation.dart';
import 'package:flutter_developer_assessment/service/auth_service.dart';

enum AuthState { IDLE, BUSY, ERROR }

class AuthViewModel with ChangeNotifier {
  late String token;
  late AuthState state;

  AuthViewModel() {
    state = AuthState.IDLE;
  }

  void authState(AuthState xstate) {
    state = xstate;
    notifyListeners();
  }

  updateToken(String token) {
    this.token = token;
    notifyListeners();
  }

  Future<void> loginWithViewModel(String username, String password) async {
    try {
      authState(AuthState.BUSY);
      token = await AuthService().loginWithService(username, password);
      authState(AuthState.IDLE);
    } catch (e) {
      authState(AuthState.ERROR);
    }
  }
}
