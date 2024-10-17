import 'dart:convert';
import 'dart:developer';

import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:http/http.dart';
import 'package:prowiz/network/api_service.dart';
import 'package:prowiz/utils/storage_utils.dart';
import 'package:prowiz/utils/strings.dart';

class ApiClient implements ApiService {
  //Singleton instance variable
  static ApiClient? _instance;

  ///headers passed during api call
  var headers = <String, String>{
    NetworkConstants.contentTypeKey: NetworkConstants.applicationJson
  };

  ///factory constructor
  factory ApiClient() {
    _instance ??= ApiClient._internal();
    return _instance!;
  }

  /// Internal Named Constructor

  ApiClient._internal();
  @override
  Future<Response> getRequest(
      {required String endpoint, Map<String, String>? customHeader}) async {
    if (StorageUtils.getAccessToken().isNotEmpty) {
      headers[NetworkConstants.xAccessToken] = StorageUtils.getAccessToken();
    }

    // if (customHeader != null) {
    //   headers.clear();
    //   headers.addAll(customHeader);
    // }

    printRequest(
        url: endpoint, type: NetworkConstants.getRequestType, headers: headers);

    var response = await get(Uri.parse(endpoint), headers: headers).timeout(
        const Duration(seconds: 30),
        onTimeout: () =>
            Response(NetworkConstants.timeOut, HttpStatus.requestTimeout));

    printResponse(statusCode: response.statusCode, body: response.body);
    // TODO: implement getReqeust
    return response;
  }

  @override
  Future<Response> postRequest(
      {required String endpoint,
      required body,
      Map<String, String>? customHeader}) async {
    if (StorageUtils.getAccessToken().isNotEmpty) {
      headers[NetworkConstants.xAccessToken] = StorageUtils.getAccessToken();
    }

    printRequest(
        url: endpoint,
        type: NetworkConstants.postRequestType,
        headers: headers,
        body: body);

    var response = await post(Uri.parse(endpoint),
            body: jsonEncode(body), headers: headers)
        .timeout(const Duration(seconds: 30),
            onTimeout: () =>
                Response(NetworkConstants.timeOut, HttpStatus.requestTimeout));

    // TODO: implement postRequest

    printResponse(statusCode: response.statusCode, body: response.body);

    return response;
  }

  ///Below method for the print the request
  void printRequest(
      {required String url,
      required String type,
      required dynamic headers,
      dynamic body}) {
    body == null
        ? log("===> type---> $type\n url===> $url\n ===> headers ===> $headers")
        : log(
            "===> type$type\n ==> url==>$url\n==> body==> $body\n headers==>$headers");
  }

  ///Below method for print the response

  void printResponse({required int statusCode, required String body}) =>
      log("statusCode==> $statusCode ==> responseBody ==> $body");
}
