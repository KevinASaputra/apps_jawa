import 'package:test/test.dart';
import 'package:openapi/openapi.dart';


/// tests for FinanceApi
void main() {
  final instance = Openapi().getFinanceApi();

  group(FinanceApi, () {
    // List finance records
    //
    //Future adminFinanceGet() async
    test('test adminFinanceGet', () async {
      // TODO
    });

    // Create finance record
    //
    //Future adminFinancePost(FinanceCreate financeCreate) async
    test('test adminFinancePost', () async {
      // TODO
    });

  });
}
