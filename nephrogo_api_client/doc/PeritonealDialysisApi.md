# nephrogo_api_client.api.PeritonealDialysisApi

## Load the API package
```dart
import 'package:nephrogo_api_client/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**peritonealDialysisAutomaticDialysisCreateCreate**](PeritonealDialysisApi.md#peritonealdialysisautomaticdialysiscreatecreate) | **POST** /v1/peritoneal-dialysis/automatic/dialysis/create/ | 
[**peritonealDialysisAutomaticDialysisDestroy**](PeritonealDialysisApi.md#peritonealdialysisautomaticdialysisdestroy) | **DELETE** /v1/peritoneal-dialysis/automatic/dialysis/{date}/ | 
[**peritonealDialysisAutomaticDialysisPartialUpdate**](PeritonealDialysisApi.md#peritonealdialysisautomaticdialysispartialupdate) | **PATCH** /v1/peritoneal-dialysis/automatic/dialysis/{date}/ | 
[**peritonealDialysisAutomaticDialysisUpdate**](PeritonealDialysisApi.md#peritonealdialysisautomaticdialysisupdate) | **PUT** /v1/peritoneal-dialysis/automatic/dialysis/{date}/ | 
[**peritonealDialysisAutomaticPeriodRetrieve**](PeritonealDialysisApi.md#peritonealdialysisautomaticperiodretrieve) | **GET** /v1/peritoneal-dialysis/automatic/period/ | 
[**peritonealDialysisAutomaticScreenRetrieve**](PeritonealDialysisApi.md#peritonealdialysisautomaticscreenretrieve) | **GET** /v1/peritoneal-dialysis/automatic/screen/ | 
[**peritonealDialysisManualDialysisCreateCreate**](PeritonealDialysisApi.md#peritonealdialysismanualdialysiscreatecreate) | **POST** /v1/peritoneal-dialysis/manual/dialysis/create/ | 
[**peritonealDialysisManualDialysisDestroy**](PeritonealDialysisApi.md#peritonealdialysismanualdialysisdestroy) | **DELETE** /v1/peritoneal-dialysis/manual/dialysis/{id}/ | 
[**peritonealDialysisManualDialysisPartialUpdate**](PeritonealDialysisApi.md#peritonealdialysismanualdialysispartialupdate) | **PATCH** /v1/peritoneal-dialysis/manual/dialysis/{id}/ | 
[**peritonealDialysisManualDialysisUpdate**](PeritonealDialysisApi.md#peritonealdialysismanualdialysisupdate) | **PUT** /v1/peritoneal-dialysis/manual/dialysis/{id}/ | 
[**peritonealDialysisManualScreenV2Retrieve**](PeritonealDialysisApi.md#peritonealdialysismanualscreenv2retrieve) | **GET** /v1/peritoneal-dialysis/manual/screen/v2/ | 


# **peritonealDialysisAutomaticDialysisCreateCreate**
> AutomaticPeritonealDialysis peritonealDialysisAutomaticDialysisCreateCreate(automaticPeritonealDialysisRequest)



### Example
```dart
import 'package:nephrogo_api_client/api.dart';
// TODO Configure API key authorization: cookieAuth
//defaultApiClient.getAuthentication<ApiKeyAuth>('cookieAuth').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('cookieAuth').apiKeyPrefix = 'Bearer';
// TODO Configure HTTP basic authorization: firebaseAuth
//defaultApiClient.getAuthentication<HttpBasicAuth>('firebaseAuth').username = 'YOUR_USERNAME'
//defaultApiClient.getAuthentication<HttpBasicAuth>('firebaseAuth').password = 'YOUR_PASSWORD';

final api = NephrogoApiClient().getPeritonealDialysisApi();
final AutomaticPeritonealDialysisRequest automaticPeritonealDialysisRequest = ; // AutomaticPeritonealDialysisRequest | 

try {
    final response = api.peritonealDialysisAutomaticDialysisCreateCreate(automaticPeritonealDialysisRequest);
    print(response);
} catch on DioError (e) {
    print('Exception when calling PeritonealDialysisApi->peritonealDialysisAutomaticDialysisCreateCreate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **automaticPeritonealDialysisRequest** | [**AutomaticPeritonealDialysisRequest**](AutomaticPeritonealDialysisRequest.md)|  | 

### Return type

[**AutomaticPeritonealDialysis**](AutomaticPeritonealDialysis.md)

### Authorization

[cookieAuth](../README.md#cookieAuth), [firebaseAuth](../README.md#firebaseAuth)

### HTTP request headers

 - **Content-Type**: application/json, application/x-www-form-urlencoded, multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **peritonealDialysisAutomaticDialysisDestroy**
> peritonealDialysisAutomaticDialysisDestroy(date)



### Example
```dart
import 'package:nephrogo_api_client/api.dart';
// TODO Configure API key authorization: cookieAuth
//defaultApiClient.getAuthentication<ApiKeyAuth>('cookieAuth').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('cookieAuth').apiKeyPrefix = 'Bearer';
// TODO Configure HTTP basic authorization: firebaseAuth
//defaultApiClient.getAuthentication<HttpBasicAuth>('firebaseAuth').username = 'YOUR_USERNAME'
//defaultApiClient.getAuthentication<HttpBasicAuth>('firebaseAuth').password = 'YOUR_PASSWORD';

final api = NephrogoApiClient().getPeritonealDialysisApi();
final Date date = 2013-10-20; // Date | 

try {
    api.peritonealDialysisAutomaticDialysisDestroy(date);
} catch on DioError (e) {
    print('Exception when calling PeritonealDialysisApi->peritonealDialysisAutomaticDialysisDestroy: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **date** | **Date**|  | 

### Return type

void (empty response body)

### Authorization

[cookieAuth](../README.md#cookieAuth), [firebaseAuth](../README.md#firebaseAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **peritonealDialysisAutomaticDialysisPartialUpdate**
> AutomaticPeritonealDialysis peritonealDialysisAutomaticDialysisPartialUpdate(date, automaticPeritonealDialysisRequest)



### Example
```dart
import 'package:nephrogo_api_client/api.dart';
// TODO Configure API key authorization: cookieAuth
//defaultApiClient.getAuthentication<ApiKeyAuth>('cookieAuth').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('cookieAuth').apiKeyPrefix = 'Bearer';
// TODO Configure HTTP basic authorization: firebaseAuth
//defaultApiClient.getAuthentication<HttpBasicAuth>('firebaseAuth').username = 'YOUR_USERNAME'
//defaultApiClient.getAuthentication<HttpBasicAuth>('firebaseAuth').password = 'YOUR_PASSWORD';

final api = NephrogoApiClient().getPeritonealDialysisApi();
final Date date = 2013-10-20; // Date | 
final AutomaticPeritonealDialysisRequest automaticPeritonealDialysisRequest = ; // AutomaticPeritonealDialysisRequest | 

try {
    final response = api.peritonealDialysisAutomaticDialysisPartialUpdate(date, automaticPeritonealDialysisRequest);
    print(response);
} catch on DioError (e) {
    print('Exception when calling PeritonealDialysisApi->peritonealDialysisAutomaticDialysisPartialUpdate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **date** | **Date**|  | 
 **automaticPeritonealDialysisRequest** | [**AutomaticPeritonealDialysisRequest**](AutomaticPeritonealDialysisRequest.md)|  | 

### Return type

[**AutomaticPeritonealDialysis**](AutomaticPeritonealDialysis.md)

### Authorization

[cookieAuth](../README.md#cookieAuth), [firebaseAuth](../README.md#firebaseAuth)

### HTTP request headers

 - **Content-Type**: application/json, application/x-www-form-urlencoded, multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **peritonealDialysisAutomaticDialysisUpdate**
> AutomaticPeritonealDialysis peritonealDialysisAutomaticDialysisUpdate(date, automaticPeritonealDialysisRequest)



### Example
```dart
import 'package:nephrogo_api_client/api.dart';
// TODO Configure API key authorization: cookieAuth
//defaultApiClient.getAuthentication<ApiKeyAuth>('cookieAuth').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('cookieAuth').apiKeyPrefix = 'Bearer';
// TODO Configure HTTP basic authorization: firebaseAuth
//defaultApiClient.getAuthentication<HttpBasicAuth>('firebaseAuth').username = 'YOUR_USERNAME'
//defaultApiClient.getAuthentication<HttpBasicAuth>('firebaseAuth').password = 'YOUR_PASSWORD';

final api = NephrogoApiClient().getPeritonealDialysisApi();
final Date date = 2013-10-20; // Date | 
final AutomaticPeritonealDialysisRequest automaticPeritonealDialysisRequest = ; // AutomaticPeritonealDialysisRequest | 

try {
    final response = api.peritonealDialysisAutomaticDialysisUpdate(date, automaticPeritonealDialysisRequest);
    print(response);
} catch on DioError (e) {
    print('Exception when calling PeritonealDialysisApi->peritonealDialysisAutomaticDialysisUpdate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **date** | **Date**|  | 
 **automaticPeritonealDialysisRequest** | [**AutomaticPeritonealDialysisRequest**](AutomaticPeritonealDialysisRequest.md)|  | 

### Return type

[**AutomaticPeritonealDialysis**](AutomaticPeritonealDialysis.md)

### Authorization

[cookieAuth](../README.md#cookieAuth), [firebaseAuth](../README.md#firebaseAuth)

### HTTP request headers

 - **Content-Type**: application/json, application/x-www-form-urlencoded, multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **peritonealDialysisAutomaticPeriodRetrieve**
> AutomaticPeritonealDialysisPeriodResponse peritonealDialysisAutomaticPeriodRetrieve(from, to)



### Example
```dart
import 'package:nephrogo_api_client/api.dart';
// TODO Configure API key authorization: cookieAuth
//defaultApiClient.getAuthentication<ApiKeyAuth>('cookieAuth').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('cookieAuth').apiKeyPrefix = 'Bearer';
// TODO Configure HTTP basic authorization: firebaseAuth
//defaultApiClient.getAuthentication<HttpBasicAuth>('firebaseAuth').username = 'YOUR_USERNAME'
//defaultApiClient.getAuthentication<HttpBasicAuth>('firebaseAuth').password = 'YOUR_PASSWORD';

final api = NephrogoApiClient().getPeritonealDialysisApi();
final Date from = 2013-10-20; // Date | 
final Date to = 2013-10-20; // Date | 

try {
    final response = api.peritonealDialysisAutomaticPeriodRetrieve(from, to);
    print(response);
} catch on DioError (e) {
    print('Exception when calling PeritonealDialysisApi->peritonealDialysisAutomaticPeriodRetrieve: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **from** | **Date**|  | 
 **to** | **Date**|  | 

### Return type

[**AutomaticPeritonealDialysisPeriodResponse**](AutomaticPeritonealDialysisPeriodResponse.md)

### Authorization

[cookieAuth](../README.md#cookieAuth), [firebaseAuth](../README.md#firebaseAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **peritonealDialysisAutomaticScreenRetrieve**
> AutomaticPeritonealDialysisScreenResponse peritonealDialysisAutomaticScreenRetrieve()



### Example
```dart
import 'package:nephrogo_api_client/api.dart';
// TODO Configure API key authorization: cookieAuth
//defaultApiClient.getAuthentication<ApiKeyAuth>('cookieAuth').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('cookieAuth').apiKeyPrefix = 'Bearer';
// TODO Configure HTTP basic authorization: firebaseAuth
//defaultApiClient.getAuthentication<HttpBasicAuth>('firebaseAuth').username = 'YOUR_USERNAME'
//defaultApiClient.getAuthentication<HttpBasicAuth>('firebaseAuth').password = 'YOUR_PASSWORD';

final api = NephrogoApiClient().getPeritonealDialysisApi();

try {
    final response = api.peritonealDialysisAutomaticScreenRetrieve();
    print(response);
} catch on DioError (e) {
    print('Exception when calling PeritonealDialysisApi->peritonealDialysisAutomaticScreenRetrieve: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**AutomaticPeritonealDialysisScreenResponse**](AutomaticPeritonealDialysisScreenResponse.md)

### Authorization

[cookieAuth](../README.md#cookieAuth), [firebaseAuth](../README.md#firebaseAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **peritonealDialysisManualDialysisCreateCreate**
> ManualPeritonealDialysis peritonealDialysisManualDialysisCreateCreate(manualPeritonealDialysisRequest)



### Example
```dart
import 'package:nephrogo_api_client/api.dart';
// TODO Configure API key authorization: cookieAuth
//defaultApiClient.getAuthentication<ApiKeyAuth>('cookieAuth').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('cookieAuth').apiKeyPrefix = 'Bearer';
// TODO Configure HTTP basic authorization: firebaseAuth
//defaultApiClient.getAuthentication<HttpBasicAuth>('firebaseAuth').username = 'YOUR_USERNAME'
//defaultApiClient.getAuthentication<HttpBasicAuth>('firebaseAuth').password = 'YOUR_PASSWORD';

final api = NephrogoApiClient().getPeritonealDialysisApi();
final ManualPeritonealDialysisRequest manualPeritonealDialysisRequest = ; // ManualPeritonealDialysisRequest | 

try {
    final response = api.peritonealDialysisManualDialysisCreateCreate(manualPeritonealDialysisRequest);
    print(response);
} catch on DioError (e) {
    print('Exception when calling PeritonealDialysisApi->peritonealDialysisManualDialysisCreateCreate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **manualPeritonealDialysisRequest** | [**ManualPeritonealDialysisRequest**](ManualPeritonealDialysisRequest.md)|  | 

### Return type

[**ManualPeritonealDialysis**](ManualPeritonealDialysis.md)

### Authorization

[cookieAuth](../README.md#cookieAuth), [firebaseAuth](../README.md#firebaseAuth)

### HTTP request headers

 - **Content-Type**: application/json, application/x-www-form-urlencoded, multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **peritonealDialysisManualDialysisDestroy**
> peritonealDialysisManualDialysisDestroy(id)



### Example
```dart
import 'package:nephrogo_api_client/api.dart';
// TODO Configure API key authorization: cookieAuth
//defaultApiClient.getAuthentication<ApiKeyAuth>('cookieAuth').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('cookieAuth').apiKeyPrefix = 'Bearer';
// TODO Configure HTTP basic authorization: firebaseAuth
//defaultApiClient.getAuthentication<HttpBasicAuth>('firebaseAuth').username = 'YOUR_USERNAME'
//defaultApiClient.getAuthentication<HttpBasicAuth>('firebaseAuth').password = 'YOUR_PASSWORD';

final api = NephrogoApiClient().getPeritonealDialysisApi();
final int id = 56; // int | 

try {
    api.peritonealDialysisManualDialysisDestroy(id);
} catch on DioError (e) {
    print('Exception when calling PeritonealDialysisApi->peritonealDialysisManualDialysisDestroy: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

void (empty response body)

### Authorization

[cookieAuth](../README.md#cookieAuth), [firebaseAuth](../README.md#firebaseAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **peritonealDialysisManualDialysisPartialUpdate**
> ManualPeritonealDialysis peritonealDialysisManualDialysisPartialUpdate(id, manualPeritonealDialysisRequest)



### Example
```dart
import 'package:nephrogo_api_client/api.dart';
// TODO Configure API key authorization: cookieAuth
//defaultApiClient.getAuthentication<ApiKeyAuth>('cookieAuth').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('cookieAuth').apiKeyPrefix = 'Bearer';
// TODO Configure HTTP basic authorization: firebaseAuth
//defaultApiClient.getAuthentication<HttpBasicAuth>('firebaseAuth').username = 'YOUR_USERNAME'
//defaultApiClient.getAuthentication<HttpBasicAuth>('firebaseAuth').password = 'YOUR_PASSWORD';

final api = NephrogoApiClient().getPeritonealDialysisApi();
final int id = 56; // int | 
final ManualPeritonealDialysisRequest manualPeritonealDialysisRequest = ; // ManualPeritonealDialysisRequest | 

try {
    final response = api.peritonealDialysisManualDialysisPartialUpdate(id, manualPeritonealDialysisRequest);
    print(response);
} catch on DioError (e) {
    print('Exception when calling PeritonealDialysisApi->peritonealDialysisManualDialysisPartialUpdate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **manualPeritonealDialysisRequest** | [**ManualPeritonealDialysisRequest**](ManualPeritonealDialysisRequest.md)|  | 

### Return type

[**ManualPeritonealDialysis**](ManualPeritonealDialysis.md)

### Authorization

[cookieAuth](../README.md#cookieAuth), [firebaseAuth](../README.md#firebaseAuth)

### HTTP request headers

 - **Content-Type**: application/json, application/x-www-form-urlencoded, multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **peritonealDialysisManualDialysisUpdate**
> ManualPeritonealDialysis peritonealDialysisManualDialysisUpdate(id, manualPeritonealDialysisRequest)



### Example
```dart
import 'package:nephrogo_api_client/api.dart';
// TODO Configure API key authorization: cookieAuth
//defaultApiClient.getAuthentication<ApiKeyAuth>('cookieAuth').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('cookieAuth').apiKeyPrefix = 'Bearer';
// TODO Configure HTTP basic authorization: firebaseAuth
//defaultApiClient.getAuthentication<HttpBasicAuth>('firebaseAuth').username = 'YOUR_USERNAME'
//defaultApiClient.getAuthentication<HttpBasicAuth>('firebaseAuth').password = 'YOUR_PASSWORD';

final api = NephrogoApiClient().getPeritonealDialysisApi();
final int id = 56; // int | 
final ManualPeritonealDialysisRequest manualPeritonealDialysisRequest = ; // ManualPeritonealDialysisRequest | 

try {
    final response = api.peritonealDialysisManualDialysisUpdate(id, manualPeritonealDialysisRequest);
    print(response);
} catch on DioError (e) {
    print('Exception when calling PeritonealDialysisApi->peritonealDialysisManualDialysisUpdate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **manualPeritonealDialysisRequest** | [**ManualPeritonealDialysisRequest**](ManualPeritonealDialysisRequest.md)|  | 

### Return type

[**ManualPeritonealDialysis**](ManualPeritonealDialysis.md)

### Authorization

[cookieAuth](../README.md#cookieAuth), [firebaseAuth](../README.md#firebaseAuth)

### HTTP request headers

 - **Content-Type**: application/json, application/x-www-form-urlencoded, multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **peritonealDialysisManualScreenV2Retrieve**
> ManualPeritonealDialysisScreenResponse peritonealDialysisManualScreenV2Retrieve()



### Example
```dart
import 'package:nephrogo_api_client/api.dart';
// TODO Configure API key authorization: cookieAuth
//defaultApiClient.getAuthentication<ApiKeyAuth>('cookieAuth').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('cookieAuth').apiKeyPrefix = 'Bearer';
// TODO Configure HTTP basic authorization: firebaseAuth
//defaultApiClient.getAuthentication<HttpBasicAuth>('firebaseAuth').username = 'YOUR_USERNAME'
//defaultApiClient.getAuthentication<HttpBasicAuth>('firebaseAuth').password = 'YOUR_PASSWORD';

final api = NephrogoApiClient().getPeritonealDialysisApi();

try {
    final response = api.peritonealDialysisManualScreenV2Retrieve();
    print(response);
} catch on DioError (e) {
    print('Exception when calling PeritonealDialysisApi->peritonealDialysisManualScreenV2Retrieve: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**ManualPeritonealDialysisScreenResponse**](ManualPeritonealDialysisScreenResponse.md)

### Authorization

[cookieAuth](../README.md#cookieAuth), [firebaseAuth](../README.md#firebaseAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

