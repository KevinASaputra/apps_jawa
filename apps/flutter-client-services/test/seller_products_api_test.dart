import 'package:test/test.dart';
import 'package:openapi/openapi.dart';


/// tests for SellerProductsApi
void main() {
  final instance = Openapi().getSellerProductsApi();

  group(SellerProductsApi, () {
    // List produk milik seller
    //
    //Future sellerProductsGet() async
    test('test sellerProductsGet', () async {
      // TODO
    });

    // Tambah produk baru (Seller only)
    //
    //Future sellerProductsPost() async
    test('test sellerProductsPost', () async {
      // TODO
    });

  });
}
