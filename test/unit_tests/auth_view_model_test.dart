import 'package:flutter_developer_assessment/view_model/auth_view_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('update-token', () {
    AuthViewModel authViewModel = AuthViewModel();
    String token = "random-string";

    //Updating token feature of AuthViewModel class
    authViewModel.updateToken(token);
    //Expecting there has to be a string inside the AuthViewModel.token
    expect(authViewModel.token.isNotEmpty, true);
  });

  test('login-with-view-model', () async {
    AuthViewModel authViewModel = AuthViewModel();
    String username = "string";
    String password = "string";

    //Trying with incorrect credentials
    await authViewModel.loginWithViewModel(username, password);
    //Expecting there has not to be a string inside the AuthViewModel.token
    expect(authViewModel.token.isEmpty, true);

    //------IF YOU WANT TO LOGIN WITH CORRECT CREDENTIALS AND TEST IT;

    /*
    username = "ENTER_CORRECT_USERNAME";
    password = "ENTER_CORRECT_PASSWORD";
    //Trying with correct credentials
    await authViewModel.loginWithViewModel(username, password);
    //Expecting there has to be a string inside the AuthViewModel.token
    expect(authViewModel.token.isNotEmpty, true);
    */
  });
}
