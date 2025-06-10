import 'dart:convert';
import 'package:http/http.dart' as http;

enum NetworkError implements Exception {
  badURL,
  invalidResponse,
  serverError,
  requestFailed,
  decodingError,
}

class NetworkManager {
  static final NetworkManager instance = NetworkManager._internal();
  NetworkManager._internal();

  Future<T> request<T>({
    required String urlString,
    String method = 'GET',
    Map<String, String> headers = const {'Content-Type': 'application/json'},
    dynamic body,
    required T Function(dynamic json) fromJson,
  }) async {
    print("NetworkManager request called with URL: $urlString");
    final uri = Uri.tryParse(urlString);
    if (uri == null) throw NetworkError.badURL;

    final request = http.Request(method, uri);
    request.headers.addAll(headers);

    if (body != null) {
      request.body = json.encode(body);
    }

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw NetworkError.serverError;
      }

      final jsonBody = jsonDecode(response.body);
      try {
        final result = fromJson(jsonBody);
        return result;
      } catch (parseError) {
        throw NetworkError.decodingError;
      }

      // return fromJson(jsonBody); // This works for both List or Map
    } catch (e) {
      throw NetworkError.requestFailed;
    }
  }
}
