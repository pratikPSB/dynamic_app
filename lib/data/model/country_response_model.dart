// To parse this JSON data, do
//
//     final countryResponseModel = countryResponseModelFromJson(jsonString);

import 'dart:convert';

CountryResponseModel countryResponseModelFromJson(String str) => CountryResponseModel.fromJson(json.decode(str));

String countryResponseModelToJson(CountryResponseModel data) => json.encode(data.toJson());

class CountryResponseModel {
  final int? statusCode;
  final int? status;
  final dynamic errors;
  final dynamic message;
  final dynamic redirectUrlOk;
  final dynamic redirectUrlNext;
  final List<ExtraDatum>? extraData;
  final int? responseType;
  final dynamic name;
  final dynamic messageCode;

  CountryResponseModel({
    this.statusCode,
    this.status,
    this.errors,
    this.message,
    this.redirectUrlOk,
    this.redirectUrlNext,
    this.extraData,
    this.responseType,
    this.name,
    this.messageCode,
  });

  CountryResponseModel copyWith({
    int? statusCode,
    int? status,
    dynamic errors,
    dynamic message,
    dynamic redirectUrlOk,
    dynamic redirectUrlNext,
    List<ExtraDatum>? extraData,
    int? responseType,
    dynamic name,
    dynamic messageCode,
  }) =>
      CountryResponseModel(
        statusCode: statusCode ?? this.statusCode,
        status: status ?? this.status,
        errors: errors ?? this.errors,
        message: message ?? this.message,
        redirectUrlOk: redirectUrlOk ?? this.redirectUrlOk,
        redirectUrlNext: redirectUrlNext ?? this.redirectUrlNext,
        extraData: extraData ?? this.extraData,
        responseType: responseType ?? this.responseType,
        name: name ?? this.name,
        messageCode: messageCode ?? this.messageCode,
      );

  factory CountryResponseModel.fromJson(Map<String, dynamic> json) => CountryResponseModel(
    statusCode: json["StatusCode"],
    status: json["Status"],
    errors: json["Errors"],
    message: json["Message"],
    redirectUrlOk: json["RedirectUrlOk"],
    redirectUrlNext: json["RedirectUrlNext"],
    extraData: json["ExtraData"] == null ? [] : List<ExtraDatum>.from(json["ExtraData"]!.map((x) => ExtraDatum.fromJson(x))),
    responseType: json["ResponseType"],
    name: json["Name"],
    messageCode: json["MessageCode"],
  );

  Map<String, dynamic> toJson() => {
    "StatusCode": statusCode,
    "Status": status,
    "Errors": errors,
    "Message": message,
    "RedirectUrlOk": redirectUrlOk,
    "RedirectUrlNext": redirectUrlNext,
    "ExtraData": extraData == null ? [] : List<dynamic>.from(extraData!.map((x) => x.toJson())),
    "ResponseType": responseType,
    "Name": name,
    "MessageCode": messageCode,
  };
}

class ExtraDatum {
  final int? countryId;
  final String? countryName;
  final String? countryCode;
  final String? flag;
  final String? vfsCountryId;
  final bool? status;
  final bool? isDeleted;
  final int? modifyBy;
  final int? errorMessage;
  final int? totalRecords;
  final dynamic loggedBy;
  final DateTime? modifiedDate;

  ExtraDatum({
    this.countryId,
    this.countryName,
    this.countryCode,
    this.flag,
    this.vfsCountryId,
    this.status,
    this.isDeleted,
    this.modifyBy,
    this.errorMessage,
    this.totalRecords,
    this.loggedBy,
    this.modifiedDate,
  });

  ExtraDatum copyWith({
    int? countryId,
    String? countryName,
    String? countryCode,
    String? flag,
    String? vfsCountryId,
    bool? status,
    bool? isDeleted,
    int? modifyBy,
    int? errorMessage,
    int? totalRecords,
    dynamic loggedBy,
    DateTime? modifiedDate,
  }) =>
      ExtraDatum(
        countryId: countryId ?? this.countryId,
        countryName: countryName ?? this.countryName,
        countryCode: countryCode ?? this.countryCode,
        flag: flag ?? this.flag,
        vfsCountryId: vfsCountryId ?? this.vfsCountryId,
        status: status ?? this.status,
        isDeleted: isDeleted ?? this.isDeleted,
        modifyBy: modifyBy ?? this.modifyBy,
        errorMessage: errorMessage ?? this.errorMessage,
        totalRecords: totalRecords ?? this.totalRecords,
        loggedBy: loggedBy ?? this.loggedBy,
        modifiedDate: modifiedDate ?? this.modifiedDate,
      );

  factory ExtraDatum.fromJson(Map<String, dynamic> json) => ExtraDatum(
    countryId: json["CountryId"],
    countryName: json["CountryName"],
    countryCode: json["CountryCode"],
    flag: json["Flag"],
    vfsCountryId: json["VFSCountryId"],
    status: json["Status"],
    isDeleted: json["IsDeleted"],
    modifyBy: json["ModifyBy"],
    errorMessage: json["ErrorMessage"],
    totalRecords: json["TotalRecords"],
    loggedBy: json["LoggedBy"],
    modifiedDate: json["ModifiedDate"] == null ? null : DateTime.parse(json["ModifiedDate"]),
  );

  Map<String, dynamic> toJson() => {
    "CountryId": countryId,
    "CountryName": countryName,
    "CountryCode": countryCode,
    "Flag": flag,
    "VFSCountryId": vfsCountryId,
    "Status": status,
    "IsDeleted": isDeleted,
    "ModifyBy": modifyBy,
    "ErrorMessage": errorMessage,
    "TotalRecords": totalRecords,
    "LoggedBy": loggedBy,
    "ModifiedDate": modifiedDate?.toIso8601String(),
  };
}
