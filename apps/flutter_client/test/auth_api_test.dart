import 'package:test/test.dart';
import 'package:openapi/openapi.dart';


/// tests for AuthApi
void main() {
  final instance = Openapi().getAuthApi();

  group(AuthApi, () {
    // Login
    //
    //Future authLoginPost(LoginRequest loginRequest) async
    test('test authLoginPost', () async {
      // TODO
    });

    // Register user
    //
    //Future authRegisterPost(RegisterRequest registerRequest) async
    test('test authRegisterPost', () async {
      // TODO
    });

  });
}
