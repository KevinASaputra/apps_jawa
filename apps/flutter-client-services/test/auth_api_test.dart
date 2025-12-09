import 'package:test/test.dart';
import 'package:openapi/openapi.dart';


/// tests for AuthApi
void main() {
  final instance = Openapi().getAuthApi();

  group(AuthApi, () {
    // Login mendapatkan JWT
    //
    //Future authLoginPost() async
    test('test authLoginPost', () async {
      // TODO
    });

    // Register user baru
    //
    //Future authRegisterPost() async
    test('test authRegisterPost', () async {
      // TODO
    });

  });
}
