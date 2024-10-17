

import 'package:http/http.dart';

abstract class ApiService {


  Future<Response> postRequest({required String endpoint, required dynamic body});

  Future<Response> getRequest({required String endpoint});



}