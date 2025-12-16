# openapi.api.AdminApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *https://apps-jawa-backend.vercel.app*

Method | HTTP request | Description
------------- | ------------- | -------------
[**adminVerifyCitizenIdPost**](AdminApi.md#adminverifycitizenidpost) | **POST** /admin/verify/{citizenId} | Verify citizen (Head of family)


# **adminVerifyCitizenIdPost**
> adminVerifyCitizenIdPost(citizenId)

Verify citizen (Head of family)

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getAdminApi();
final int citizenId = 56; // int | 

try {
    api.adminVerifyCitizenIdPost(citizenId);
} catch on DioException (e) {
    print('Exception when calling AdminApi->adminVerifyCitizenIdPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **citizenId** | **int**|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

