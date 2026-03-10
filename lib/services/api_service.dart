import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import '../config/app_config.dart';
import 'storage_service.dart';

class ApiException implements Exception {
  final int statusCode;
  final String message;

  const ApiException({required this.statusCode, required this.message});

  @override
  String toString() => 'ApiException($statusCode): $message';
}

class ApiService {
  ApiService._();

  static final ApiService _instance = ApiService._();
  static ApiService get instance => _instance;

  Future<Map<String, String>> _getHeaders() async {
    final token = await StorageService.instance.getAccessToken();
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  Uri _buildUri(String endpoint, [Map<String, dynamic>? queryParams]) {
    final uri = Uri.parse('${ApiConfig.baseUrl}$endpoint');
    if (queryParams != null && queryParams.isNotEmpty) {
      return uri.replace(
        queryParameters: queryParams.map(
          (k, v) => MapEntry(k, v.toString()),
        ),
      );
    }
    return uri;
  }

  Future<dynamic> get(
    String endpoint, {
    Map<String, dynamic>? queryParams,
  }) async {
    final uri = _buildUri(endpoint, queryParams);
    final headers = await _getHeaders();

    final response = await http
        .get(uri, headers: headers)
        .timeout(ApiConfig.receiveTimeout);

    return _handleResponse(response);
  }

  Future<dynamic> post(
    String endpoint, {
    Map<String, dynamic>? body,
  }) async {
    final uri = _buildUri(endpoint);
    final headers = await _getHeaders();

    final response = await http
        .post(
          uri,
          headers: headers,
          body: body != null ? jsonEncode(body) : null,
        )
        .timeout(ApiConfig.receiveTimeout);

    return _handleResponse(response);
  }

  Future<dynamic> put(
    String endpoint, {
    Map<String, dynamic>? body,
  }) async {
    final uri = _buildUri(endpoint);
    final headers = await _getHeaders();

    final response = await http
        .put(
          uri,
          headers: headers,
          body: body != null ? jsonEncode(body) : null,
        )
        .timeout(ApiConfig.receiveTimeout);

    return _handleResponse(response);
  }

  Future<dynamic> delete(String endpoint) async {
    final uri = _buildUri(endpoint);
    final headers = await _getHeaders();

    final response = await http
        .delete(uri, headers: headers)
        .timeout(ApiConfig.receiveTimeout);

    return _handleResponse(response);
  }

  dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) return null;
      return jsonDecode(response.body);
    }

    String message = 'Unknown error';
    try {
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      message = body['message'] as String? ??
          body['error'] as String? ??
          'Request failed';
    } catch (_) {
      message = 'Request failed with status ${response.statusCode}';
    }

    throw ApiException(statusCode: response.statusCode, message: message);
  }

  // Mock data helpers for development
  static Map<String, dynamic> mockPaginatedResponse({
    required List<Map<String, dynamic>> items,
    int page = 1,
    int total = 0,
  }) {
    return {
      'data': items,
      'pagination': {
        'page': page,
        'per_page': AppConfig.defaultPageSize,
        'total': total > 0 ? total : items.length,
        'total_pages': (total / AppConfig.defaultPageSize).ceil(),
      },
    };
  }
}
