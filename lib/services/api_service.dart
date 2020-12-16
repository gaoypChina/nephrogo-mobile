import 'package:async/async.dart';
import 'package:dio/dio.dart';
import 'package:dio_http2_adapter/dio_http2_adapter.dart';
import 'package:nephrolog/authentication/authentication_provider.dart';
import 'package:nephrolog/models/contract.dart';
import 'package:logging/logging.dart';

class ApiService {
  final logger = Logger('ApiService');

  static const _baseApiUrl = "https://api.nephrolog.lt/";
  static const _connectionIdleTimeout = Duration(minutes: 1);

  static const _tokenRegeneratedKey = "tokenRegenerated";

  static final ApiService _singleton = ApiService._internal();

  final _authenticationProvider = AuthenticationProvider();

  final dio = Dio(BaseOptions(baseUrl: _baseApiUrl));

  var _firebaseTokenMemoizer = AsyncMemoizer<String>();

  factory ApiService() {
    return _singleton;
  }

  ApiService._internal() {
    dio.httpClientAdapter = Http2Adapter(
        ConnectionManager(idleTimeout: _connectionIdleTimeout.inMilliseconds));

    dio.interceptors.add(
      InterceptorsWrapper(
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
              logger
                  .warning("Authentication error. Regenerating user id token.");

              err.request.extra.addAll({_tokenRegeneratedKey: true});

              try {
                // We retry with the updated options
                return await this.dio.request(
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
      ),
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

  Future<UserHealthStatusResponse> getUserHealthStatus(
    DateTime from,
    DateTime to,
  ) {
    return Future.delayed(const Duration(milliseconds: 500), () {
      final response = UserHealthStatusResponse.generateDummy(from, to);

      response.dailyHealthStatuses.sort((a, b) => b.date.compareTo(a.date));

      return response;
    });
  }

  Future<String> profile() async {
    final response = await dio.get(
      '/v1/user/profile',
    );

    return response.toString();
  }
}
