// To parse this JSON data, do
//
//     final genderResModel = genderResModelFromJson(jsonString);

import 'dart:convert';

GenderResModel genderResModelFromJson(String str) => GenderResModel.fromJson(json.decode(str));

String genderResModelToJson(GenderResModel data) => json.encode(data.toJson());

class GenderResModel {
  int? status;
  List<Datum>? data;

  GenderResModel({
    this.status,
    this.data,
  });

  GenderResModel copyWith({
    int? status,
    List<Datum>? data,
  }) =>
      GenderResModel(
        status: status ?? this.status,
        data: data ?? this.data,
      );

  factory GenderResModel.fromJson(Map<String, dynamic> json) => GenderResModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  int? id;
  String? name;

  Datum({
    this.id,
    this.name,
  });

  Datum copyWith({
    int? id,
    String? name,
  }) =>
      Datum(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
