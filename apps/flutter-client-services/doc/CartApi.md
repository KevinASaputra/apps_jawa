# openapi.api.CartApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost:3000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**cartAddPost**](CartApi.md#cartaddpost) | **POST** /cart/add | Tambah item ke cart
[**cartGet**](CartApi.md#cartget) | **GET** /cart | Lihat semua cart


# **cartAddPost**
> cartAddPost()

Tambah item ke cart

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getCartApi();

try {
    api.cartAddPost();
} catch on DioException (e) {
    print('Exception when calling CartApi->cartAddPost: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **cartGet**
> cartGet()

Lihat semua cart

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getCartApi();

try {
    api.cartGet();
} catch on DioException (e) {
    print('Exception when calling CartApi->cartGet: $e\n');
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
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

