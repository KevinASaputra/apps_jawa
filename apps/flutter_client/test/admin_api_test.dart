import 'package:test/test.dart';
import 'package:openapi/openapi.dart';


/// tests for AdminApi
void main() {
  final instance = Openapi().getAdminApi();

  group(AdminApi, () {
    // Verify citizen (Head of family)
    //
    //Future adminVerifyCitizenIdPost(int citizenId) async
    test('test adminVerifyCitizenIdPost', () async {
      // TODO
    });

  });
}
