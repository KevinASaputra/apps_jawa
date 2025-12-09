# openapi.api.RoleApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost:3000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**rolePut**](RoleApi.md#roleput) | **PUT** /role | Rubah role menjadi Buyer / Seller


# **rolePut**
> rolePut()

Rubah role menjadi Buyer / Seller

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getRoleApi();

try {
    api.rolePut();
} catch on DioException (e) {
    print('Exception when calling RoleApi->rolePut: $e\n');
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

