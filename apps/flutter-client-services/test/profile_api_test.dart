import 'package:test/test.dart';
import 'package:openapi/openapi.dart';


/// tests for ProfileApi
void main() {
  final instance = Openapi().getProfileApi();

  group(ProfileApi, () {
    // Ambil profil user
    //
    //Future profileGet() async
    test('test profileGet', () async {
      // TODO
    });

    // Update profil user
    //
    //Future profilePut() async
    test('test profilePut', () async {
      // TODO
    });

  });
}
