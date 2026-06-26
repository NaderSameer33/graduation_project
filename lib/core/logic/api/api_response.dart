// ─────────────────────────────────────────────
//  api_response.dart
//  ─────────────────────────────────
//  Wraps every API response so screens never
//  crash on missing / null fields.
//
//  Usage:
//    final res = await ApiService.get('doctors');
//    if (res.success) {
//      final list = res.asList;          // List<Map<String,dynamic>>
//      final name = res.get<String>('name');  // null-safe field access
//    } else {
//      print(res.error);
//    }
// ─────────────────────────────────────────────

class ApiResponse {
  const ApiResponse._({
    required this.success,
    this.data,
    this.error,
    this.statusCode,
  });

  final bool success;
  final dynamic data; // Map<String,dynamic> OR List<dynamic>
  final String? error;
  final int? statusCode;

  // ── Factories ────────────────────────────────

  factory ApiResponse.ok(dynamic data, {int? statusCode}) {
    return ApiResponse._(success: true, data: data, statusCode: statusCode);
  }

  factory ApiResponse.fail(String error, {int? statusCode}) {
    return ApiResponse._(success: false, error: error, statusCode: statusCode);
  }

  // ── Safe accessors ───────────────────────────
  T? get<T>(String key) {
    if (data is Map<String, dynamic>) {
      return (data as Map<String, dynamic>)[key] as T?;
    }
    return null;
  }

  T? nested<T>(String parent, String key) {
    if (data is Map<String, dynamic>) {
      final parentMap = (data as Map<String, dynamic>)[parent];
      if (parentMap is Map<String, dynamic>) {
        return parentMap[key] as T?;
      }
    }
    return null;
  }

  List<Map<String, dynamic>> get asList {
    if (data == null) return [];

    // Root is already a list
    if (data is List) {
      return (data as List).whereType<Map<String, dynamic>>().toList();
    }
    if (data is Map<String, dynamic>) {
      final map = data as Map<String, dynamic>;
      for (final key in ['data', 'results', 'items', 'list']) {
        if (map[key] is List) {
          return (map[key] as List).whereType<Map<String, dynamic>>().toList();
        }
      }
    }

    return [];
  }

  Map<String, dynamic> get asMap {
    if (data is Map<String, dynamic>) return data as Map<String, dynamic>;
    final list = asList;
    return list.isNotEmpty ? list.first : {};
  }

  @override
  String toString() =>
      'ApiResponse(success=$success, statusCode=$statusCode, error=$error)';
}
