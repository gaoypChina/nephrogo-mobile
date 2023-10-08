# nephrogo_api_client.api.NutritionApi

## Load the API package
```dart
import 'package:nephrogo_api_client/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**nutritionDailyReportsLightRetrieve**](NutritionApi.md#nutritiondailyreportslightretrieve) | **GET** /v1/nutrition/daily-reports/light/ | 
[**nutritionDailyReportsRetrieve**](NutritionApi.md#nutritiondailyreportsretrieve) | **GET** /v1/nutrition/daily-reports/{date}/ | 
[**nutritionIntakeCreate**](NutritionApi.md#nutritionintakecreate) | **POST** /v1/nutrition/intake/ | 
[**nutritionIntakeDestroy**](NutritionApi.md#nutritionintakedestroy) | **DELETE** /v1/nutrition/intake/{id}/ | 
[**nutritionIntakePartialUpdate**](NutritionApi.md#nutritionintakepartialupdate) | **PATCH** /v1/nutrition/intake/{id}/ | 
[**nutritionIntakeRetrieve**](NutritionApi.md#nutritionintakeretrieve) | **GET** /v1/nutrition/intake/{id}/ | 
[**nutritionIntakeUpdate**](NutritionApi.md#nutritionintakeupdate) | **PUT** /v1/nutrition/intake/{id}/ | 
[**nutritionProductsMissingCreate**](NutritionApi.md#nutritionproductsmissingcreate) | **POST** /v1/nutrition/products/missing/ | 
[**nutritionProductsSearchRetrieve**](NutritionApi.md#nutritionproductssearchretrieve) | **GET** /v1/nutrition/products/search/ | 
[**nutritionScreenV2Retrieve**](NutritionApi.md#nutritionscreenv2retrieve) | **GET** /v1/nutrition/screen/v2/ | 
[**nutritionWeeklyRetrieve**](NutritionApi.md#nutritionweeklyretrieve) | **GET** /v1/nutrition/weekly/ | 


# **nutritionDailyReportsLightRetrieve**
> DailyIntakesReportsResponse nutritionDailyReportsLightRetrieve(from, to)



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

final api = NephrogoApiClient().getNutritionApi();
final Date from = 2013-10-20; // Date | 
final Date to = 2013-10-20; // Date | 

try {
    final response = api.nutritionDailyReportsLightRetrieve(from, to);
    print(response);
} catch on DioError (e) {
    print('Exception when calling NutritionApi->nutritionDailyReportsLightRetrieve: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **from** | **Date**|  | 
 **to** | **Date**|  | 

### Return type

[**DailyIntakesReportsResponse**](DailyIntakesReportsResponse.md)

### Authorization

[cookieAuth](../README.md#cookieAuth), [firebaseAuth](../README.md#firebaseAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **nutritionDailyReportsRetrieve**
> DailyIntakesReportResponse nutritionDailyReportsRetrieve(date)



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

final api = NephrogoApiClient().getNutritionApi();
final Date date = 2013-10-20; // Date | 

try {
    final response = api.nutritionDailyReportsRetrieve(date);
    print(response);
} catch on DioError (e) {
    print('Exception when calling NutritionApi->nutritionDailyReportsRetrieve: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **date** | **Date**|  | 

### Return type

[**DailyIntakesReportResponse**](DailyIntakesReportResponse.md)

### Authorization

[cookieAuth](../README.md#cookieAuth), [firebaseAuth](../README.md#firebaseAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **nutritionIntakeCreate**
> Intake nutritionIntakeCreate(intakeRequest)



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

final api = NephrogoApiClient().getNutritionApi();
final IntakeRequest intakeRequest = ; // IntakeRequest | 

try {
    final response = api.nutritionIntakeCreate(intakeRequest);
    print(response);
} catch on DioError (e) {
    print('Exception when calling NutritionApi->nutritionIntakeCreate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **intakeRequest** | [**IntakeRequest**](IntakeRequest.md)|  | 

### Return type

[**Intake**](Intake.md)

### Authorization

[cookieAuth](../README.md#cookieAuth), [firebaseAuth](../README.md#firebaseAuth)

### HTTP request headers

 - **Content-Type**: application/json, application/x-www-form-urlencoded, multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **nutritionIntakeDestroy**
> nutritionIntakeDestroy(id)



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

final api = NephrogoApiClient().getNutritionApi();
final int id = 56; // int | 

try {
    api.nutritionIntakeDestroy(id);
} catch on DioError (e) {
    print('Exception when calling NutritionApi->nutritionIntakeDestroy: $e\n');
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

# **nutritionIntakePartialUpdate**
> Intake nutritionIntakePartialUpdate(id, intakeRequest)



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

final api = NephrogoApiClient().getNutritionApi();
final int id = 56; // int | 
final IntakeRequest intakeRequest = ; // IntakeRequest | 

try {
    final response = api.nutritionIntakePartialUpdate(id, intakeRequest);
    print(response);
} catch on DioError (e) {
    print('Exception when calling NutritionApi->nutritionIntakePartialUpdate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **intakeRequest** | [**IntakeRequest**](IntakeRequest.md)|  | 

### Return type

[**Intake**](Intake.md)

### Authorization

[cookieAuth](../README.md#cookieAuth), [firebaseAuth](../README.md#firebaseAuth)

### HTTP request headers

 - **Content-Type**: application/json, application/x-www-form-urlencoded, multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **nutritionIntakeRetrieve**
> Intake nutritionIntakeRetrieve(id)



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

final api = NephrogoApiClient().getNutritionApi();
final int id = 56; // int | 

try {
    final response = api.nutritionIntakeRetrieve(id);
    print(response);
} catch on DioError (e) {
    print('Exception when calling NutritionApi->nutritionIntakeRetrieve: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**Intake**](Intake.md)

### Authorization

[cookieAuth](../README.md#cookieAuth), [firebaseAuth](../README.md#firebaseAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **nutritionIntakeUpdate**
> Intake nutritionIntakeUpdate(id, intakeRequest)



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

final api = NephrogoApiClient().getNutritionApi();
final int id = 56; // int | 
final IntakeRequest intakeRequest = ; // IntakeRequest | 

try {
    final response = api.nutritionIntakeUpdate(id, intakeRequest);
    print(response);
} catch on DioError (e) {
    print('Exception when calling NutritionApi->nutritionIntakeUpdate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **intakeRequest** | [**IntakeRequest**](IntakeRequest.md)|  | 

### Return type

[**Intake**](Intake.md)

### Authorization

[cookieAuth](../README.md#cookieAuth), [firebaseAuth](../README.md#firebaseAuth)

### HTTP request headers

 - **Content-Type**: application/json, application/x-www-form-urlencoded, multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **nutritionProductsMissingCreate**
> MissingProduct nutritionProductsMissingCreate(missingProductRequest)



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

final api = NephrogoApiClient().getNutritionApi();
final MissingProductRequest missingProductRequest = ; // MissingProductRequest | 

try {
    final response = api.nutritionProductsMissingCreate(missingProductRequest);
    print(response);
} catch on DioError (e) {
    print('Exception when calling NutritionApi->nutritionProductsMissingCreate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **missingProductRequest** | [**MissingProductRequest**](MissingProductRequest.md)|  | 

### Return type

[**MissingProduct**](MissingProduct.md)

### Authorization

[cookieAuth](../README.md#cookieAuth), [firebaseAuth](../README.md#firebaseAuth)

### HTTP request headers

 - **Content-Type**: application/json, application/x-www-form-urlencoded, multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **nutritionProductsSearchRetrieve**
> ProductSearchResponse nutritionProductsSearchRetrieve(excludeProducts, mealType, query, submit)



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

final api = NephrogoApiClient().getNutritionApi();
final String excludeProducts = excludeProducts_example; // String | 
final String mealType = mealType_example; // String | 
final String query = query_example; // String | 
final bool submit = true; // bool | 

try {
    final response = api.nutritionProductsSearchRetrieve(excludeProducts, mealType, query, submit);
    print(response);
} catch on DioError (e) {
    print('Exception when calling NutritionApi->nutritionProductsSearchRetrieve: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **excludeProducts** | **String**|  | [optional] 
 **mealType** | **String**|  | [optional] [default to 'Unknown']
 **query** | **String**|  | [optional] [default to '']
 **submit** | **bool**|  | [optional] 

### Return type

[**ProductSearchResponse**](ProductSearchResponse.md)

### Authorization

[cookieAuth](../README.md#cookieAuth), [firebaseAuth](../README.md#firebaseAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **nutritionScreenV2Retrieve**
> NutritionScreenV2Response nutritionScreenV2Retrieve()



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

final api = NephrogoApiClient().getNutritionApi();

try {
    final response = api.nutritionScreenV2Retrieve();
    print(response);
} catch on DioError (e) {
    print('Exception when calling NutritionApi->nutritionScreenV2Retrieve: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**NutritionScreenV2Response**](NutritionScreenV2Response.md)

### Authorization

[cookieAuth](../README.md#cookieAuth), [firebaseAuth](../README.md#firebaseAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **nutritionWeeklyRetrieve**
> NutrientWeeklyScreenResponse nutritionWeeklyRetrieve(from, to)



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

final api = NephrogoApiClient().getNutritionApi();
final Date from = 2013-10-20; // Date | 
final Date to = 2013-10-20; // Date | 

try {
    final response = api.nutritionWeeklyRetrieve(from, to);
    print(response);
} catch on DioError (e) {
    print('Exception when calling NutritionApi->nutritionWeeklyRetrieve: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **from** | **Date**|  | 
 **to** | **Date**|  | 

### Return type

[**NutrientWeeklyScreenResponse**](NutrientWeeklyScreenResponse.md)

### Authorization

[cookieAuth](../README.md#cookieAuth), [firebaseAuth](../README.md#firebaseAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

