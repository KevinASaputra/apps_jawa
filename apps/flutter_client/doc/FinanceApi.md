# openapi.api.FinanceApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *https://apps-jawa-backend.vercel.app*

Method | HTTP request | Description
------------- | ------------- | -------------
[**adminFinanceGet**](FinanceApi.md#adminfinanceget) | **GET** /admin/finance | List finance records
[**adminFinancePost**](FinanceApi.md#adminfinancepost) | **POST** /admin/finance | Create finance record


# **adminFinanceGet**
> adminFinanceGet()

List finance records

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getFinanceApi();

try {
    api.adminFinanceGet();
} catch on DioException (e) {
    print('Exception when calling FinanceApi->adminFinanceGet: $e\n');
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

# **adminFinancePost**
> adminFinancePost(financeCreate)

Create finance record

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getFinanceApi();
final FinanceCreate financeCreate = ; // FinanceCreate | 

try {
    api.adminFinancePost(financeCreate);
} catch on DioException (e) {
    print('Exception when calling FinanceApi->adminFinancePost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **financeCreate** | [**FinanceCreate**](FinanceCreate.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

