import 'dart:async';
import 'dart:convert';
import 'dart:io';

import '../../core/constants/api_constant.dart';
import 'api_response.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  static const int _timeOut = 120;

  Future<ApiResponse> get(
      String path, {
        String? baseUrl,
        Uri? uri,
        Map<String, String>? headers,
        Map<String, dynamic>? parameters,
        int? timeOut,
      }) async {

    final url = uri ?? Uri.https(baseUrl ?? ApiConstants.baseUrl, path, parameters);

    print(url);

    return await requestServer(() async {

      final response = await http.get(url, headers: headers).timeout(Duration(seconds: timeOut ?? _timeOut));

      print(response.body);
      print(response.statusCode);
      print(response.reasonPhrase);

      return _handleStatusCode(response);

    });
  }



  Future<ApiResponse> post(String path, {String? baseUrl, Map<String, dynamic>? body, Map<String, String>? headers, Map<String, dynamic>? parameters,}) async {
    final url = Uri.https(baseUrl ?? ApiConstants.baseUrl, path, parameters);
    print(url);
    print('....');
    print(body);
    print('....');
    return await requestServer(() async {
      final response = await http.post(
        url,
        body: body == null ? {} : jsonEncode(body),
        headers: headers,
      )
          .timeout(const Duration(seconds: _timeOut));
      print(response.body);
      print(response.statusCode);
      print(response.reasonPhrase);
      return _handleStatusCode(response);
    });
  }

  Future<ApiResponse> delete(
      String path, {
        String? baseUrl,
        Map<String, dynamic>? body,
        Map<String, String>? headers,
        Map<String, dynamic>? parameters,
      }) async {
    final url = Uri.https(baseUrl ?? ApiConstants.baseUrl, path, parameters);
    return await requestServer(() async {
      final response = await http
          .delete(
        url,
        body: body == null ? null : jsonEncode(body),
        headers: headers,
      )
          .timeout(const Duration(seconds: _timeOut));
      return _handleStatusCode(response);
    });
  }


  Future<ApiResponse> update(
      String path, {
        Map<String, dynamic>? body,
        Map<String, String>? headers,
        Map<String, dynamic>? parameters,
      }) async {
    final url = Uri.https(ApiConstants.baseUrl, path, parameters);
    return await requestServer(() async {
      final response = await http.put(
        url,
        body: body == null ? {} : jsonEncode(body),
        headers: headers,
      );
      return _handleStatusCode(response);
    });
  }

  Future<dynamic>postFiles({
    required String path,
    required Map<String, String> headers,
    required Map<String, String> body,
    required Map<String, File?> files,
  }) async {
    try {
      final uri = Uri.parse(path);
      print("URI :${uri}");
      final request = http.MultipartRequest('POST', uri);
      request.headers.addAll(headers);
      request.fields.addAll(body);
      List<http.MultipartFile> multpartFiles = [];
      files.forEach((key, file) {
        if(file != null){
               multpartFiles.add(http.MultipartFile.fromBytes(
               key, file.readAsBytesSync(),
              filename: file.path));
        }
      });
      request.files.addAll(multpartFiles);
      final src = await request.send();
      var jsonResponse = jsonDecode(await src.stream.bytesToString());
      return Future.value(jsonResponse);
    } catch (error) {
      print("error: ${error.toString()}");
      throw error.toString();
    }
  }


  Future<ApiResponse> requestServer(Future Function() computation) async {
    try {
      return await computation();
    } on SocketException {
      throw "No Internet Connection";
    } on FormatException {
      throw "Format Error";
    } on HttpException {
      throw "Something Went Wrong";
    } on TimeoutException {
      throw "Time Out Error";
    } on Exception {
      throw "something Went Wrong";
    }
  }

  ApiResponse _handleStatusCode(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        final headers = response.headers;
        dynamic body;
        try {
          body = jsonDecode(response.body);
        } catch (error) {
          body = response.body;
        }
        return ApiResponse(
          body: body,
          headers: headers,
          bodyBytes: response.bodyBytes,
        );
      case 204:
        return ApiResponse(body: true, headers: true, bodyBytes: response.bodyBytes);
      case 400:
        throw jsonDecode(response.body)["error"][0]?? "Bad Request Error";
      case 401:
      case 403:
        throw  jsonDecode(response.body)["error"][0] ?? "Unauthorized Error";
      case 404:
        throw  jsonDecode(response.body)["error"][0] ?? "Not Found";
      case 500:
      default:
        throw jsonDecode(response.body)["error"][0] ?? "Something Went Wrong";
    }
  }
}
