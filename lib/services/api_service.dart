import 'package:async/async.dart';
import 'package:dio/dio.dart';
import 'package:dio_http2_adapter/dio_http2_adapter.dart';
import 'package:nephrolog/authentication/authentication_provider.dart';
import 'package:logging/logging.dart';
import 'package:nephrolog/models/contract.dart';
import 'package:nephrolog_api_client/api.dart';
import 'package:nephrolog_api_client/model/user_health_status_report.dart';

class ApiService {
  final logger = Logger('ApiService');

  static const _baseApiUrl = "https://api.nephrolog.lt/";
  static const _connectionIdleTimeout = Duration(minutes: 1);

  static const _tokenRegeneratedKey = "tokenRegenerated";

  static final ApiService _singleton = ApiService._internal();

  final _authenticationProvider = AuthenticationProvider();

  NephrologApiClient _apiClient;

  var _firebaseTokenMemoizer = AsyncMemoizer<String>();

  factory ApiService() {
    return _singleton;
  }

  ApiService._internal() {
    final dio = Dio(BaseOptions(baseUrl: _baseApiUrl));
    dio.httpClientAdapter = Http2Adapter(
        ConnectionManager(idleTimeout: _connectionIdleTimeout.inMilliseconds));

    _apiClient = NephrologApiClient(
      dio: dio,
      basePathOverride: _baseApiUrl,
      interceptors: [_apiHeadersInterceptor(dio)],
    );
  }

  Future<String> _getIdToken(bool forceRefresh) {
    if (forceRefresh) {
      _firebaseTokenMemoizer = AsyncMemoizer<String>();
    }

    return _firebaseTokenMemoizer.runOnce(() async {
      return await _authenticationProvider.idToken(forceRefresh);
    });
  }

  InterceptorsWrapper _apiHeadersInterceptor(Dio dio) {
    return InterceptorsWrapper(
      onRequest: (RequestOptions options) async {
        try {
          dio.interceptors.requestLock.lock();
          final forceRegenerateToken =
              options.extra.containsKey(_tokenRegeneratedKey);

          await _addHeaders(options.headers, forceRegenerateToken);
        } finally {
          dio.interceptors.requestLock.unlock();
        }

        return options;
      },
      onError: (DioError err) async {
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
      },
    );
  }

  // https://github.com/dart-lang/http2/issues/49
  // There is a bug in flutter. Headers should be lower cased
  Future _addHeaders(
      Map<String, dynamic> headers, bool forceRefreshIdToken) async {
    final idToken = await _getIdToken(forceRefreshIdToken);

    headers["time-zone"] = DateTime.now().timeZoneName;
    headers["authorization"] = "Bearer $idToken";
  }

  Future<UserIntakesResponse> getUserIntakes(
    DateTime from,
    DateTime to,
  ) {
    return Future.delayed(const Duration(milliseconds: 500), () {
      final response = UserIntakesResponse.generateDummy(from, to);

      response.dailyIntakes.sort((a, b) => b.date.compareTo(a.date));

      return response;
    });
  }

  Future<UserHealthStatusReport> getUserHealthStatusReport(
    DateTime from,
    DateTime to,
  ) async {
    final r = await _apiClient
        .getScreensApi()
        .v1ScreensHealthStatusGet(from: from, to: to);

    return r.data;
  }
}
