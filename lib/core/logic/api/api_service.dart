import 'package:dio/dio.dart';
import '../user_prefs.dart';
import 'api_config.dart';
import 'api_response.dart';

// ─────────────────────────────────────────────
//  api_service.dart
//  ─────────────────────────────────
//  Generic plug-and-play HTTP client.
//
//  HOW TO USE:
//    // Simple GET
//    final res = await ApiService.get('doctors');
//
//    // GET with auth token (reads from UserPrefs automatically)
//    final res = await ApiService.authenticatedGet('profile');
//
//    // POST
//    final res = await ApiService.post('login', {'email': '...', 'password': '...'});
//
//    // Access data — works for ANY API response structure
//    if (res.success) {
//      final list = res.asList;          // dynamic list
//      final name = res.get<String>('name'); // single field
//    }
//
//  Adding new endpoints:
//    1. Add the endpoint path to ApiConfig.endpoints
//    2. Call ApiService.get('<your_key>')
//    → No other changes needed
// ─────────────────────────────────────────────

class ApiService {
  ApiService._();

  static Dio? _dio;

  static Dio get _client {
    if (_dio != null) return _dio!;
    _dio = Dio(
      BaseOptions(
        baseUrl:        ApiConfig.baseUrl,
        connectTimeout: ApiConfig.connectTimeout,
        receiveTimeout: ApiConfig.receiveTimeout,
        headers:        ApiConfig.defaultHeaders,
        validateStatus: (status) => status != null && status < 500,
      ),
    );
    // ── Logging interceptor (debug builds only) ──
    _dio!.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // ignore: avoid_print
          print('[API] ${options.method} ${options.path}');
          handler.next(options);
        },
        onResponse: (response, handler) {
          // ignore: avoid_print
          print('[API] ← ${response.statusCode} ${response.requestOptions.path}');
          handler.next(response);
        },
        onError: (error, handler) {
          // ignore: avoid_print
          print('[API] ✗ ${error.message}');
          handler.next(error);
        },
      ),
    );
    return _dio!;
  }

  // ── Reset client (call after changing baseUrl) ──
  static void reset() => _dio = null;

  // ────────────────────────────────────────────
  //  GET
  // ────────────────────────────────────────────

  /// Performs an unauthenticated GET request.
  /// [endpointKey] is a key from [ApiConfig.endpoints] OR a raw path.
  static Future<ApiResponse> get(
    String endpointKey, {
    Map<String, dynamic>? queryParams,
    Map<String, String>?  extraHeaders,
    String? id,
  }) async {
    if (!ApiConfig.isConfigured) {
      return ApiResponse.fail('API base URL not configured.');
    }
    try {
      final path = ApiConfig.endpoints.containsKey(endpointKey)
          ? ApiConfig.url(endpointKey, id: id)
          : endpointKey;
      final response = await _client.get(
        path,
        queryParameters: queryParams,
        options: Options(headers: extraHeaders),
      );
      return _handle(response);
    } on DioException catch (e) {
      return ApiResponse.fail(_dioError(e));
    } catch (e) {
      return ApiResponse.fail(e.toString());
    }
  }

  // ────────────────────────────────────────────
  //  Authenticated GET (auto-attaches Bearer token)
  // ────────────────────────────────────────────

  static Future<ApiResponse> authenticatedGet(
    String endpointKey, {
    Map<String, dynamic>? queryParams,
    String? id,
  }) async {
    final token = await UserPrefs.getToken();
    return get(
      endpointKey,
      queryParams:  queryParams,
      extraHeaders: token != null ? {'Authorization': 'Bearer $token'} : null,
      id:           id,
    );
  }

  // ────────────────────────────────────────────
  //  POST
  // ────────────────────────────────────────────

  static Future<ApiResponse> post(
    String endpointKey,
    Map<String, dynamic> body, {
    Map<String, String>? extraHeaders,
    String? id,
  }) async {
    if (!ApiConfig.isConfigured) {
      return ApiResponse.fail('API base URL not configured.');
    }
    try {
      final path = ApiConfig.endpoints.containsKey(endpointKey)
          ? ApiConfig.url(endpointKey, id: id)
          : endpointKey;
      final response = await _client.post(
        path,
        data:    body,
        options: Options(headers: extraHeaders),
      );
      return _handle(response);
    } on DioException catch (e) {
      return ApiResponse.fail(_dioError(e));
    } catch (e) {
      return ApiResponse.fail(e.toString());
    }
  }

  // ────────────────────────────────────────────
  //  Authenticated POST
  // ────────────────────────────────────────────

  static Future<ApiResponse> authenticatedPost(
    String endpointKey,
    Map<String, dynamic> body, {
    String? id,
  }) async {
    final token = await UserPrefs.getToken();
    return post(
      endpointKey,
      body,
      extraHeaders: token != null ? {'Authorization': 'Bearer $token'} : null,
      id: id,
    );
  }

  // ────────────────────────────────────────────
  //  PUT / PATCH
  // ────────────────────────────────────────────

  static Future<ApiResponse> put(
    String endpointKey,
    Map<String, dynamic> body, {
    Map<String, String>? extraHeaders,
    String? id,
  }) async {
    if (!ApiConfig.isConfigured) {
      return ApiResponse.fail('API base URL not configured.');
    }
    try {
      final path = ApiConfig.endpoints.containsKey(endpointKey)
          ? ApiConfig.url(endpointKey, id: id)
          : endpointKey;
      final response = await _client.put(
        path,
        data:    body,
        options: Options(headers: extraHeaders),
      );
      return _handle(response);
    } on DioException catch (e) {
      return ApiResponse.fail(_dioError(e));
    } catch (e) {
      return ApiResponse.fail(e.toString());
    }
  }

  static Future<ApiResponse> authenticatedPut(
    String endpointKey,
    Map<String, dynamic> body, {
    String? id,
  }) async {
    final token = await UserPrefs.getToken();
    return put(
      endpointKey,
      body,
      extraHeaders: token != null ? {'Authorization': 'Bearer $token'} : null,
      id: id,
    );
  }

  // ────────────────────────────────────────────
  //  DELETE
  // ────────────────────────────────────────────

  static Future<ApiResponse> delete(
    String endpointKey, {
    String? id,
  }) async {
    if (!ApiConfig.isConfigured) {
      return ApiResponse.fail('API base URL not configured.');
    }
    try {
      final token = await UserPrefs.getToken();
      final path = ApiConfig.endpoints.containsKey(endpointKey)
          ? ApiConfig.url(endpointKey, id: id)
          : endpointKey;
      final response = await _client.delete(
        path,
        options: Options(
          headers: token != null ? {'Authorization': 'Bearer $token'} : null,
        ),
      );
      return _handle(response);
    } on DioException catch (e) {
      return ApiResponse.fail(_dioError(e));
    } catch (e) {
      return ApiResponse.fail(e.toString());
    }
  }

  // ────────────────────────────────────────────
  //  Internal helpers
  // ────────────────────────────────────────────

  static ApiResponse _handle(Response response) {
    final code = response.statusCode ?? 0;
    if (code >= 200 && code < 300) {
      return ApiResponse.ok(response.data, statusCode: code);
    }
    final msg = _extractError(response.data) ?? 'خطأ ${response.statusCode}';
    return ApiResponse.fail(msg, statusCode: code);
  }

  static String? _extractError(dynamic data) {
    if (data is Map<String, dynamic>) {
      // Common error field names
      for (final key in ['message', 'error', 'msg', 'detail']) {
        if (data[key] is String) return data[key] as String;
      }
    }
    return null;
  }

  static String _dioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'انتهت مهلة الاتصال. تحقق من الإنترنت.';
      case DioExceptionType.connectionError:
        return 'لا يمكن الاتصال بالخادم. تحقق من الإنترنت.';
      default:
        return e.message ?? 'حدث خطأ غير متوقع.';
    }
  }
}
