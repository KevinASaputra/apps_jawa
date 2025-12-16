# openapi.api.BuyerApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *https://apps-jawa-backend.vercel.app*

Method | HTTP request | Description
------------- | ------------- | -------------
[**cartAddPost**](BuyerApi.md#cartaddpost) | **POST** /cart/add | Add item to cart
[**cartGet**](BuyerApi.md#cartget) | **GET** /cart | View cart
[**checkoutPost**](BuyerApi.md#checkoutpost) | **POST** /checkout | Checkout cart


# **cartAddPost**
> cartAddPost(cartAdd)

Add item to cart

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getBuyerApi();
final CartAdd cartAdd = ; // CartAdd | 

try {
    api.cartAddPost(cartAdd);
} catch on DioException (e) {
    print('Exception when calling BuyerApi->cartAddPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **cartAdd** | [**CartAdd**](CartAdd.md)|  | 

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

View cart

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getBuyerApi();

try {
    api.cartGet();
} catch on DioException (e) {
    print('Exception when calling BuyerApi->cartGet: $e\n');
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

# **checkoutPost**
> checkoutPost()

Checkout cart

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getBuyerApi();

try {
    api.checkoutPost();
} catch on DioException (e) {
    print('Exception when calling BuyerApi->checkoutPost: $e\n');
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

