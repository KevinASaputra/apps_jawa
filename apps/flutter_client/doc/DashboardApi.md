# openapi.api.DashboardApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *https://apps-jawa-backend.vercel.app*

Method | HTTP request | Description
------------- | ------------- | -------------
[**adminDashboardGet**](DashboardApi.md#admindashboardget) | **GET** /admin/dashboard | Admin dashboard summary


# **adminDashboardGet**
> adminDashboardGet()

Admin dashboard summary

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getDashboardApi();

try {
    api.adminDashboardGet();
} catch on DioException (e) {
    print('Exception when calling DashboardApi->adminDashboardGet: $e\n');
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

