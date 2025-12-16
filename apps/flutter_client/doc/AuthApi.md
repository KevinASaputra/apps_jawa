# openapi.api.AuthApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *https://apps-jawa-backend.vercel.app*

Method | HTTP request | Description
------------- | ------------- | -------------
[**authLoginPost**](AuthApi.md#authloginpost) | **POST** /auth/login | Login
[**authRegisterPost**](AuthApi.md#authregisterpost) | **POST** /auth/register | Register user


# **authLoginPost**
> authLoginPost(loginRequest)

Login

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getAuthApi();
final LoginRequest loginRequest = ; // LoginRequest | 

try {
    api.authLoginPost(loginRequest);
} catch on DioException (e) {
    print('Exception when calling AuthApi->authLoginPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **loginRequest** | [**LoginRequest**](LoginRequest.md)|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **authRegisterPost**
> authRegisterPost(registerRequest)

Register user

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getAuthApi();
final RegisterRequest registerRequest = ; // RegisterRequest | 

try {
    api.authRegisterPost(registerRequest);
} catch on DioException (e) {
    print('Exception when calling AuthApi->authRegisterPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **registerRequest** | [**RegisterRequest**](RegisterRequest.md)|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

