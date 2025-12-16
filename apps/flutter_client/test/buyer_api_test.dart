import 'package:test/test.dart';
import 'package:openapi/openapi.dart';


/// tests for BuyerApi
void main() {
  final instance = Openapi().getBuyerApi();

  group(BuyerApi, () {
    // Add item to cart
    //
    //Future cartAddPost(CartAdd cartAdd) async
    test('test cartAddPost', () async {
      // TODO
    });

    // View cart
    //
    //Future cartGet() async
    test('test cartGet', () async {
      // TODO
    });

    // Checkout cart
    //
    //Future checkoutPost() async
    test('test checkoutPost', () async {
      // TODO
    });

  });
}
