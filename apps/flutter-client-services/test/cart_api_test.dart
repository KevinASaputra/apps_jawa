import 'package:test/test.dart';
import 'package:openapi/openapi.dart';


/// tests for CartApi
void main() {
  final instance = Openapi().getCartApi();

  group(CartApi, () {
    // Tambah item ke cart
    //
    //Future cartAddPost() async
    test('test cartAddPost', () async {
      // TODO
    });

    // Lihat semua cart
    //
    //Future cartGet() async
    test('test cartGet', () async {
      // TODO
    });

  });
}
