# openapi.api.ProfileApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost:3000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**profileGet**](ProfileApi.md#profileget) | **GET** /profile | Ambil profil user
[**profilePut**](ProfileApi.md#profileput) | **PUT** /profile | Update profil user


# **profileGet**
> profileGet()

Ambil profil user

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getProfileApi();

try {
    api.profileGet();
} catch on DioException (e) {
    print('Exception when calling ProfileApi->profileGet: $e\n');
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

# **profilePut**
> profilePut()

Update profil user

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getProfileApi();

try {
    api.profilePut();
} catch on DioException (e) {
    print('Exception when calling ProfileApi->profilePut: $e\n');
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

