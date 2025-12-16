# openapi.api.ActivitiesApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *https://apps-jawa-backend.vercel.app*

Method | HTTP request | Description
------------- | ------------- | -------------
[**adminActivitiesGet**](ActivitiesApi.md#adminactivitiesget) | **GET** /admin/activities | List activities
[**adminActivitiesPost**](ActivitiesApi.md#adminactivitiespost) | **POST** /admin/activities | Create activity


# **adminActivitiesGet**
> adminActivitiesGet()

List activities

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getActivitiesApi();

try {
    api.adminActivitiesGet();
} catch on DioException (e) {
    print('Exception when calling ActivitiesApi->adminActivitiesGet: $e\n');
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

# **adminActivitiesPost**
> adminActivitiesPost(activityCreate)

Create activity

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getActivitiesApi();
final ActivityCreate activityCreate = ; // ActivityCreate | 

try {
    api.adminActivitiesPost(activityCreate);
} catch on DioException (e) {
    print('Exception when calling ActivitiesApi->adminActivitiesPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **activityCreate** | [**ActivityCreate**](ActivityCreate.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

