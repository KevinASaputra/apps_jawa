import 'package:test/test.dart';
import 'package:openapi/openapi.dart';


/// tests for ProfileApi
void main() {
  final instance = Openapi().getProfileApi();

  group(ProfileApi, () {
    // Get family members
    //
    //Future profileFamilyGet() async
    test('test profileFamilyGet', () async {
      // TODO
    });

    // Add family member
    //
    //Future profileFamilyPost(FamilyMemberCreate familyMemberCreate) async
    test('test profileFamilyPost', () async {
      // TODO
    });

    // Get profile
    //
    //Future profileGet() async
    test('test profileGet', () async {
      // TODO
    });

    // Update profile
    //
    //Future profilePut(ProfileUpdate profileUpdate) async
    test('test profilePut', () async {
      // TODO
    });

    // Upgrade role (Buyer → Seller)
    //
    //Future rolePut(RoleUpdate roleUpdate) async
    test('test rolePut', () async {
      // TODO
    });

  });
}
