import 'package:async/async.dart';
import 'package:built_value/iso_8601_date_time_serializer.dart';
import 'package:built_value/serializer.dart';
import 'package:dio/dio.dart';
import 'package:dio_brotli_transformer/dio_brotli_transformer.dart';
import 'package:dio_http2_adapter/dio_http2_adapter.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import 'package:nephrolog/authentication/authentication_provider.dart';
import 'package:nephrolog/models/date.dart';
import 'package:nephrolog_api_client/api.dart';
import 'package:nephrolog_api_client/api/health_status_api.dart';
import 'package:nephrolog_api_client/api/nutrition_api.dart';
import 'package:nephrolog_api_client/api/user_api.dart';
import 'package:nephrolog_api_client/model/daily_health_status.dart';
import 'package:nephrolog_api_client/model/daily_health_status_request.dart';
import 'package:nephrolog_api_client/model/health_status_screen_response.dart';
import 'package:nephrolog_api_client/model/health_status_weekly_screen_response.dart';
import 'package:nephrolog_api_client/model/intake.dart';
import 'package:nephrolog_api_client/model/intake_request.dart';
import 'package:nephrolog_api_client/model/nutrient_screen_response.dart';
import 'package:nephrolog_api_client/model/nutrient_weekly_screen_response.dart';
import 'package:nephrolog_api_client/model/product.dart';
import 'package:nephrolog_api_client/model/user_profile.dart';
import 'package:nephrolog_api_client/model/user_profile_request.dart';
import 'package:nephrolog_api_client/serializers.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiService {
  static const _baseApiUrl = "https://api.nephrolog.lt/";
  static const _connectionIdleTimeout = Duration(minutes: 1);

  static final ApiService _singleton = ApiService._internal();

  NephrologApiClient _apiClient;
  NutritionApi _nutritionApi;
  HealthStatusApi _healthStatusApi;
  UserApi _userApi;

  factory ApiService() {
    return _singleton;
  }

  ApiService._internal() {
    _apiClient = _buildNephrologApiClient();

    _nutritionApi = _apiClient.getNutritionApi();
    _healthStatusApi = _apiClient.getHealthStatusApi();
    _userApi = _apiClient.getUserApi();
  }

  NephrologApiClient _buildNephrologApiClient() {
    final timeZoneName = DateTime.now().timeZoneName;

    final dio = Dio(BaseOptions(
      baseUrl: _baseApiUrl,
      connectTimeout: 5000,
      receiveTimeout: 3000,
      headers: {
        "time-zone-name": timeZoneName,
        'accept-encoding': 'br',
      },
    ));

    dio.transformer = DioBrotliTransformer();
    dio.httpClientAdapter = Http2Adapter(
        ConnectionManager(idleTimeout: _connectionIdleTimeout.inMilliseconds));

    return NephrologApiClient(
      dio: dio,
      basePathOverride: _baseApiUrl,
      serializers: _buildDioSerializers(),
      interceptors: _buildDioInterceptors(dio),
    );
  }

  List<Interceptor> _buildDioInterceptors(Dio dio) {
    final interceptors = <Interceptor>[_FirebaseAuthenticationInterceptor(dio)];

    if (kDebugMode) {
      interceptors.add(
        PrettyDioLogger(
          request: false,
          responseBody: true,
          requestHeader: true,
          requestBody: true,
        ),
      );
    }

    return interceptors;
  }

  Serializers _buildDioSerializers() {
    final apiSerializersBuilder = standardSerializers.toBuilder()
      ..add(DateAndDateTimeUtcSerializer());

    return apiSerializersBuilder.build();
  }

  Future<NutrientScreenResponse> getNutritionScreen([CancelToken cancelToken]) {
    return _nutritionApi
        .nutritionScreenRetrieve(cancelToken: cancelToken)
        .then((r) => r.data);
  }

  Future<NutrientWeeklyScreenResponse> getWeeklyDailyIntakesReport(
      DateTime from, DateTime to,
      [CancelToken cancelToken]) {
    return _nutritionApi
        .nutritionWeeklyRetrieve(Date(from), Date(to), cancelToken: cancelToken)
        .then((r) => r.data);
  }

  Future<List<Product>> getProducts(String query, [CancelToken cancelToken]) {
    return _nutritionApi
        .nutritionProductsList(query: query, cancelToken: cancelToken)
        .then((r) => r.data.toList());
  }

  Future<Intake> createIntake(IntakeRequest intakeRequest,
      [CancelToken cancelToken]) {
    return _nutritionApi
        .nutritionIntakeCreate(intakeRequest, cancelToken: cancelToken)
        .then((r) => r.data);
  }

  Future<DailyHealthStatus> createOrUpdateDailyHealthStatus(
      DailyHealthStatusRequest dailyHealthStatusRequest,
      [CancelToken cancelToken]) {
    return _healthStatusApi
        .healthStatusUpdate(
          Date(dailyHealthStatusRequest.date),
          dailyHealthStatusRequest,
          cancelToken: cancelToken,
        )
        .then((r) => r.data)
        .catchError(
          (e) async => await _healthStatusApi
              .healthStatusCreate(
                dailyHealthStatusRequest,
                cancelToken: cancelToken,
              )
              .then((r) => r.data),
          test: (e) => e is DioError && e.response?.statusCode == 404,
        );
  }

  Future<DailyHealthStatus> getDailyHealthStatus(DateTime date,
      [CancelToken cancelToken]) {
    return _healthStatusApi
        .healthStatusRetrieve(Date(date), cancelToken: cancelToken)
        .then((r) => r.data)
        .catchError(
          (e) => null,
          test: (e) => e is DioError && e.response?.statusCode == 404,
        );
  }

  Future<UserProfile> createOrUpdateUserProfile(UserProfileRequest userProfile,
      [CancelToken cancelToken]) {
    return _userApi
        .userProfileUpdate(userProfile, cancelToken: cancelToken)
        .then((r) => r.data)
        .catchError(
          (e) async => await _userApi
              .userProfileCreate(userProfile, cancelToken: cancelToken)
              .then((r) => r.data),
          test: (e) => e is DioError && e.response?.statusCode == 404,
        );
  }

  Future<UserProfile> getUserProfile([CancelToken cancelToken]) {
    return _userApi
        .userProfileRetrieve(cancelToken: cancelToken)
        .then((r) => r.data)
        .catchError(
          (e) => null,
          test: (e) => e is DioError && e.response?.statusCode == 404,
        );
  }

  Future<HealthStatusScreenResponse> getHealthStatusScreen(
      [CancelToken cancelToken]) {
    return _healthStatusApi
        .healthStatusScreenRetrieve(cancelToken: cancelToken)
        .then((r) => r.data);
  }

  Future<HealthStatusWeeklyScreenResponse> getWeeklyHealthStatusReport(
    DateTime from,
    DateTime to,
  ) {
    return _healthStatusApi
        .healthStatusWeeklyRetrieve(Date(from), Date(to))
        .then((r) => r.data);
  }
}

class _FirebaseAuthenticationInterceptor extends Interceptor {
  static const _tokenRegeneratedKey = "tokenRegenerated";

  final logger = Logger('ApiService');
  final _authenticationProvider = AuthenticationProvider();

  final Dio dio;

  var _firebaseTokenMemoizer = AsyncMemoizer<String>();

  _FirebaseAuthenticationInterceptor(this.dio);

  Future<String> _getIdToken(bool forceRefresh) {
    if (forceRefresh) {
      _firebaseTokenMemoizer = AsyncMemoizer<String>();
    }

    return _firebaseTokenMemoizer.runOnce(() async {
      return await _authenticationProvider.idToken(forceRefresh);
    });
  }

  @override
  Future onRequest(RequestOptions options) async {
    try {
      dio.interceptors.requestLock.lock();
      final forceRegenerateToken =
          options.extra.containsKey(_tokenRegeneratedKey);

      final idToken = await _getIdToken(forceRegenerateToken);

      options.headers["authorization"] = "Bearer $idToken";
    } finally {
      dio.interceptors.requestLock.unlock();
    }

    return options;
  }

  @override
  Future onError(DioError err) async {
    final statusCode = err.response?.statusCode;
    if (statusCode == 403 || statusCode == 401) {
      if (err.request.extra.containsKey(_tokenRegeneratedKey)) {
        logger.severe("Authentication error after regenerating token.");
      } else {
        logger.warning("Authentication error. Regenerating user id token.");

        err.request.extra.addAll({_tokenRegeneratedKey: true});

        try {
          // We retry with the updated options
          return await dio.request(
            err.request.path,
            cancelToken: err.request.cancelToken,
            data: err.request.data,
            onReceiveProgress: err.request.onReceiveProgress,
            onSendProgress: err.request.onSendProgress,
            queryParameters: err.request.queryParameters,
            options: err.request,
          );
        } catch (e) {
          return e;
        }
      }
    }
    return err;
  }
}

// Hack start
class DateAndDateTimeUtcSerializer extends Iso8601DateTimeSerializer {
  static final _dateFormat = DateFormat('yyyy-MM-dd');

  @override
  DateTime deserialize(Serializers serializers, Object serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final s = serialized as String;

    try {
      return _dateFormat.parseStrict(s, true);
    } on FormatException {}

    return super.deserialize(serializers, serialized);
  }
}
// hack end
