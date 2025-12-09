import 'package:test/test.dart';
import 'package:openapi/openapi.dart';


/// tests for ProductsApi
void main() {
  final instance = Openapi().getProductsApi();

  group(ProductsApi, () {
    // List semua produk publik
    //
    //Future productsGet() async
    test('test productsGet', () async {
      // TODO
    });

  });
}
