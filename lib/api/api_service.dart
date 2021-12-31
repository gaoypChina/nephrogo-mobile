// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:async/async.dart';
import 'package:dio/dio.dart';
import 'package:dio_brotli_transformer/dio_brotli_transformer.dart';
import 'package:dio_firebase_performance/dio_firebase_performance.dart';
import 'package:dio_http2_adapter/dio_http2_adapter.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:logging/logging.dart';
import 'package:nephrogo/authentication/authentication_provider.dart';
import 'package:nephrogo/constants.dart';
import 'package:nephrogo_api_client/nephrogo_api_client.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

enum _AppStateChangeEvent { healthStatus, nutrition }

class ApiService {
  static const _connectionIdleTimeout = Duration(minutes: 1);

  static final ApiService _singleton = ApiService._internal();

  final _appEventsStreamController =
      StreamController<_AppStateChangeEvent>.broadcast();

  late NephrogoApiClient _apiClient;

  late NutritionApi _nutritionApi;
  late HealthStatusApi _healthStatusApi;
  late PeritonealDialysisApi _peritonealDialysisApi;
  late UserApi _userApi;
  late GeneralRecommendationsApi _generalRecommendationsApi;

  Stream<_AppStateChangeEvent> get appEventsStreamRemove =>
      _appEventsStreamController.stream;

  factory ApiService() {
    return _singleton;
  }

  ApiService._internal() {
    _apiClient = _buildNephrogoApiClient();

    _nutritionApi = _apiClient.getNutritionApi();
    _healthStatusApi = _apiClient.getHealthStatusApi();
    _userApi = _apiClient.getUserApi();
    _generalRecommendationsApi = _apiClient.getGeneralRecommendationsApi();
    _peritonealDialysisApi = _apiClient.getPeritonealDialysisApi();
  }

  NephrogoApiClient _buildNephrogoApiClient() {
    final timeZoneName = DateTime.now().timeZoneName;

    final dio = Dio(BaseOptions(
      baseUrl: Constants.apiUrl,
      connectTimeout: 8000,
      receiveTimeout: 5000,
      headers: {
        'time-zone-name': timeZoneName,
        'accept-encoding': 'br',
      },
    ));

    dio.transformer = DioBrotliTransformer();
    dio.httpClientAdapter = Http2Adapter(
        ConnectionManager(idleTimeout: _connectionIdleTimeout.inMilliseconds));

    return NephrogoApiClient(
      dio: dio,
      basePathOverride: Constants.apiUrl,
      interceptors: _buildDioInterceptors(dio),
    );
  }

  List<Interceptor> _buildDioInterceptors(Dio dio) {
    final interceptors = <Interceptor>[
      DioFirebasePerformanceInterceptor(),
      _FirebaseAuthenticationInterceptor(dio),
    ];

    if (kDebugMode) {
      interceptors.add(
        PrettyDioLogger(
          requestBody: true,
        ),
      );
    }

    return interceptors;
  }

  void _postAppStateChangeEvent(_AppStateChangeEvent event) {
    _appEventsStreamController.add(event);
  }

  Stream<_AppStateChangeEvent> _buildAppEventsStreamWithInitialEmit(
      _AppStateChangeEvent event) {
    return StreamGroup.merge(
      [_appEventsStreamController.stream, Stream.value(event)],
    ).where((e) => e == event);
  }

  Future<NutritionScreenV2Response> getNutritionScreen() {
    return _nutritionApi.nutritionScreenV2Retrieve().then((r) => r.data!);
  }

  Stream<NutritionScreenV2Response> getNutritionScreenStream() {
    return _buildAppEventsStreamWithInitialEmit(_AppStateChangeEvent.nutrition)
        .asyncMap((_) => getNutritionScreen());
  }

  Future<DailyIntakesReportsResponse> getLightDailyIntakeReports(
    Date from,
    Date to,
  ) {
    return _nutritionApi
        .nutritionDailyReportsLightRetrieve(from: from, to: to)
        .then((r) => r.data!);
  }

  Stream<DailyIntakesReportsResponse> getLightDailyIntakeReportsStream(
    Date from,
    Date to,
  ) {
    return _buildAppEventsStreamWithInitialEmit(_AppStateChangeEvent.nutrition)
        .asyncMap((_) => getLightDailyIntakeReports(from, to));
  }

  Future<NullableApiResponse<DailyIntakesReportResponse>> getDailyIntakesReport(
      Date date) {
    return _nutritionApi
        .nutritionDailyReportsRetrieve(date: date)
        .then((r) => NullableApiResponse<DailyIntakesReportResponse>(r.data))
        .catchError(
          (e) => NullableApiResponse<DailyIntakesReportResponse>(null),
          test: (e) => e is DioError && e.response?.statusCode == 404,
        );
  }

  Stream<NullableApiResponse<DailyIntakesReportResponse>>
      getDailyIntakesReportStream(Date date) {
    return _buildAppEventsStreamWithInitialEmit(_AppStateChangeEvent.nutrition)
        .asyncMap((_) => getDailyIntakesReport(date));
  }

  Future<NutrientWeeklyScreenResponse> getWeeklyDailyIntakesReport(
      Date from, Date to) {
    return _nutritionApi
        .nutritionWeeklyRetrieve(from: from, to: to)
        .then((r) => r.data!);
  }

  Stream<NutrientWeeklyScreenResponse> getWeeklyDailyIntakesReportStream(
      Date from, Date to) {
    return _buildAppEventsStreamWithInitialEmit(_AppStateChangeEvent.nutrition)
        .asyncMap((_) => getWeeklyDailyIntakesReport(from, to));
  }

  Future<ProductSearchResponse> getProducts(
    String query, {
    required bool submit,
    required List<int> excludeProductIds,
    required MealTypeEnum mealType,
  }) {
    final excludeProductIdsStr = excludeProductIds.join(',');

    return _nutritionApi
        .nutritionProductsSearchRetrieve(
          query: query,
          submit: submit,
          excludeProducts: excludeProductIdsStr,
          mealType: mealType.name,
        )
        .then((r) => r.data!);
  }

  Future<Intake> createIntake(IntakeRequest intakeRequest) {
    return _nutritionApi
        .nutritionIntakeCreate(intakeRequest: intakeRequest)
        .then(
      (r) {
        _postAppStateChangeEvent(_AppStateChangeEvent.nutrition);
        return r.data!;
      },
    );
  }

  Future<Intake> updateIntake(int intakeId, IntakeRequest intakeRequest) {
    return _nutritionApi
        .nutritionIntakeUpdate(id: intakeId, intakeRequest: intakeRequest)
        .then(
      (r) {
        _postAppStateChangeEvent(_AppStateChangeEvent.nutrition);
        return r.data!;
      },
    );
  }

  Future<void> deleteIntake(int intakeId) {
    return _nutritionApi.nutritionIntakeDestroy(id: intakeId).then(
      (r) {
        _postAppStateChangeEvent(_AppStateChangeEvent.nutrition);
      },
    );
  }

  Future<DailyHealthStatus> createOrUpdateDailyHealthStatus(
      DailyHealthStatusRequest dailyHealthStatusRequest) {
    return _healthStatusApi
        .healthStatusUpdate(dailyHealthStatusRequest: dailyHealthStatusRequest)
        .then(
      (r) {
        _postAppStateChangeEvent(_AppStateChangeEvent.healthStatus);
        return r.data!;
      },
    ).catchError(
      (e) => _healthStatusApi
          .healthStatusCreate(
              dailyHealthStatusRequest: dailyHealthStatusRequest)
          .then(
        (r) {
          _postAppStateChangeEvent(_AppStateChangeEvent.healthStatus);
          return r.data!;
        },
      ),
      test: (e) => e is DioError && e.response?.statusCode == 404,
    );
  }

  Future<DailyHealthStatus> partialUpdateDailyHealthStatus(
    DailyHealthStatusRequest dailyHealthStatusRequest,
  ) {
    return _healthStatusApi
        .healthStatusPartialUpdate(
            dailyHealthStatusRequest: dailyHealthStatusRequest)
        .then(
      (r) {
        _postAppStateChangeEvent(_AppStateChangeEvent.healthStatus);
        return r.data!;
      },
    );
  }

  Future<NullableApiResponse<DailyHealthStatus>> getDailyHealthStatus(
      Date date) {
    return _healthStatusApi
        .healthStatusRetrieve(date: date)
        .then((r) => NullableApiResponse<DailyHealthStatus>(r.data))
        .catchError(
          (e) => NullableApiResponse<DailyHealthStatus>(null),
          test: (e) => e is DioError && e.response?.statusCode == 404,
        );
  }

  Future<User> getUser() {
    return _userApi.userRetrieve().then((r) => r.data!);
  }

  Stream<User> getUserStream() {
    return _buildAppEventsStreamWithInitialEmit(_AppStateChangeEvent.nutrition)
        .asyncMap((_) => getUser());
  }

  Future<User> updateUser({required bool marketingAllowed}) {
    final userRequestBuilder = UserRequestBuilder();

    userRequestBuilder.isMarketingAllowed = marketingAllowed;

    return _userApi
        .userUpdate(userRequest: userRequestBuilder.build())
        .then((r) => r.data!);
  }

  Future<UserAppReview> getUserAppReview() {
    return _userApi.userAppReviewRetrieve().then((r) => r.data!);
  }

  Future<UserProfileV2> createOrUpdateUserProfile(
    UserProfileV2Request userProfileRequest,
  ) {
    return _userApi
        .userProfileV2Update(userProfileV2Request: userProfileRequest)
        .then(
      (r) {
        _postAppStateChangeEvent(_AppStateChangeEvent.healthStatus);
        _postAppStateChangeEvent(_AppStateChangeEvent.nutrition);

        return r.data!;
      },
    ).catchError(
      (e) => _userApi
          .userProfileV2Create(userProfileV2Request: userProfileRequest)
          .then(
        (r) {
          _postAppStateChangeEvent(_AppStateChangeEvent.healthStatus);
          _postAppStateChangeEvent(_AppStateChangeEvent.nutrition);

          return r.data!;
        },
      ),
      test: (e) => e is DioError && e.response?.statusCode == 404,
    );
  }

  Future<NullableApiResponse<UserProfileV2>> getUserProfile() {
    return _userApi
        .userProfileV2Retrieve()
        .then((r) => NullableApiResponse<UserProfileV2>(r.data))
        .catchError(
          (e) => NullableApiResponse<UserProfileV2>(null),
        );
  }

  Future<GeneralRecommendationsResponse> getGeneralRecommendations() {
    return _generalRecommendationsApi
        .generalRecommendationsV2Retrieve()
        .then((r) => r.data!);
  }

  Future<CreateGeneralRecommendationRead> markGeneralRecommendationAsRead(
    int recommendationId,
  ) {
    final builder = CreateGeneralRecommendationReadRequestBuilder()
      ..generalRecommendation = recommendationId;

    final request = builder.build();

    return _generalRecommendationsApi
        .generalRecommendationsReadCreate(
            createGeneralRecommendationReadRequest: request)
        .then((r) => r.data!);
  }

  Future<HealthStatusScreenResponse> getHealthStatusScreen() {
    return _healthStatusApi.healthStatusScreenRetrieve().then((r) => r.data!);
  }

  Stream<HealthStatusScreenResponse> getHealthStatusScreenStream() {
    return _buildAppEventsStreamWithInitialEmit(
            _AppStateChangeEvent.healthStatus)
        .asyncMap((_) => getHealthStatusScreen());
  }

  Future<HealthStatusWeeklyScreenResponse> getHealthStatuses(
    Date from,
    Date to,
  ) {
    return _healthStatusApi
        .healthStatusWeeklyRetrieve(from: from, to: to)
        .then((r) => r.data!);
  }

  Stream<HealthStatusWeeklyScreenResponse> getHealthStatusesStream(
    Date from,
    Date to,
  ) {
    return _buildAppEventsStreamWithInitialEmit(
            _AppStateChangeEvent.healthStatus)
        .asyncMap((_) => getHealthStatuses(from, to));
  }

  Future<BloodPressure> createBloodPressure(
    BloodPressureRequest bloodPressureRequest,
  ) {
    return _healthStatusApi
        .healthStatusBloodPressureCreate(
            bloodPressureRequest: bloodPressureRequest)
        .then(
      (r) {
        _postAppStateChangeEvent(_AppStateChangeEvent.healthStatus);

        return r.data!;
      },
    );
  }

  Future<BloodPressure> updateBloodPressure(
    int id,
    BloodPressureRequest bloodPressureRequest,
  ) {
    return _healthStatusApi
        .healthStatusBloodPressureUpdate(
      id: id,
      bloodPressureRequest: bloodPressureRequest,
    )
        .then(
      (r) {
        _postAppStateChangeEvent(_AppStateChangeEvent.healthStatus);

        return r.data!;
      },
    );
  }

  Future<void> deleteBloodPressure(int id) {
    return _healthStatusApi.healthStatusBloodPressureDestroy(id: id).then(
      (r) {
        _postAppStateChangeEvent(_AppStateChangeEvent.healthStatus);
      },
    );
  }

  Future<Pulse> updatePulse(int id, PulseRequest pulseRequest) {
    return _healthStatusApi
        .healthStatusPulseUpdate(id: id, pulseRequest: pulseRequest)
        .then(
      (r) {
        _postAppStateChangeEvent(_AppStateChangeEvent.healthStatus);

        return r.data!;
      },
    );
  }

  Future<Pulse> createPulse(PulseRequest pulseRequest) {
    return _healthStatusApi
        .healthStatusPulseCreate(pulseRequest: pulseRequest)
        .then(
      (r) {
        _postAppStateChangeEvent(_AppStateChangeEvent.healthStatus);

        return r.data!;
      },
    );
  }

  Future<void> deletePulse(int id) {
    return _healthStatusApi.healthStatusPulseDestroy(id: id).then(
      (r) {
        _postAppStateChangeEvent(_AppStateChangeEvent.healthStatus);
      },
    );
  }

  Future<ManualPeritonealDialysis> createManualPeritonealDialysis(
      ManualPeritonealDialysisRequest request) {
    return _peritonealDialysisApi
        .peritonealDialysisManualDialysisCreateCreate(
            manualPeritonealDialysisRequest: request)
        .then(
      (r) {
        _postAppStateChangeEvent(_AppStateChangeEvent.healthStatus);

        return r.data!;
      },
    );
  }

  Future<ManualPeritonealDialysis> updateManualPeritonealDialysis(
      int id, ManualPeritonealDialysisRequest request) {
    return _peritonealDialysisApi
        .peritonealDialysisManualDialysisUpdate(
            id: id, manualPeritonealDialysisRequest: request)
        .then(
      (r) {
        _postAppStateChangeEvent(_AppStateChangeEvent.healthStatus);

        return r.data!;
      },
    );
  }

  Future<void> deleteManualPeritonealDialysis(int id) {
    return _peritonealDialysisApi
        .peritonealDialysisManualDialysisDestroy(id: id)
        .then(
      (r) {
        _postAppStateChangeEvent(_AppStateChangeEvent.healthStatus);
      },
    );
  }

  Future<ManualPeritonealDialysisScreenResponse>
      getManualPeritonealDialysisScreen() {
    return _peritonealDialysisApi
        .peritonealDialysisManualScreenV2Retrieve()
        .then((r) => r.data!);
  }

  Stream<ManualPeritonealDialysisScreenResponse>
      getManualPeritonealDialysisScreenStream() {
    return _buildAppEventsStreamWithInitialEmit(
            _AppStateChangeEvent.healthStatus)
        .asyncMap((_) => getManualPeritonealDialysisScreen());
  }

  Future<AutomaticPeritonealDialysisScreenResponse>
      getAutomaticPeritonealDialysisScreen() {
    return _peritonealDialysisApi
        .peritonealDialysisAutomaticScreenRetrieve()
        .then((r) => r.data!);
  }

  Stream<AutomaticPeritonealDialysisScreenResponse>
      getAutomaticPeritonealDialysisScreenStream() {
    return _buildAppEventsStreamWithInitialEmit(
      _AppStateChangeEvent.healthStatus,
    ).asyncMap((_) => getAutomaticPeritonealDialysisScreen());
  }

  Future<AutomaticPeritonealDialysisPeriodResponse>
      getAutomaticPeritonealDialysisPeriod(Date from, Date to) {
    return _peritonealDialysisApi
        .peritonealDialysisAutomaticPeriodRetrieve(from: from, to: to)
        .then((r) => r.data!);
  }

  Stream<AutomaticPeritonealDialysisPeriodResponse>
      getAutomaticPeritonealDialysisPeriodStream(Date from, Date to) {
    return _buildAppEventsStreamWithInitialEmit(
      _AppStateChangeEvent.healthStatus,
    ).asyncMap((_) => getAutomaticPeritonealDialysisPeriod(from, to));
  }

  Future<AutomaticPeritonealDialysis> createAutomaticPeritonealDialysis(
      AutomaticPeritonealDialysisRequest request) {
    return _peritonealDialysisApi
        .peritonealDialysisAutomaticDialysisCreateCreate(
      automaticPeritonealDialysisRequest: request,
    )
        .then(
      (r) {
        _postAppStateChangeEvent(_AppStateChangeEvent.healthStatus);

        return r.data!;
      },
    );
  }

  Future<AutomaticPeritonealDialysis> updateAutomaticPeritonealDialysis(
      Date date, AutomaticPeritonealDialysisRequest request) {
    return _peritonealDialysisApi
        .peritonealDialysisAutomaticDialysisUpdate(
            date: date, automaticPeritonealDialysisRequest: request)
        .then(
      (r) {
        _postAppStateChangeEvent(_AppStateChangeEvent.healthStatus);

        return r.data!;
      },
    );
  }

  Future<void> deleteAutomaticPeritonealDialysis(Date date) {
    return _peritonealDialysisApi
        .peritonealDialysisAutomaticDialysisDestroy(date: date)
        .then(
      (r) {
        _postAppStateChangeEvent(_AppStateChangeEvent.healthStatus);
      },
    );
  }

  Future<CountryResponse> getCountries() {
    return _userApi.userCountriesRetrieve().then(
          (r) => r.data!,
        );
  }

  Future<User> selectCountry(String countryCode) {
    final builder = UserRequestBuilder();
    builder.selectedCountryCode = countryCode;

    return _userApi.userPartialUpdate(userRequest: builder.build()).then(
          (r) => r.data!,
        );
  }

  Future<MissingProduct> createMissingProduct(
    MissingProductRequest missingProductRequest,
  ) {
    return _nutritionApi
        .nutritionProductsMissingCreate(
          missingProductRequest: missingProductRequest,
        )
        .then(
          (r) => r.data!,
        );
  }

  Future dispose() async {
    await _appEventsStreamController.close();
  }
}

class NullableApiResponse<T> {
  final T? data;

  NullableApiResponse(this.data);
}

class _FirebaseAuthenticationInterceptor extends Interceptor {
  static const _tokenRegeneratedKey = 'tokenRegenerated';

  final logger = Logger('ApiService');
  final _authenticationProvider = AuthenticationProvider();

  final Dio dio;

  _FirebaseAuthenticationInterceptor(this.dio);

  Future<String> _getIdToken(bool forceRefresh) {
    return _authenticationProvider.idToken(forceRefresh: forceRefresh);
  }

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (_authenticationProvider.isUserLoggedIn) {
      try {
        dio.interceptors.requestLock.lock();
        final forceRegenerateToken =
            options.extra.containsKey(_tokenRegeneratedKey);

        final idToken = await _getIdToken(forceRegenerateToken);

        options.headers['authorization'] = 'Bearer $idToken';
      } finally {
        dio.interceptors.requestLock.unlock();
      }
    }

    super.onRequest(options, handler);
  }

  @override
  Future onError(
    DioError err,
    ErrorInterceptorHandler handler,
  ) async {
    final statusCode = err.response?.statusCode;
    if (statusCode == 403 || statusCode == 401) {
      if (err.requestOptions.extra.containsKey(_tokenRegeneratedKey)) {
        logger.severe('Authentication error after regenerating token.');
      } else {
        logger.warning('Authentication error. Regenerating user id token.');

        err.requestOptions.extra.addAll({_tokenRegeneratedKey: true});

        try {
          // We retry with the updated options
          return await dio.fetch(err.requestOptions);
        } catch (e) {
          return super.onError(err, handler);
        }
      }
    }
    return super.onError(err, handler);
  }
}
