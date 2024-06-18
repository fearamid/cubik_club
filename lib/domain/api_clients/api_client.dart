import 'dart:convert';
import 'dart:io';

// TODO: these methods ~ equal, maybe create common func

class ApiClient {
  static const String _scheme = 'https';
  static const String _host = 'fearamid-cubik-club-backend-777f.twc1.net';
  static const String _baseApiPath = '/api';

  final _client = HttpClient();

  Future<HttpClientResponse> get({
    required String path,
    String? query,
    Map<String, Object>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    final url = _createUri(
      path: path,
      query: query,
      queryParameters: queryParameters,
    );

    final request = await _client.getUrl(url);
    print(request.uri);

    headers?.forEach((header, value) {
      request.headers.set(header, value);
    });

    final response = await request.close();

    return response;
  }

  Future<HttpClientResponse> post({
    required String path,
    required Map<String, String> body,
    Map<String, Object>? headers,
    String? query,
    Map<String, dynamic>? queryParameters,
  }) async {
    final url = _createUri(
      path: path,
      query: query,
      queryParameters: queryParameters,
    );

    final request = await _client.postUrl(url);

    headers?.forEach((header, value) {
      request.headers.set(header, value);
    });

    request.write(jsonEncode(body));

    final response = await request.close();
    return response;
  }

  Uri _createUri({
    required String path,
    String? query,
    Map<String, dynamic>? queryParameters,
  }) {
    final endPointPath = _baseApiPath + path;
    return Uri(
      scheme: _scheme,
      host: _host,
      path: endPointPath,
      query: query,
      queryParameters: queryParameters,
    );
  }

  static Future<T> getJson<T>(HttpClientResponse response) async {
    final json = await response
        .transform(utf8.decoder)
        .toList()
        .then((value) => value.join())
        .then((v) => jsonDecode(v) as T);

    return json;
  }
}
