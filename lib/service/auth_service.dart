import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_developer_assessment/src/generated/poi.pb.dart';
import 'package:flutter_developer_assessment/src/generated/poi.pbgrpc.dart';
import 'package:grpc/grpc.dart';
import 'package:flutter_developer_assessment/constant/application_constants.dart';

class AuthService {
  static AuthenticationClient? client;

  AuthService() {
    client = AuthenticationClient(ClientChannel(ApplicationConstants.API_URL,
        port: ApplicationConstants.API_PORT,
        options: const ChannelOptions(
          credentials: ChannelCredentials.insecure(),
        )));
  }
  Future<String> loginWithService(String username, String password) async {
    try {
      var authResponse = await client!.login(LoginRequest()
        ..username = username
        ..password = password);
      await FlutterSecureStorage().write(key: "jwt", value: authResponse.token);
      return authResponse.token;
    } catch (e) {
      print(e);
      return "";
    }
  }
}
