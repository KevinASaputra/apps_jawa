# openapi.api.SellerProductsApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost:3000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**sellerProductsGet**](SellerProductsApi.md#sellerproductsget) | **GET** /seller/products | List produk milik seller
[**sellerProductsPost**](SellerProductsApi.md#sellerproductspost) | **POST** /seller/products | Tambah produk baru (Seller only)


# **sellerProductsGet**
> sellerProductsGet()

List produk milik seller

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getSellerProductsApi();

try {
    api.sellerProductsGet();
} catch on DioException (e) {
    print('Exception when calling SellerProductsApi->sellerProductsGet: $e\n');
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

# **sellerProductsPost**
> sellerProductsPost()

Tambah produk baru (Seller only)

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getSellerProductsApi();

try {
    api.sellerProductsPost();
} catch on DioException (e) {
    print('Exception when calling SellerProductsApi->sellerProductsPost: $e\n');
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

