// // To parse this JSON data, do
// //
// //     final loginResponseModel = loginResponseModelFromJson(jsonString);
//
// import 'dart:convert';
//
// LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));
//
// String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());
//
// class LoginResponseModel {
//   String email;
//   String accessToken;
//   String? message;
//
//   LoginResponseModel({
//     required this.email,
//     required this.accessToken,
//     this.message
//   });
//
//   factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
//     email: json["email"] ?? "",
//     accessToken: json["accessToken"] ?? "",
//     message: json['message'] ?? ""
//
//   );
//
//   Map<String, dynamic> toJson() => {
//     "email": email,
//     "accessToken": accessToken,
//     "message" : message,
//   };
// }

// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);

// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);

// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);

import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) =>
    json.encode(data.toJson());

class LoginResponseModel {
  String message;
  User user;
  List<Camera> cameras;

  LoginResponseModel({
    required this.message,
    required this.user,
    required this.cameras,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        message: json["message"],
        user: User.fromJson(json["user"]),
        cameras: json['cameras'] is List
            ? List<Camera>.from(json["cameras"].map((x) => Camera.fromJson(x)))
            : (json["cameras"] is Map && json["cameras"]["message"] != null)
                ? [
                    Camera(
                        groupId: '',
                        subgroupId: [],
                        message: json["cameras"]["message"])
                  ]
                : [],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "user": user.toJson(),
        "cameras": List<dynamic>.from(cameras.map((x) => x.toJson())),
      };
}

class Camera {
  String groupId;
  List<SubgroupId> subgroupId;
  String message;

  Camera({
    required this.groupId,
    required this.subgroupId,
    required this.message,
  });

  factory Camera.fromJson(Map<String, dynamic> json) => Camera(
        groupId: json["groupId"] ?? "",
        message: json['message'] ?? "",
        subgroupId: json["subgroupId"] != null
            ? List<SubgroupId>.from(json["subgroupId"].map((x) => SubgroupId.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "groupId": groupId,
        "message": message,
        "subgroupId": List<dynamic>.from(subgroupId.map((x) => x.toJson())),
      };
}

class SubgroupId {
  String subgroupId;
  List<Url> url;

  SubgroupId({
    required this.subgroupId,
    required this.url,
  });

  factory SubgroupId.fromJson(Map<String, dynamic> json) => SubgroupId(
        subgroupId: json["subgroupId"],
        url: List<Url>.from(json["url"].map((x) => Url.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "subgroupId": subgroupId,
        "url": List<dynamic>.from(url.map((x) => x.toJson())),
      };
}

class Url {
  String name;
  String url;

  Url({
    required this.name,
    required this.url,
  });

  factory Url.fromJson(Map<String, dynamic> json) => Url(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}

class User {
  String id;
  String username;
  String email;
  String locationCode;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.locationCode,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        locationCode: json["locationCode"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "locationCode": locationCode,
      };
}

// Error Model
class ErrorResponse {
  String? error;

  ErrorResponse({this.error});

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    return ErrorResponse(error: json['error']);
  }
}
