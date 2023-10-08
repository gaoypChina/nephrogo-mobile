# nephrogo_api_client.api.HealthStatusApi

## Load the API package
```dart
import 'package:nephrogo_api_client/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**healthStatusBloodPressureCreate**](HealthStatusApi.md#healthstatusbloodpressurecreate) | **POST** /v1/health-status/blood-pressure/ | 
[**healthStatusBloodPressureDestroy**](HealthStatusApi.md#healthstatusbloodpressuredestroy) | **DELETE** /v1/health-status/blood-pressure/{id}/ | 
[**healthStatusBloodPressurePartialUpdate**](HealthStatusApi.md#healthstatusbloodpressurepartialupdate) | **PATCH** /v1/health-status/blood-pressure/{id}/ | 
[**healthStatusBloodPressureUpdate**](HealthStatusApi.md#healthstatusbloodpressureupdate) | **PUT** /v1/health-status/blood-pressure/{id}/ | 
[**healthStatusCreate**](HealthStatusApi.md#healthstatuscreate) | **POST** /v1/health-status/ | 
[**healthStatusPartialUpdate**](HealthStatusApi.md#healthstatuspartialupdate) | **PATCH** /v1/health-status/ | 
[**healthStatusPulseCreate**](HealthStatusApi.md#healthstatuspulsecreate) | **POST** /v1/health-status/pulse/ | 
[**healthStatusPulseDestroy**](HealthStatusApi.md#healthstatuspulsedestroy) | **DELETE** /v1/health-status/pulse/{id}/ | 
[**healthStatusPulsePartialUpdate**](HealthStatusApi.md#healthstatuspulsepartialupdate) | **PATCH** /v1/health-status/pulse/{id}/ | 
[**healthStatusPulseUpdate**](HealthStatusApi.md#healthstatuspulseupdate) | **PUT** /v1/health-status/pulse/{id}/ | 
[**healthStatusRetrieve**](HealthStatusApi.md#healthstatusretrieve) | **GET** /v1/health-status/{date}/ | 
[**healthStatusScreenRetrieve**](HealthStatusApi.md#healthstatusscreenretrieve) | **GET** /v1/health-status/screen/ | 
[**healthStatusUpdate**](HealthStatusApi.md#healthstatusupdate) | **PUT** /v1/health-status/ | 
[**healthStatusWeeklyRetrieve**](HealthStatusApi.md#healthstatusweeklyretrieve) | **GET** /v1/health-status/weekly/ | 


# **healthStatusBloodPressureCreate**
> BloodPressure healthStatusBloodPressureCreate(bloodPressureRequest)



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

final api = NephrogoApiClient().getHealthStatusApi();
final BloodPressureRequest bloodPressureRequest = ; // BloodPressureRequest | 

try {
    final response = api.healthStatusBloodPressureCreate(bloodPressureRequest);
    print(response);
} catch on DioError (e) {
    print('Exception when calling HealthStatusApi->healthStatusBloodPressureCreate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **bloodPressureRequest** | [**BloodPressureRequest**](BloodPressureRequest.md)|  | 

### Return type

[**BloodPressure**](BloodPressure.md)

### Authorization

[cookieAuth](../README.md#cookieAuth), [firebaseAuth](../README.md#firebaseAuth)

### HTTP request headers

 - **Content-Type**: application/json, application/x-www-form-urlencoded, multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **healthStatusBloodPressureDestroy**
> healthStatusBloodPressureDestroy(id)



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

final api = NephrogoApiClient().getHealthStatusApi();
final int id = 56; // int | 

try {
    api.healthStatusBloodPressureDestroy(id);
} catch on DioError (e) {
    print('Exception when calling HealthStatusApi->healthStatusBloodPressureDestroy: $e\n');
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

# **healthStatusBloodPressurePartialUpdate**
> BloodPressure healthStatusBloodPressurePartialUpdate(id, bloodPressureRequest)



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

final api = NephrogoApiClient().getHealthStatusApi();
final int id = 56; // int | 
final BloodPressureRequest bloodPressureRequest = ; // BloodPressureRequest | 

try {
    final response = api.healthStatusBloodPressurePartialUpdate(id, bloodPressureRequest);
    print(response);
} catch on DioError (e) {
    print('Exception when calling HealthStatusApi->healthStatusBloodPressurePartialUpdate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **bloodPressureRequest** | [**BloodPressureRequest**](BloodPressureRequest.md)|  | 

### Return type

[**BloodPressure**](BloodPressure.md)

### Authorization

[cookieAuth](../README.md#cookieAuth), [firebaseAuth](../README.md#firebaseAuth)

### HTTP request headers

 - **Content-Type**: application/json, application/x-www-form-urlencoded, multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **healthStatusBloodPressureUpdate**
> BloodPressure healthStatusBloodPressureUpdate(id, bloodPressureRequest)



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

final api = NephrogoApiClient().getHealthStatusApi();
final int id = 56; // int | 
final BloodPressureRequest bloodPressureRequest = ; // BloodPressureRequest | 

try {
    final response = api.healthStatusBloodPressureUpdate(id, bloodPressureRequest);
    print(response);
} catch on DioError (e) {
    print('Exception when calling HealthStatusApi->healthStatusBloodPressureUpdate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **bloodPressureRequest** | [**BloodPressureRequest**](BloodPressureRequest.md)|  | 

### Return type

[**BloodPressure**](BloodPressure.md)

### Authorization

[cookieAuth](../README.md#cookieAuth), [firebaseAuth](../README.md#firebaseAuth)

### HTTP request headers

 - **Content-Type**: application/json, application/x-www-form-urlencoded, multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **healthStatusCreate**
> DailyHealthStatus healthStatusCreate(dailyHealthStatusRequest)



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

final api = NephrogoApiClient().getHealthStatusApi();
final DailyHealthStatusRequest dailyHealthStatusRequest = ; // DailyHealthStatusRequest | 

try {
    final response = api.healthStatusCreate(dailyHealthStatusRequest);
    print(response);
} catch on DioError (e) {
    print('Exception when calling HealthStatusApi->healthStatusCreate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **dailyHealthStatusRequest** | [**DailyHealthStatusRequest**](DailyHealthStatusRequest.md)|  | 

### Return type

[**DailyHealthStatus**](DailyHealthStatus.md)

### Authorization

[cookieAuth](../README.md#cookieAuth), [firebaseAuth](../README.md#firebaseAuth)

### HTTP request headers

 - **Content-Type**: application/json, application/x-www-form-urlencoded, multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **healthStatusPartialUpdate**
> DailyHealthStatus healthStatusPartialUpdate(dailyHealthStatusRequest)



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

final api = NephrogoApiClient().getHealthStatusApi();
final DailyHealthStatusRequest dailyHealthStatusRequest = ; // DailyHealthStatusRequest | 

try {
    final response = api.healthStatusPartialUpdate(dailyHealthStatusRequest);
    print(response);
} catch on DioError (e) {
    print('Exception when calling HealthStatusApi->healthStatusPartialUpdate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **dailyHealthStatusRequest** | [**DailyHealthStatusRequest**](DailyHealthStatusRequest.md)|  | 

### Return type

[**DailyHealthStatus**](DailyHealthStatus.md)

### Authorization

[cookieAuth](../README.md#cookieAuth), [firebaseAuth](../README.md#firebaseAuth)

### HTTP request headers

 - **Content-Type**: application/json, application/x-www-form-urlencoded, multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **healthStatusPulseCreate**
> Pulse healthStatusPulseCreate(pulseRequest)



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

final api = NephrogoApiClient().getHealthStatusApi();
final PulseRequest pulseRequest = ; // PulseRequest | 

try {
    final response = api.healthStatusPulseCreate(pulseRequest);
    print(response);
} catch on DioError (e) {
    print('Exception when calling HealthStatusApi->healthStatusPulseCreate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **pulseRequest** | [**PulseRequest**](PulseRequest.md)|  | 

### Return type

[**Pulse**](Pulse.md)

### Authorization

[cookieAuth](../README.md#cookieAuth), [firebaseAuth](../README.md#firebaseAuth)

### HTTP request headers

 - **Content-Type**: application/json, application/x-www-form-urlencoded, multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **healthStatusPulseDestroy**
> healthStatusPulseDestroy(id)



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

final api = NephrogoApiClient().getHealthStatusApi();
final int id = 56; // int | 

try {
    api.healthStatusPulseDestroy(id);
} catch on DioError (e) {
    print('Exception when calling HealthStatusApi->healthStatusPulseDestroy: $e\n');
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

# **healthStatusPulsePartialUpdate**
> Pulse healthStatusPulsePartialUpdate(id, pulseRequest)



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

final api = NephrogoApiClient().getHealthStatusApi();
final int id = 56; // int | 
final PulseRequest pulseRequest = ; // PulseRequest | 

try {
    final response = api.healthStatusPulsePartialUpdate(id, pulseRequest);
    print(response);
} catch on DioError (e) {
    print('Exception when calling HealthStatusApi->healthStatusPulsePartialUpdate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **pulseRequest** | [**PulseRequest**](PulseRequest.md)|  | 

### Return type

[**Pulse**](Pulse.md)

### Authorization

[cookieAuth](../README.md#cookieAuth), [firebaseAuth](../README.md#firebaseAuth)

### HTTP request headers

 - **Content-Type**: application/json, application/x-www-form-urlencoded, multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **healthStatusPulseUpdate**
> Pulse healthStatusPulseUpdate(id, pulseRequest)



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

final api = NephrogoApiClient().getHealthStatusApi();
final int id = 56; // int | 
final PulseRequest pulseRequest = ; // PulseRequest | 

try {
    final response = api.healthStatusPulseUpdate(id, pulseRequest);
    print(response);
} catch on DioError (e) {
    print('Exception when calling HealthStatusApi->healthStatusPulseUpdate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **pulseRequest** | [**PulseRequest**](PulseRequest.md)|  | 

### Return type

[**Pulse**](Pulse.md)

### Authorization

[cookieAuth](../README.md#cookieAuth), [firebaseAuth](../README.md#firebaseAuth)

### HTTP request headers

 - **Content-Type**: application/json, application/x-www-form-urlencoded, multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **healthStatusRetrieve**
> DailyHealthStatus healthStatusRetrieve(date)



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

final api = NephrogoApiClient().getHealthStatusApi();
final Date date = 2013-10-20; // Date | 

try {
    final response = api.healthStatusRetrieve(date);
    print(response);
} catch on DioError (e) {
    print('Exception when calling HealthStatusApi->healthStatusRetrieve: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **date** | **Date**|  | 

### Return type

[**DailyHealthStatus**](DailyHealthStatus.md)

### Authorization

[cookieAuth](../README.md#cookieAuth), [firebaseAuth](../README.md#firebaseAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **healthStatusScreenRetrieve**
> HealthStatusScreenResponse healthStatusScreenRetrieve()



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

final api = NephrogoApiClient().getHealthStatusApi();

try {
    final response = api.healthStatusScreenRetrieve();
    print(response);
} catch on DioError (e) {
    print('Exception when calling HealthStatusApi->healthStatusScreenRetrieve: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**HealthStatusScreenResponse**](HealthStatusScreenResponse.md)

### Authorization

[cookieAuth](../README.md#cookieAuth), [firebaseAuth](../README.md#firebaseAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **healthStatusUpdate**
> DailyHealthStatus healthStatusUpdate(dailyHealthStatusRequest)



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

final api = NephrogoApiClient().getHealthStatusApi();
final DailyHealthStatusRequest dailyHealthStatusRequest = ; // DailyHealthStatusRequest | 

try {
    final response = api.healthStatusUpdate(dailyHealthStatusRequest);
    print(response);
} catch on DioError (e) {
    print('Exception when calling HealthStatusApi->healthStatusUpdate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **dailyHealthStatusRequest** | [**DailyHealthStatusRequest**](DailyHealthStatusRequest.md)|  | 

### Return type

[**DailyHealthStatus**](DailyHealthStatus.md)

### Authorization

[cookieAuth](../README.md#cookieAuth), [firebaseAuth](../README.md#firebaseAuth)

### HTTP request headers

 - **Content-Type**: application/json, application/x-www-form-urlencoded, multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **healthStatusWeeklyRetrieve**
> HealthStatusWeeklyScreenResponse healthStatusWeeklyRetrieve(from, to)



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

final api = NephrogoApiClient().getHealthStatusApi();
final Date from = 2013-10-20; // Date | 
final Date to = 2013-10-20; // Date | 

try {
    final response = api.healthStatusWeeklyRetrieve(from, to);
    print(response);
} catch on DioError (e) {
    print('Exception when calling HealthStatusApi->healthStatusWeeklyRetrieve: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **from** | **Date**|  | 
 **to** | **Date**|  | 

### Return type

[**HealthStatusWeeklyScreenResponse**](HealthStatusWeeklyScreenResponse.md)

### Authorization

[cookieAuth](../README.md#cookieAuth), [firebaseAuth](../README.md#firebaseAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

