// To parse this JSON data, do
//
//     final appConfigNewModel = appConfigNewModelFromJson(jsonString);

import 'dart:convert';

AppScreensModel appConfigNewModelFromJson(String str) => AppScreensModel.fromJson(json.decode(str));

String appConfigNewModelToJson(AppScreensModel data) => json.encode(data.toJson());

class AppScreensModel {
  final List<Screen>? screens;

  AppScreensModel({
    this.screens,
  });

  AppScreensModel copyWith({
    List<Screen>? screens,
  }) =>
      AppScreensModel(
        screens: screens ?? this.screens,
      );

  factory AppScreensModel.fromJson(Map<String, dynamic> json) => AppScreensModel(
    screens: json["screens"] == null ? [] : List<Screen>.from(json["screens"]!.map((x) => Screen.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "screens": screens == null ? [] : List<dynamic>.from(screens!.map((x) => x.toJson())),
  };
}

class Screen {
  final int? id;
  final String? route;
  final bool? isInitialRoute;
  final String? title;
  final List<On>? onPageLoad;
  final List<Field>? fields;
  final List<Button>? buttons;
  final On? onBack;

  Screen({
    this.id,
    this.route,
    this.isInitialRoute,
    this.title,
    this.onPageLoad,
    this.fields,
    this.buttons,
    this.onBack,
  });

  Screen copyWith({
    int? id,
    String? route,
    bool? isInitialRoute,
    String? title,
    List<On>? onPageLoad,
    List<Field>? fields,
    List<Button>? buttons,
    On? onBack,
  }) =>
      Screen(
        id: id ?? this.id,
        route: route ?? this.route,
        isInitialRoute: isInitialRoute ?? this.isInitialRoute,
        title: title ?? this.title,
        onPageLoad: onPageLoad ?? this.onPageLoad,
        fields: fields ?? this.fields,
        buttons: buttons ?? this.buttons,
        onBack: onBack ?? this.onBack,
      );

  factory Screen.fromJson(Map<String, dynamic> json) => Screen(
    id: json["id"],
    route: json["route"],
    isInitialRoute: json["is_initial_route"],
    title: json["title"],
    onPageLoad: json["onPageLoad"] == null ? [] : List<On>.from(json["onPageLoad"]!.map((x) => On.fromJson(x))),
    fields: json["fields"] == null ? [] : List<Field>.from(json["fields"]!.map((x) => Field.fromJson(x))),
    buttons: json["buttons"] == null ? [] : List<Button>.from(json["buttons"]!.map((x) => Button.fromJson(x))),
    onBack: json["onBack"] == null ? null : On.fromJson(json["onBack"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "route": route,
    "is_initial_route": isInitialRoute,
    "title": title,
    "onPageLoad": onPageLoad == null ? [] : List<dynamic>.from(onPageLoad!.map((x) => x.toJson())),
    "fields": fields == null ? [] : List<dynamic>.from(fields!.map((x) => x.toJson())),
    "buttons": buttons == null ? [] : List<dynamic>.from(buttons!.map((x) => x.toJson())),
    "onBack": onBack?.toJson(),
  };
}

class Button {
  final String? type;
  final String? label;
  final String? apiEndPoint;
  final String? method;
  final String? navigationOnSuccess;
  final NavigationOnFailure? navigationOnFailure;

  Button({
    this.type,
    this.label,
    this.apiEndPoint,
    this.method,
    this.navigationOnSuccess,
    this.navigationOnFailure,
  });

  Button copyWith({
    String? type,
    String? label,
    String? apiEndPoint,
    String? method,
    String? navigationOnSuccess,
    NavigationOnFailure? navigationOnFailure,
  }) =>
      Button(
        type: type ?? this.type,
        label: label ?? this.label,
        apiEndPoint: apiEndPoint ?? this.apiEndPoint,
        method: method ?? this.method,
        navigationOnSuccess: navigationOnSuccess ?? this.navigationOnSuccess,
        navigationOnFailure: navigationOnFailure ?? this.navigationOnFailure,
      );

  factory Button.fromJson(Map<String, dynamic> json) => Button(
    type: json["type"],
    label: json["label"],
    apiEndPoint: json["api_end_point"],
    method: json["method"],
    navigationOnSuccess: json["navigationOnSuccess"],
    navigationOnFailure: json["navigationOnFailure"] == null ? null : NavigationOnFailure.fromJson(json["navigationOnFailure"]),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "label": label,
    "api_end_point": apiEndPoint,
    "method": method,
    "navigationOnSuccess": navigationOnSuccess,
    "navigationOnFailure": navigationOnFailure?.toJson(),
  };
}

class NavigationOnFailure {
  final bool? showErrorMessage;
  final String? errorMessage;
  final bool? retryOption;

  NavigationOnFailure({
    this.showErrorMessage,
    this.errorMessage,
    this.retryOption,
  });

  NavigationOnFailure copyWith({
    bool? showErrorMessage,
    String? errorMessage,
    bool? retryOption,
  }) =>
      NavigationOnFailure(
        showErrorMessage: showErrorMessage ?? this.showErrorMessage,
        errorMessage: errorMessage ?? this.errorMessage,
        retryOption: retryOption ?? this.retryOption,
      );

  factory NavigationOnFailure.fromJson(Map<String, dynamic> json) => NavigationOnFailure(
    showErrorMessage: json["showErrorMessage"],
    errorMessage: json["errorMessage"],
    retryOption: json["retryOption"],
  );

  Map<String, dynamic> toJson() => {
    "showErrorMessage": showErrorMessage,
    "errorMessage": errorMessage,
    "retryOption": retryOption,
  };
}

class Field {
  final String? type;
  final String? label;
  final String? name;
  final bool? required;
  final String? inputType;
  final String? preloadApi;
  final Validation? validation;
  List<String>? options;

  Field({
    this.type,
    this.label,
    this.name,
    this.required,
    this.inputType,
    this.preloadApi,
    this.validation,
    this.options,
  });

  Field copyWith({
    String? type,
    String? label,
    String? name,
    bool? required,
    String? inputType,
    String? preloadApi,
    Validation? validation,
    List<String>? options,
  }) =>
      Field(
        type: type ?? this.type,
        label: label ?? this.label,
        name: name ?? this.name,
        required: required ?? this.required,
        inputType: inputType ?? this.inputType,
        preloadApi: preloadApi ?? this.preloadApi,
        validation: validation ?? this.validation,
        options: options ?? this.options,
      );

  factory Field.fromJson(Map<String, dynamic> json) => Field(
    type: json["type"],
    label: json["label"],
    name: json["name"],
    required: json["required"],
    inputType: json["inputType"],
    preloadApi: json["preloadApi"],
    validation: json["validation"] == null ? null : Validation.fromJson(json["validation"]),
    options: json["options"] == null ? [] : List<String>.from(json["options"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "label": label,
    "name": name,
    "required": required,
    "inputType": inputType,
    "preloadApi": preloadApi,
    "validation": validation?.toJson(),
    "options": options == null ? [] : List<dynamic>.from(options!.map((x) => x)),
  };
}

class Validation {
  final String? type;
  final String? errorMessage;
  final int? minLength;
  final List<String>? fileTypes;
  final int? maxSizeInKb;
  final int? maxLength;

  Validation({
    this.type,
    this.errorMessage,
    this.minLength,
    this.fileTypes,
    this.maxSizeInKb,
    this.maxLength,
  });

  Validation copyWith({
    String? type,
    String? errorMessage,
    int? minLength,
    List<String>? fileTypes,
    int? maxSizeInKb,
    int? maxLength,
  }) =>
      Validation(
        type: type ?? this.type,
        errorMessage: errorMessage ?? this.errorMessage,
        minLength: minLength ?? this.minLength,
        fileTypes: fileTypes ?? this.fileTypes,
        maxSizeInKb: maxSizeInKb ?? this.maxSizeInKb,
        maxLength: maxLength ?? this.maxLength,
      );

  factory Validation.fromJson(Map<String, dynamic> json) => Validation(
    type: json["type"],
    errorMessage: json["errorMessage"],
    minLength: json["minLength"],
    fileTypes: json["fileTypes"] == null ? [] : List<String>.from(json["fileTypes"]!.map((x) => x)),
    maxSizeInKb: json["maxSizeInKB"],
    maxLength: json["maxLength"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "errorMessage": errorMessage,
    "minLength": minLength,
    "fileTypes": fileTypes == null ? [] : List<dynamic>.from(fileTypes!.map((x) => x)),
    "maxSizeInKB": maxSizeInKb,
    "maxLength": maxLength,
  };
}

class On {
  final String? apiEndPoint;
  final String? method;
  final String? description;
  final String? targetField;

  On({
    this.apiEndPoint,
    this.method,
    this.description,
    this.targetField,
  });

  On copyWith({
    String? apiEndPoint,
    String? method,
    String? description,
    String? targetField,
  }) =>
      On(
        apiEndPoint: apiEndPoint ?? this.apiEndPoint,
        method: method ?? this.method,
        description: description ?? this.description,
        targetField: targetField ?? this.targetField,
      );

  factory On.fromJson(Map<String, dynamic> json) => On(
    apiEndPoint: json["api_end_point"],
    method: json["method"],
    description: json["description"],
    targetField: json["targetField"],
  );

  Map<String, dynamic> toJson() => {
    "api_end_point": apiEndPoint,
    "method": method,
    "description": description,
    "targetField": targetField,
  };
}
