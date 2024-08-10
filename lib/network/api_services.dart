import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:prowiz/utils/build_environments.dart';

var headers = {'Content-Type': 'application/json'};

class ApiServices {
  static Dio? _dio;

  static Dio? getInstance() {
    if (_dio == null) {
      _dio = Dio();

      _dio?.options.baseUrl = BuildEnvironments.getBaseUrl();
      _dio?.options.connectTimeout = const Duration(seconds: 60);
      _dio?.options.receiveTimeout = const Duration(seconds: 2 * 60);
    }

    return _dio;
  }

  /*Get API CALL*/

  static Future<Response<dynamic>?> getApiCall(
      {required String url, Dio? dioInstance}) async {
    //Check if Dio instance already created

    if (dioInstance != null) {
      _dio = dioInstance;
    } else {
      if (_dio == null) {
        getInstance();
      }
    }

    try {
      if (kDebugMode) {
        log("GET CALL");

        log("Headers Model====> $headers");
        log("Request  URL $url");
      }

      final response = await _dio?.get(url, options: Options(headers: headers));

      if (kDebugMode) log("Get Response ====> $response");
      return response;
    } on DioException catch (error) {
      if (error.response?.statusCode == 403) {
        /////

        return error.response;
      } else if (error.response?.statusCode == 500) {
        if (kDebugMode) {
          log("Invalid status code====>");

          log("Error of ===> ${error.response}");
        }

        return error.response;
      } else {
        return error.response;
      }

      // TODO
    } on Exception {
      rethrow;
    }
  }

  static Future<Response<dynamic>?> postApiCall(
      {required String url, dynamic dataParams, Dio? dioInstance}) async {
    if (dioInstance != null) {
      _dio = dioInstance;
    } else {
      if (_dio == null) {
        getInstance();
      }
    }

    try {
      if (kDebugMode) {
        log("POST CALL");

        log("POST Headers Model====> $headers");
        log("POST Request  URL $url");
        log("POST Request  Data Params $dataParams");
      }

      final response = await _dio?.post(url,
          data: dataParams, options: Options(headers: headers));

      if (kDebugMode) {
        log("Post Response ====> $response");
        log("Post Response status code ====> ${response?.statusCode}");
      }

      return response;
    } on DioException catch (error) {
      if (error.response?.statusCode == 401) {
        /////// Call Token Refresh method

        return error.response;
      } else if (error.response?.statusCode == 503) {
        ///////Server Error

        return error.response;
      } else if (error.response?.statusCode == 501) {
        ///////Something went wrong

        return error.response;
      } else if (error.response?.statusCode == 403) {
        ////Duplicate Login

        return error.response;
      } else {
        error.response?.data = {
          "success": false,
          "message": error.response?.data['message'],
          "data": null,
        };

        return error.response;
      }
    } on Exception catch (e) {
      if (kDebugMode) log("Error Response ===> ${e.toString()}");

      final resp = await Response(
          requestOptions: RequestOptions(),
          statusCode: 502,
          statusMessage: "Server is under maintenance",
          data: {
            "data": {
              "success": false,
              "message": "Server is under maintenance, please try again later",
              "data": null,
            }
          });
      return resp;
    }
  }
}
