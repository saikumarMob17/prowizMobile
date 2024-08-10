// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);

import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel {
  String email;
  String accessToken;

  LoginResponseModel({
    required this.email,
    required this.accessToken,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
    email: json["email"],
    accessToken: json["accessToken"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "accessToken": accessToken,
  };
}
