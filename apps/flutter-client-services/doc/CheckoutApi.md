# openapi.api.CheckoutApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost:3000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**checkoutPost**](CheckoutApi.md#checkoutpost) | **POST** /checkout | Checkout cart user


# **checkoutPost**
> checkoutPost()

Checkout cart user

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getCheckoutApi();

try {
    api.checkoutPost();
} catch on DioException (e) {
    print('Exception when calling CheckoutApi->checkoutPost: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

