# openapi.api.SellerApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *https://apps-jawa-backend.vercel.app*

Method | HTTP request | Description
------------- | ------------- | -------------
[**sellerProductsGet**](SellerApi.md#sellerproductsget) | **GET** /seller/products | Seller – list own products
[**sellerProductsPost**](SellerApi.md#sellerproductspost) | **POST** /seller/products | Seller – create product


# **sellerProductsGet**
> sellerProductsGet()

Seller – list own products

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getSellerApi();

try {
    api.sellerProductsGet();
} catch on DioException (e) {
    print('Exception when calling SellerApi->sellerProductsGet: $e\n');
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
> sellerProductsPost(productCreate)

Seller – create product

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getSellerApi();
final ProductCreate productCreate = ; // ProductCreate | 

try {
    api.sellerProductsPost(productCreate);
} catch on DioException (e) {
    print('Exception when calling SellerApi->sellerProductsPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **productCreate** | [**ProductCreate**](ProductCreate.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

