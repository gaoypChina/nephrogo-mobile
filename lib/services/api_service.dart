import 'package:async/async.dart';
import 'package:dio/dio.dart';
import 'package:dio_http2_adapter/dio_http2_adapter.dart';
import 'package:intl/intl.dart';
import 'package:nephrolog/authentication/authentication_provider.dart';
import 'package:logging/logging.dart';
import 'package:nephrolog_api_client/api.dart';
import 'package:nephrolog_api_client/model/daily_intakes_screen.dart';
import 'package:nephrolog_api_client/model/products_response.dart';
import 'package:nephrolog_api_client/model/user_health_status_report.dart';
import 'package:nephrolog_api_client/serializers.dart';
import 'package:built_value/iso_8601_date_time_serializer.dart';
import 'package:built_value/serializer.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:flutter/foundation.dart' show kDebugMode;

class ApiService {
  static const _baseApiUrl = "https://api.nephrolog.lt/";
  static const _connectionIdleTimeout = Duration(minutes: 1);

  static final ApiService _singleton = ApiService._internal();

  NephrologApiClient _apiClient;

  factory ApiService() {
    return _singleton;
  }

  ApiService._internal() {
    _apiClient = _buildNephrologApiClient();
  }

  NephrologApiClient _buildNephrologApiClient() {
    final timeZoneName = DateTime.now().timeZoneName;

    final dio = Dio(BaseOptions(
      baseUrl: _baseApiUrl,
      connectTimeout: 5000,
      receiveTimeout: 3000,
      headers: {
        "time-zone": timeZoneName,
      },
    ));
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
          responseBody: false,
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

  Future<DailyIntakesScreen> getUserIntakes(
    DateTime from,
    DateTime to,
  ) async {
    final r = await _apiClient
        .getScreensApi()
        .v1ScreensDailyIntakesGet(from: _Date(from), to: _Date(to));

    return r.data;
  }

  Future<ProductsResponse> getProducts(String query,
      [CancelToken cancelToken]) async {
    final r = await _apiClient
        .getProductsApi()
        .v1ProductsGet(query: query, cancelToken: cancelToken);

    return r.data;
  }

  Future<UserHealthStatusReport> getUserHealthStatusReport(
    DateTime from,
    DateTime to,
  ) async {
    final r = await _apiClient
        .getScreensApi()
        .v1ScreensHealthStatusGet(from: _Date(from), to: _Date(to));

    return r.data;
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
// Dart doesn't have separate Date class so parsing yyyy-MM-dd format leads to
// local Date Time which is incorrect :(
// Related https://github.com/protocolbuffers/protobuf/issues/7411
class _Date extends DateTime {
  static final _dateFormat = DateFormat('yyyy-MM-dd');

  _Date(DateTime dateTime) : super(dateTime.year, dateTime.month, dateTime.day);

  @override
  String toString() {
    return _dateFormat.format(this);
  }
}

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
