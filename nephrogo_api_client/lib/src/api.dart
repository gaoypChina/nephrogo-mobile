//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:dio/dio.dart';
import 'package:built_value/serializer.dart';
import 'package:nephrogo_api_client/src/serializers.dart';
import 'package:nephrogo_api_client/src/auth/api_key_auth.dart';
import 'package:nephrogo_api_client/src/auth/basic_auth.dart';
import 'package:nephrogo_api_client/src/auth/bearer_auth.dart';
import 'package:nephrogo_api_client/src/auth/oauth.dart';
import 'package:nephrogo_api_client/src/api/general_recommendations_api.dart';
import 'package:nephrogo_api_client/src/api/health_status_api.dart';
import 'package:nephrogo_api_client/src/api/nutrition_api.dart';
import 'package:nephrogo_api_client/src/api/peritoneal_dialysis_api.dart';
import 'package:nephrogo_api_client/src/api/user_api.dart';

class NephrogoApiClient {
  static const String basePath = r'http://localhost';

  final Dio dio;
  final Serializers serializers;

  NephrogoApiClient({
    Dio? dio,
    Serializers? serializers,
    String? basePathOverride,
    List<Interceptor>? interceptors,
  })  : this.serializers = serializers ?? standardSerializers,
        this.dio = dio ??
            Dio(BaseOptions(
              baseUrl: basePathOverride ?? basePath,
              connectTimeout: const Duration(milliseconds: 5000),
              receiveTimeout: const Duration(milliseconds: 3000),
            )) {
    if (interceptors == null) {
      this.dio.interceptors.addAll([
        OAuthInterceptor(),
        BasicAuthInterceptor(),
        BearerAuthInterceptor(),
        ApiKeyAuthInterceptor(),
      ]);
    } else {
      this.dio.interceptors.addAll(interceptors);
    }
  }

  void setOAuthToken(String name, String token) {
    if (this.dio.interceptors.any((i) => i is OAuthInterceptor)) {
      (this.dio.interceptors.firstWhere((i) => i is OAuthInterceptor) as OAuthInterceptor).tokens[name] = token;
    }
  }

  void setBearerAuth(String name, String token) {
    if (this.dio.interceptors.any((i) => i is BearerAuthInterceptor)) {
      (this.dio.interceptors.firstWhere((i) => i is BearerAuthInterceptor) as BearerAuthInterceptor).tokens[name] = token;
    }
  }

  void setBasicAuth(String name, String username, String password) {
    if (this.dio.interceptors.any((i) => i is BasicAuthInterceptor)) {
      (this.dio.interceptors.firstWhere((i) => i is BasicAuthInterceptor) as BasicAuthInterceptor).authInfo[name] = BasicAuthInfo(username, password);
    }
  }

  void setApiKey(String name, String apiKey) {
    if (this.dio.interceptors.any((i) => i is ApiKeyAuthInterceptor)) {
      (this.dio.interceptors.firstWhere((element) => element is ApiKeyAuthInterceptor) as ApiKeyAuthInterceptor).apiKeys[name] = apiKey;
    }
  }

  /// Get GeneralRecommendationsApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  GeneralRecommendationsApi getGeneralRecommendationsApi() {
    return GeneralRecommendationsApi(dio, serializers);
  }

  /// Get HealthStatusApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  HealthStatusApi getHealthStatusApi() {
    return HealthStatusApi(dio, serializers);
  }

  /// Get NutritionApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  NutritionApi getNutritionApi() {
    return NutritionApi(dio, serializers);
  }

  /// Get PeritonealDialysisApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  PeritonealDialysisApi getPeritonealDialysisApi() {
    return PeritonealDialysisApi(dio, serializers);
  }

  /// Get UserApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  UserApi getUserApi() {
    return UserApi(dio, serializers);
  }
}
