import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:starmotor/config/api_config.dart';

class ApiException implements Exception {
  final int statusCode;
  final String message;

  const ApiException({required this.statusCode, required this.message});

  @override
  String toString() => 'ApiException($statusCode): $message';
}

class ApiService {
  ApiService._internal();
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;

  String? _authToken;
  final http.Client _client = http.Client();

  void setAuthToken(String? token) => _authToken = token;

  Map<String, String> get _headers => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        if (_authToken != null) 'Authorization': 'Bearer $_authToken',
      };

  Uri _uri(String path, [Map<String, String>? queryParams]) =>
      Uri.parse('${ApiConfig.baseUrl}$path')
          .replace(queryParameters: queryParams);

  Future<Map<String, dynamic>> get(String path,
      [Map<String, String>? queryParams]) async {
    final response =
        await _client.get(_uri(path, queryParams), headers: _headers);
    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> post(String path,
      [Map<String, dynamic>? body]) async {
    final response = await _client.post(
      _uri(path),
      headers: _headers,
      body: body != null ? jsonEncode(body) : null,
    );
    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> put(String path,
      [Map<String, dynamic>? body]) async {
    final response = await _client.put(
      _uri(path),
      headers: _headers,
      body: body != null ? jsonEncode(body) : null,
    );
    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> delete(String path) async {
    final response =
        await _client.delete(_uri(path), headers: _headers);
    return _handleResponse(response);
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    final decoded = jsonDecode(response.body) as Map<String, dynamic>;
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return decoded;
    }
    throw ApiException(
      statusCode: response.statusCode,
      message: decoded['message'] as String? ?? 'Unknown error',
    );
  }
}
