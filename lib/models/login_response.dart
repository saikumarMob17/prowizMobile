// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);

import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel {
  String email;
  String accessToken;
  String? message;

  LoginResponseModel({
    required this.email,
    required this.accessToken,
    this.message
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
    email: json["email"] ?? "",
    accessToken: json["accessToken"] ?? "",
    message: json['message'] ?? ""

  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "accessToken": accessToken,
    "message" : message,
  };
}
