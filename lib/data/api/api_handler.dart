import 'dart:convert' as json;

import 'package:http/http.dart' as http;

import '../../../core/utils/app_utils.dart';
import 'api_base_url.dart';

enum ApiType { get, post, put, patch, delete, multipart }

class ApiHandler {
  static bool printLg = true;

  static Future<http.Response> call({
    required ApiType type,
    required String apiEndPoint,
    Map<String, String> mapHeaders = const <String, String>{},
    List<String> pathParams = const [],
    Map<String, dynamic>? queryParams,
    dynamic jsonData = const <String, dynamic>{},
    Map<String, String> pathData = const <String, String>{},
  }) async {
    Uri tempUri = Uri.parse(
      "${ApiBaseUrl.baseUrl}$apiEndPoint${pathParams.isNotEmpty ? '/${pathParams.join('/')}' : ''}",
    ).replace(
      queryParameters: queryParams,
    );

    if (printLg) {
      AppUtils.printFormattedLog(
        "API: ${tempUri.toString()} \nRequest Body: $jsonData",
        title: "Api Request",
      );
    }

    switch (type) {
      case ApiType.get:
        return _get(
          uri: tempUri,
          mapHeaders: mapHeaders,
        );
      case ApiType.post:
        return _post(
          uri: tempUri,
          mapHeaders: mapHeaders,
          mBody: json.jsonEncode(jsonData),
        );
      case ApiType.put:
        return _put(
          uri: tempUri,
          mapHeaders: mapHeaders,
          mBody: json.jsonEncode(jsonData),
        );
      case ApiType.patch:
        return _patch(
          uri: tempUri,
          mapHeaders: mapHeaders,
          mBody: json.jsonEncode(jsonData),
        );
      case ApiType.delete:
        return _delete(
          uri: tempUri,
          mapHeaders: mapHeaders,
        );
      case ApiType.multipart:
        return _multipartPost(
          uri: tempUri,
          mapHeaders: mapHeaders,
          mBody: jsonData,
          pathMap: pathData,
        );
    }
  }

  /// Makes a GET request to the specified URI.
  ///
  /// Parameters:
  ///   uri: The URI to make the request to.
  ///   mapHeaders: Optional headers for the request.
  ///
  /// Returns:
  ///   A `Future<http.Response>` containing the API response.
  static Future<http.Response> _get({
    required Uri uri,
    Map<String, String> mapHeaders = const <String, String>{},
  }) async {
    final http.Response response = await http.get(uri, headers: mapHeaders);
    if (printLg) {
      AppUtils.printFormattedLog("API: ${uri.toString()} \nmyResponse----${response.body}", title: "Api Response");
    }

    return response;
  }

  /// Makes a POST request to the specified URI.
  ///
  /// Parameters:
  ///   uri: The URI to make the request to.
  ///   mapHeaders: Optional headers for the request.
  ///   mBody: The request body.
  ///
  /// Returns:
  ///   A `Future<http.Response>` containing the API response.
  static Future<http.Response> _post({
    required Uri uri,
    Map<String, String> mapHeaders = const <String, String>{},
    mBody,
  }) async {
    final http.Response response = await http.post(uri, headers: mapHeaders, body: mBody);
    if (printLg) {
      AppUtils.printFormattedLog("API: ${uri.toString()} \nRequest Body: $mBody\nmyResponse----${response.body}", title: "Api Response");
    }

    return response;
  }

  /// Makes a PATCH request to the specified URI.
  ///
  /// Parameters:
  ///   uri: The URI to make the request to.
  ///   mapHeaders: Optional headers for the request.
  ///   mBody: The request body.
  ///
  /// Returns:
  ///   A `Future<http.Response>` containing the API response.
  static Future<http.Response> _patch({
    required Uri uri,
    Map<String, String> mapHeaders = const <String, String>{},
    mBody,
  }) async {
    final http.Response response = await http.patch(uri, headers: mapHeaders, body: mBody);
    if (printLg) {
      AppUtils.printFormattedLog("API: ${uri.toString()} \nRequest Body: $mBody\nmyResponse----${response.body}", title: "Api Response");
    }

    return response;
  }

  /// Makes a PUT request to the specified URI.
  ///
  /// Parameters:
  ///   uri: The URI to make the request to.
  ///   mapHeaders: Optional headers for the request.
  ///   mBody: The request body.
  ///
  /// Returns:
  ///   A `Future<http.Response>` containing the API response.
  static Future<http.Response> _put({
    required Uri uri,
    Map<String, String> mapHeaders = const <String, String>{},
    mBody,
  }) async {
    final http.Response response = await http.put(uri, headers: mapHeaders, body: mBody);
    if (printLg) {
      AppUtils.printFormattedLog("API: ${uri.toString()} \nRequest Body: $mBody\nmyResponse----${response.body}", title: "Api Response");
    }

    return response;
  }

  /// Makes a DELETE request to the specified URI.
  ///
  /// Parameters:
  ///   uri: The URI to make the request to.
  ///   mapHeaders: Optional headers for the request.
  ///
  /// Returns:
  ///   A `Future<http.Response>` containing the API response.
  static Future<http.Response> _delete({
    required Uri uri,
    Map<String, String> mapHeaders = const <String, String>{},
  }) async {
    //mapHeaders['Content-Type'] = 'application/json';
    final http.Response response = await http.delete(uri, headers: mapHeaders);
    if (printLg) {
      AppUtils.printFormattedLog("API: ${uri.toString()} \nmyResponse----${response.body}", title: "Api Response");
    }

    return response;
  }

  /// Makes a multipart POST request to the specified URI.
  ///
  /// Parameters:
  ///   uri: The URI to make the request to.
  ///   mapHeaders: Optional headers for the request.
  ///   mBody: The request body.
  ///   pathMap: Optional path data for multipart requests.
  ///
  /// Returns:
  ///   A `Future<http.Response>` containing the API response.
  static Future<http.Response> _multipartPost({
    required Uri uri,
    Map<String, String> mapHeaders = const <String, String>{},
    mBody,
    Map<String, String> pathMap = const <String, String>{},
  }) async {
    var request = http.MultipartRequest('POST', uri);
    request.headers.addAll(mapHeaders);
    request.fields.addAll((mBody as Map<String, dynamic>).map((k, v) => MapEntry(k, v.toString())));
    if (pathMap.isNotEmpty) {
      for (var key in pathMap.keys) {
        request.files.add(await http.MultipartFile.fromPath(key, pathMap[key]!));
      }
    }
    var response = await request.send();
    http.Response httpResponse = await http.Response.fromStream(response);
    if (printLg) {
      AppUtils.printFormattedLog(
        "API: ${uri.toString()} \nRequest Body: $mBody\nRequest Paths: $pathMap\nmyResponse----${httpResponse.body}",
        title: "Api Response",
      );
    }
    return httpResponse;
  }
}
