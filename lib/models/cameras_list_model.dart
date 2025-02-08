// // To parse this JSON data, do
// //
// //     final camerasListModel = camerasListModelFromJson(jsonString);
//
// import 'dart:convert';
//
// List<CamerasListModel> camerasListModelFromJson(String str) => List<CamerasListModel>.from(json.decode(str).map((x) => CamerasListModel.fromJson(x)));
//
// String camerasListModelToJson(List<CamerasListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//
// class CamerasListModel {
//   String groupId;
//   List<SubgroupId> subgroupId;
//
//   CamerasListModel({
//     required this.groupId,
//     required this.subgroupId,
//   });
//
//   factory CamerasListModel.fromJson(Map<String, dynamic> json) => CamerasListModel(
//     groupId: json["groupId"],
//     subgroupId: List<SubgroupId>.from(json["subgroupId"].map((x) => SubgroupId.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "groupId": groupId,
//     "subgroupId": List<dynamic>.from(subgroupId.map((x) => x.toJson())),
//   };
// }
//
// class SubgroupId {
//   String subgroupId;
//   List<Url> url;
//
//   SubgroupId({
//     required this.subgroupId,
//     required this.url,
//   });
//
//   factory SubgroupId.fromJson(Map<String, dynamic> json) => SubgroupId(
//     subgroupId: json["subgroupId"],
//     url: List<Url>.from(json["url"].map((x) => Url.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "subgroupId": subgroupId,
//     "url": List<dynamic>.from(url.map((x) => x.toJson())),
//   };
// }
//
// class Url {
//   String name;
//   String url;
//
//   Url({
//     required this.name,
//     required this.url,
//   });
//
//   factory Url.fromJson(Map<String, dynamic> json) => Url(
//     name: json["name"],
//     url: json["url"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "name": name,
//     "url": url,
//   };
// }
