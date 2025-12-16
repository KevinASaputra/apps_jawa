import 'package:test/test.dart';
import 'package:openapi/openapi.dart';


/// tests for SellerApi
void main() {
  final instance = Openapi().getSellerApi();

  group(SellerApi, () {
    // Seller – list own products
    //
    //Future sellerProductsGet() async
    test('test sellerProductsGet', () async {
      // TODO
    });

    // Seller – create product
    //
    //Future sellerProductsPost(ProductCreate productCreate) async
    test('test sellerProductsPost', () async {
      // TODO
    });

  });
}
