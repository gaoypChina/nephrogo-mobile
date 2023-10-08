# nephrogo_api_client.api.GeneralRecommendationsApi

## Load the API package
```dart
import 'package:nephrogo_api_client/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**generalRecommendationsReadCreate**](GeneralRecommendationsApi.md#generalrecommendationsreadcreate) | **POST** /v1/general-recommendations/read/ | 
[**generalRecommendationsV2Retrieve**](GeneralRecommendationsApi.md#generalrecommendationsv2retrieve) | **GET** /v1/general-recommendations/v2/ | 


# **generalRecommendationsReadCreate**
> CreateGeneralRecommendationRead generalRecommendationsReadCreate(createGeneralRecommendationReadRequest)



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

final api = NephrogoApiClient().getGeneralRecommendationsApi();
final CreateGeneralRecommendationReadRequest createGeneralRecommendationReadRequest = ; // CreateGeneralRecommendationReadRequest | 

try {
    final response = api.generalRecommendationsReadCreate(createGeneralRecommendationReadRequest);
    print(response);
} catch on DioError (e) {
    print('Exception when calling GeneralRecommendationsApi->generalRecommendationsReadCreate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createGeneralRecommendationReadRequest** | [**CreateGeneralRecommendationReadRequest**](CreateGeneralRecommendationReadRequest.md)|  | 

### Return type

[**CreateGeneralRecommendationRead**](CreateGeneralRecommendationRead.md)

### Authorization

[cookieAuth](../README.md#cookieAuth), [firebaseAuth](../README.md#firebaseAuth)

### HTTP request headers

 - **Content-Type**: application/json, application/x-www-form-urlencoded, multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **generalRecommendationsV2Retrieve**
> GeneralRecommendationsResponse generalRecommendationsV2Retrieve()



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

final api = NephrogoApiClient().getGeneralRecommendationsApi();

try {
    final response = api.generalRecommendationsV2Retrieve();
    print(response);
} catch on DioError (e) {
    print('Exception when calling GeneralRecommendationsApi->generalRecommendationsV2Retrieve: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**GeneralRecommendationsResponse**](GeneralRecommendationsResponse.md)

### Authorization

[cookieAuth](../README.md#cookieAuth), [firebaseAuth](../README.md#firebaseAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

