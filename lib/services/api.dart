import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

_parseAndDecode(String response) {
  return jsonDecode(response);
}

_parseJson(String text) {
  return compute(_parseAndDecode, text);
}

class LogInterceptor extends Interceptor {
  LogInterceptor({
    this.request = true,
    this.requestHeader = true,
    this.requestBody = false,
    this.responseHeader = true,
    this.responseBody = false,
    this.error = true,
    this.logSize = 2048,
  });

  bool request;
  bool requestHeader;
  bool requestBody;
  bool responseBody;
  bool responseHeader;
  bool error;
  final logSize;

  @override
  onRequest(RequestOptions options) {
    print("*** Request ***");
    print("${options.method} ${options.uri} ?${options.queryParameters} B${options.data} H${options.headers}");
  }

  @override
  onError(DioError err) {
    if (error) {
      print('*** DioError ***:');
      print(err);
      if (err.response != null) {
        printAll(err.response.toString());
      }
    }
  }

  @override
  onResponse(Response response) {
    print("*** Response ***");
    printAll(response.toString());
  }

  printAll(msg) {
    msg.toString().split("\n").forEach(_printAll);
  }

  _printAll(String msg) {
    int groups = (msg.length / logSize).ceil();
    for (int i = 0; i < groups; ++i) {
      print((i > 0 ? '<<Log follows the previous line: ' : '') +
          msg.substring(i * logSize, math.min<int>(i * logSize + logSize, msg.length)));
    }
  }
}

class Api {
  static Dio dio;

  static void init([String authToken]) {
    BaseOptions options = new BaseOptions(
      baseUrl: "https://api.digibreak.itis.team",
      connectTimeout: 10000,
      receiveTimeout: 10000,
      headers: authToken != null ? {"Authorization": authToken} : {},
    );
    dio = new Dio(options);
    dio.interceptors.add(LogInterceptor());
    (dio.transformer as DefaultTransformer).jsonDecodeCallback = _parseJson;
  }

  static Future<String> login(String email, String password) async {
    Response res = await dio.post(
      "/auth/login",
      data: {
        "email": email,
        "password": password,
      },
      options: Options(contentType: ContentType.parse("application/x-www-form-urlencoded")),
    );
    return res.data;
  }

  static logout() async {
    dio.post("/users/logout");
  }
}
