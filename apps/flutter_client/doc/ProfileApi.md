# openapi.api.ProfileApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *https://apps-jawa-backend.vercel.app*

Method | HTTP request | Description
------------- | ------------- | -------------
[**profileFamilyGet**](ProfileApi.md#profilefamilyget) | **GET** /profile/family | Get family members
[**profileFamilyPost**](ProfileApi.md#profilefamilypost) | **POST** /profile/family | Add family member
[**profileGet**](ProfileApi.md#profileget) | **GET** /profile | Get profile
[**profilePut**](ProfileApi.md#profileput) | **PUT** /profile | Update profile
[**rolePut**](ProfileApi.md#roleput) | **PUT** /role | Upgrade role (Buyer → Seller)


# **profileFamilyGet**
> profileFamilyGet()

Get family members

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getProfileApi();

try {
    api.profileFamilyGet();
} catch on DioException (e) {
    print('Exception when calling ProfileApi->profileFamilyGet: $e\n');
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

# **profileFamilyPost**
> profileFamilyPost(familyMemberCreate)

Add family member

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getProfileApi();
final FamilyMemberCreate familyMemberCreate = ; // FamilyMemberCreate | 

try {
    api.profileFamilyPost(familyMemberCreate);
} catch on DioException (e) {
    print('Exception when calling ProfileApi->profileFamilyPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **familyMemberCreate** | [**FamilyMemberCreate**](FamilyMemberCreate.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **profileGet**
> profileGet()

Get profile

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
> profilePut(profileUpdate)

Update profile

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getProfileApi();
final ProfileUpdate profileUpdate = ; // ProfileUpdate | 

try {
    api.profilePut(profileUpdate);
} catch on DioException (e) {
    print('Exception when calling ProfileApi->profilePut: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **profileUpdate** | [**ProfileUpdate**](ProfileUpdate.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **rolePut**
> rolePut(roleUpdate)

Upgrade role (Buyer → Seller)

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getProfileApi();
final RoleUpdate roleUpdate = ; // RoleUpdate | 

try {
    api.rolePut(roleUpdate);
} catch on DioException (e) {
    print('Exception when calling ProfileApi->rolePut: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **roleUpdate** | [**RoleUpdate**](RoleUpdate.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

