// To parse this JSON data, do
//
//     final appModuleByClientModel = appModuleByClientModelFromJson(jsonString);

import 'dart:convert';

AppModuleByClientModel appModuleByClientModelFromJson(String str) => AppModuleByClientModel.fromJson(json.decode(str));

String appModuleByClientModelToJson(AppModuleByClientModel data) => json.encode(data.toJson());

class AppModuleByClientModel {
  String? tenent;
  String? configPointer;
  String? dashboardTitle;
  Filter? filter;
  List<Module>? modules;

  AppModuleByClientModel({
    this.tenent,
    this.configPointer,
    this.dashboardTitle,
    this.filter,
    this.modules,
  });

  AppModuleByClientModel copyWith({
    String? tenent,
    String? configPointer,
    String? dashboardTitle,
    Filter? filter,
    List<Module>? modules,
  }) =>
      AppModuleByClientModel(
        tenent: tenent ?? this.tenent,
        configPointer: configPointer ?? this.configPointer,
        dashboardTitle: dashboardTitle ?? this.dashboardTitle,
        filter: filter ?? this.filter,
        modules: modules ?? this.modules,
      );

  factory AppModuleByClientModel.fromJson(Map<String, dynamic> json) => AppModuleByClientModel(
    tenent: json["tenent"],
    configPointer: json["configPointer"],
    dashboardTitle: json["dashboardTitle"],
    filter: json["filter"] == null ? null : Filter.fromJson(json["filter"]),
    modules: json["modules"] == null ? [] : List<Module>.from(json["modules"]!.map((x) => Module.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "tenent": tenent,
    "configPointer": configPointer,
    "dashboardTitle": dashboardTitle,
    "filter": filter?.toJson(),
    "modules": modules == null ? [] : List<dynamic>.from(modules!.map((x) => x.toJson())),
  };
}

class Filter {
  ModuleClass? module;
  ModuleClass? field;

  Filter({
    this.module,
    this.field,
  });

  Filter copyWith({
    ModuleClass? module,
    ModuleClass? field,
  }) =>
      Filter(
        module: module ?? this.module,
        field: field ?? this.field,
      );

  factory Filter.fromJson(Map<String, dynamic> json) => Filter(
    module: json["module"] == null ? null : ModuleClass.fromJson(json["module"]),
    field: json["field"] == null ? null : ModuleClass.fromJson(json["field"]),
  );

  Map<String, dynamic> toJson() => {
    "module": module?.toJson(),
    "field": field?.toJson(),
  };
}

class ModuleClass {
  String? key;

  ModuleClass({
    this.key,
  });

  ModuleClass copyWith({
    String? key,
  }) =>
      ModuleClass(
        key: key ?? this.key,
      );

  factory ModuleClass.fromJson(Map<String, dynamic> json) => ModuleClass(
    key: json["key"],
  );

  Map<String, dynamic> toJson() => {
    "key": key,
  };
}

class Module {
  int? id;
  String? displayName;
  String? logicalName;
  String? routeUrl;
  int? displayPosition;
  Apis? apis;
  List<Control>? controls;
  FormLayoutType? formLayoutType;
  ModuleAccessibility? accessibility;

  Module({
    this.id,
    this.displayName,
    this.logicalName,
    this.routeUrl,
    this.displayPosition,
    this.apis,
    this.controls,
    this.formLayoutType,
    this.accessibility,
  });

  Module copyWith({
    int? id,
    String? displayName,
    String? logicalName,
    String? routeUrl,
    int? displayPosition,
    Apis? apis,
    List<Control>? controls,
    FormLayoutType? formLayoutType,
    ModuleAccessibility? accessibility,
  }) =>
      Module(
        id: id ?? this.id,
        displayName: displayName ?? this.displayName,
        logicalName: logicalName ?? this.logicalName,
        routeUrl: routeUrl ?? this.routeUrl,
        displayPosition: displayPosition ?? this.displayPosition,
        apis: apis ?? this.apis,
        controls: controls ?? this.controls,
        formLayoutType: formLayoutType ?? this.formLayoutType,
        accessibility: accessibility ?? this.accessibility,
      );

  factory Module.fromJson(Map<String, dynamic> json) => Module(
    id: json["id"],
    displayName: json["displayName"],
    logicalName: json["logicalName"],
    routeUrl: json["routeUrl"],
    displayPosition: json["displayPosition"],
    apis: json["apis"] == null ? null : Apis.fromJson(json["apis"]),
    controls: json["controls"] == null ? [] : List<Control>.from(json["controls"]!.map((x) => Control.fromJson(x))),
    formLayoutType: json["formLayoutType"] == null ? null : FormLayoutType.fromJson(json["formLayoutType"]),
    accessibility: json["accessibility"] == null ? null : ModuleAccessibility.fromJson(json["accessibility"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "displayName": displayName,
    "logicalName": logicalName,
    "routeUrl": routeUrl,
    "displayPosition": displayPosition,
    "apis": apis?.toJson(),
    "controls": controls == null ? [] : List<dynamic>.from(controls!.map((x) => x.toJson())),
    "formLayoutType": formLayoutType?.toJson(),
    "accessibility": accessibility?.toJson(),
  };
}

class ModuleAccessibility {
  Domain? domain;

  ModuleAccessibility({
    this.domain,
  });

  ModuleAccessibility copyWith({
    Domain? domain,
  }) =>
      ModuleAccessibility(
        domain: domain ?? this.domain,
      );

  factory ModuleAccessibility.fromJson(Map<String, dynamic> json) => ModuleAccessibility(
    domain: json["domain"] == null ? null : Domain.fromJson(json["domain"]),
  );

  Map<String, dynamic> toJson() => {
    "domain": domain?.toJson(),
  };
}

class Domain {
  String? value;

  Domain({
    this.value,
  });

  Domain copyWith({
    String? value,
  }) =>
      Domain(
        value: value ?? this.value,
      );

  factory Domain.fromJson(Map<String, dynamic> json) => Domain(
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
  };
}

class Apis {
  List<Online>? online;
  List<dynamic>? backoffice;

  Apis({
    this.online,
    this.backoffice,
  });

  Apis copyWith({
    List<Online>? online,
    List<dynamic>? backoffice,
  }) =>
      Apis(
        online: online ?? this.online,
        backoffice: backoffice ?? this.backoffice,
      );

  factory Apis.fromJson(Map<String, dynamic> json) => Apis(
    online: json["online"] == null ? [] : List<Online>.from(json["online"]!.map((x) => Online.fromJson(x))),
    backoffice: json["backoffice"] == null ? [] : List<dynamic>.from(json["backoffice"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "online": online == null ? [] : List<dynamic>.from(online!.map((x) => x.toJson())),
    "backoffice": backoffice == null ? [] : List<dynamic>.from(backoffice!.map((x) => x)),
  };
}

class Online {
  String? url;
  String? type;
  String? name;
  List<OnlineParam>? params;
  String? event;

  Online({
    this.url,
    this.type,
    this.name,
    this.params,
    this.event,
  });

  Online copyWith({
    String? url,
    String? type,
    String? name,
    List<OnlineParam>? params,
    String? event,
  }) =>
      Online(
        url: url ?? this.url,
        type: type ?? this.type,
        name: name ?? this.name,
        params: params ?? this.params,
        event: event ?? this.event,
      );

  factory Online.fromJson(Map<String, dynamic> json) => Online(
    url: json["url"],
    type: json["type"],
    name: json["name"],
    params: json["params"] == null ? [] : List<OnlineParam>.from(json["params"]!.map((x) => OnlineParam.fromJson(x))),
    event: json["event"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "type": type,
    "name": name,
    "params": params == null ? [] : List<dynamic>.from(params!.map((x) => x.toJson())),
    "event": event,
  };
}

class OnlineParam {
  String? key;
  String? type;
  String? value;
  bool? mandatory;

  OnlineParam({
    this.key,
    this.type,
    this.value,
    this.mandatory,
  });

  OnlineParam copyWith({
    String? key,
    String? type,
    String? value,
    bool? mandatory,
  }) =>
      OnlineParam(
        key: key ?? this.key,
        type: type ?? this.type,
        value: value ?? this.value,
        mandatory: mandatory ?? this.mandatory,
      );

  factory OnlineParam.fromJson(Map<String, dynamic> json) => OnlineParam(
    key: json["key"],
    type: json["type"],
    value: json["value"],
    mandatory: json["mandatory"],
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "type": type,
    "value": value,
    "mandatory": mandatory,
  };
}

class Control {
  int? row;
  bool? mandatory;
  List<FieldElement>? fields;
  dynamic bundleLabel;
  String? bundleName;

  Control({
    this.row,
    this.mandatory,
    this.fields,
    this.bundleLabel,
    this.bundleName,
  });

  Control copyWith({
    int? row,
    bool? mandatory,
    List<FieldElement>? fields,
    dynamic bundleLabel,
    String? bundleName,
  }) =>
      Control(
        row: row ?? this.row,
        mandatory: mandatory ?? this.mandatory,
        fields: fields ?? this.fields,
        bundleLabel: bundleLabel ?? this.bundleLabel,
        bundleName: bundleName ?? this.bundleName,
      );

  factory Control.fromJson(Map<String, dynamic> json) => Control(
    row: json["row"],
    mandatory: json["mandatory"],
    fields: json["fields"] == null ? [] : List<FieldElement>.from(json["fields"]!.map((x) => FieldElement.fromJson(x))),
    bundleLabel: json["bundleLabel"],
    bundleName: json["bundleName"],
  );

  Map<String, dynamic> toJson() => {
    "row": row,
    "mandatory": mandatory,
    "fields": fields == null ? [] : List<dynamic>.from(fields!.map((x) => x.toJson())),
    "bundleLabel": bundleLabel,
    "bundleName": bundleName,
  };
}

class FieldElement {
  bool? readOnly;
  String? fieldType;
  String? displayName;
  String? logicalName;
  List<dynamic>? defaultValueOptionSet;
  OptionsListApi? optionsListApi;
  Validations? validations;
  FieldAccessibility? accessibility;
  bool? hidden;
  String? placeholder;
  String? cssClass;
  List<OnChangeEvent>? onChangeEvent;
  dynamic defaultValueLookup;
  List<dynamic>? changeEmitterFields;
  bool? mandatory;
  String? titleText;
  String? subText1;
  String? subText2;
  List<dynamic>? disableOnValues;
  List<dynamic>? toggleDisableField;
  List<OnClickEvent>? onClickEvent;
  List<dynamic>? toggleHideShow;
  String? matDirective;
  bool? isInputDisabled;

  FieldElement({
    this.readOnly,
    this.fieldType,
    this.displayName,
    this.logicalName,
    this.defaultValueOptionSet,
    this.optionsListApi,
    this.validations,
    this.accessibility,
    this.hidden,
    this.placeholder,
    this.cssClass,
    this.onChangeEvent,
    this.defaultValueLookup,
    this.changeEmitterFields,
    this.mandatory,
    this.titleText,
    this.subText1,
    this.subText2,
    this.disableOnValues,
    this.toggleDisableField,
    this.onClickEvent,
    this.toggleHideShow,
    this.matDirective,
    this.isInputDisabled,
  });

  FieldElement copyWith({
    bool? readOnly,
    String? fieldType,
    String? displayName,
    String? logicalName,
    List<dynamic>? defaultValueOptionSet,
    OptionsListApi? optionsListApi,
    Validations? validations,
    FieldAccessibility? accessibility,
    bool? hidden,
    String? placeholder,
    String? cssClass,
    List<OnChangeEvent>? onChangeEvent,
    dynamic defaultValueLookup,
    List<dynamic>? changeEmitterFields,
    bool? mandatory,
    String? titleText,
    String? subText1,
    String? subText2,
    List<dynamic>? disableOnValues,
    List<dynamic>? toggleDisableField,
    List<OnClickEvent>? onClickEvent,
    List<dynamic>? toggleHideShow,
    String? matDirective,
    bool? isInputDisabled,
  }) =>
      FieldElement(
        readOnly: readOnly ?? this.readOnly,
        fieldType: fieldType ?? this.fieldType,
        displayName: displayName ?? this.displayName,
        logicalName: logicalName ?? this.logicalName,
        defaultValueOptionSet: defaultValueOptionSet ?? this.defaultValueOptionSet,
        optionsListApi: optionsListApi ?? this.optionsListApi,
        validations: validations ?? this.validations,
        accessibility: accessibility ?? this.accessibility,
        hidden: hidden ?? this.hidden,
        placeholder: placeholder ?? this.placeholder,
        cssClass: cssClass ?? this.cssClass,
        onChangeEvent: onChangeEvent ?? this.onChangeEvent,
        defaultValueLookup: defaultValueLookup ?? this.defaultValueLookup,
        changeEmitterFields: changeEmitterFields ?? this.changeEmitterFields,
        mandatory: mandatory ?? this.mandatory,
        titleText: titleText ?? this.titleText,
        subText1: subText1 ?? this.subText1,
        subText2: subText2 ?? this.subText2,
        disableOnValues: disableOnValues ?? this.disableOnValues,
        toggleDisableField: toggleDisableField ?? this.toggleDisableField,
        onClickEvent: onClickEvent ?? this.onClickEvent,
        toggleHideShow: toggleHideShow ?? this.toggleHideShow,
        matDirective: matDirective ?? this.matDirective,
        isInputDisabled: isInputDisabled ?? this.isInputDisabled,
      );

  factory FieldElement.fromJson(Map<String, dynamic> json) => FieldElement(
    readOnly: json["readOnly"],
    fieldType: json["fieldType"],
    displayName: json["displayName"],
    logicalName: json["logicalName"],
    defaultValueOptionSet: json["defaultValueOptionSet"] == null ? [] : List<dynamic>.from(json["defaultValueOptionSet"]!.map((x) => x)),
    optionsListApi: json["optionsListApi"] == null ? null : OptionsListApi.fromJson(json["optionsListApi"]),
    validations: json["validations"] == null ? null : Validations.fromJson(json["validations"]),
    accessibility: json["accessibility"] == null ? null : FieldAccessibility.fromJson(json["accessibility"]),
    hidden: json["hidden"],
    placeholder: json["placeholder"],
    cssClass: json["cssClass"],
    onChangeEvent: json["onChangeEvent"] == null ? [] : List<OnChangeEvent>.from(json["onChangeEvent"]!.map((x) => OnChangeEvent.fromJson(x))),
    defaultValueLookup: json["defaultValueLookup"],
    changeEmitterFields: json["changeEmitterFields"] == null ? [] : List<dynamic>.from(json["changeEmitterFields"]!.map((x) => x)),
    mandatory: json["mandatory"],
    titleText: json["titleText"],
    subText1: json["subText1"],
    subText2: json["subText2"],
    disableOnValues: json["disableOnValues"] == null ? [] : List<dynamic>.from(json["disableOnValues"]!.map((x) => x)),
    toggleDisableField: json["toggleDisableField"] == null ? [] : List<dynamic>.from(json["toggleDisableField"]!.map((x) => x)),
    onClickEvent: json["onClickEvent"] == null ? [] : List<OnClickEvent>.from(json["onClickEvent"]!.map((x) => OnClickEvent.fromJson(x))),
    toggleHideShow: json["toggleHideShow"] == null ? [] : List<dynamic>.from(json["toggleHideShow"]!.map((x) => x)),
    matDirective: json["matDirective"],
    isInputDisabled: json["isInputDisabled"],
  );

  Map<String, dynamic> toJson() => {
    "readOnly": readOnly,
    "fieldType": fieldType,
    "displayName": displayName,
    "logicalName": logicalName,
    "defaultValueOptionSet": defaultValueOptionSet == null ? [] : List<dynamic>.from(defaultValueOptionSet!.map((x) => x)),
    "optionsListApi": optionsListApi?.toJson(),
    "validations": validations?.toJson(),
    "accessibility": accessibility?.toJson(),
    "hidden": hidden,
    "placeholder": placeholder,
    "cssClass": cssClass,
    "onChangeEvent": onChangeEvent == null ? [] : List<dynamic>.from(onChangeEvent!.map((x) => x.toJson())),
    "defaultValueLookup": defaultValueLookup,
    "changeEmitterFields": changeEmitterFields == null ? [] : List<dynamic>.from(changeEmitterFields!.map((x) => x)),
    "mandatory": mandatory,
    "titleText": titleText,
    "subText1": subText1,
    "subText2": subText2,
    "disableOnValues": disableOnValues == null ? [] : List<dynamic>.from(disableOnValues!.map((x) => x)),
    "toggleDisableField": toggleDisableField == null ? [] : List<dynamic>.from(toggleDisableField!.map((x) => x)),
    "onClickEvent": onClickEvent == null ? [] : List<dynamic>.from(onClickEvent!.map((x) => x.toJson())),
    "toggleHideShow": toggleHideShow == null ? [] : List<dynamic>.from(toggleHideShow!.map((x) => x)),
    "matDirective": matDirective,
    "isInputDisabled": isInputDisabled,
  };
}

class FieldAccessibility {
  Domain? domain;
  Eligibility? eligibility;

  FieldAccessibility({
    this.domain,
    this.eligibility,
  });

  FieldAccessibility copyWith({
    Domain? domain,
    Eligibility? eligibility,
  }) =>
      FieldAccessibility(
        domain: domain ?? this.domain,
        eligibility: eligibility ?? this.eligibility,
      );

  factory FieldAccessibility.fromJson(Map<String, dynamic> json) => FieldAccessibility(
    domain: json["domain"] == null ? null : Domain.fromJson(json["domain"]),
    eligibility: json["eligibility"] == null ? null : Eligibility.fromJson(json["eligibility"]),
  );

  Map<String, dynamic> toJson() => {
    "domain": domain?.toJson(),
    "eligibility": eligibility?.toJson(),
  };
}

class Eligibility {
  String? key;
  String? value;

  Eligibility({
    this.key,
    this.value,
  });

  Eligibility copyWith({
    String? key,
    String? value,
  }) =>
      Eligibility(
        key: key ?? this.key,
        value: value ?? this.value,
      );

  factory Eligibility.fromJson(Map<String, dynamic> json) => Eligibility(
    key: json["key"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "value": value,
  };
}

class DefaultValueLookupElement {
  String? type;
  String? value;

  DefaultValueLookupElement({
    this.type,
    this.value,
  });

  DefaultValueLookupElement copyWith({
    String? type,
    String? value,
  }) =>
      DefaultValueLookupElement(
        type: type ?? this.type,
        value: value ?? this.value,
      );

  factory DefaultValueLookupElement.fromJson(Map<String, dynamic> json) => DefaultValueLookupElement(
    type: json["type"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "value": value,
  };
}

class OnChangeEvent {
  String? functionName;
  List<OnlineParam>? params;

  OnChangeEvent({
    this.functionName,
    this.params,
  });

  OnChangeEvent copyWith({
    String? functionName,
    List<OnlineParam>? params,
  }) =>
      OnChangeEvent(
        functionName: functionName ?? this.functionName,
        params: params ?? this.params,
      );

  factory OnChangeEvent.fromJson(Map<String, dynamic> json) => OnChangeEvent(
    functionName: json["functionName"],
    params: json["params"] == null ? [] : List<OnlineParam>.from(json["params"]!.map((x) => OnlineParam.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "functionName": functionName,
    "params": params == null ? [] : List<dynamic>.from(params!.map((x) => x.toJson())),
  };
}

class OnClickEvent {
  String? functionName;
  String? url;
  List<OnClickEventParam>? params;
  String? param1;

  OnClickEvent({
    this.functionName,
    this.url,
    this.params,
    this.param1,
  });

  OnClickEvent copyWith({
    String? functionName,
    String? url,
    List<OnClickEventParam>? params,
    String? param1,
  }) =>
      OnClickEvent(
        functionName: functionName ?? this.functionName,
        url: url ?? this.url,
        params: params ?? this.params,
        param1: param1 ?? this.param1,
      );

  factory OnClickEvent.fromJson(Map<String, dynamic> json) => OnClickEvent(
    functionName: json["functionName"],
    url: json["url"],
    params: json["params"] == null ? [] : List<OnClickEventParam>.from(json["params"]!.map((x) => OnClickEventParam.fromJson(x))),
    param1: json["param1"],
  );

  Map<String, dynamic> toJson() => {
    "functionName": functionName,
    "url": url,
    "params": params == null ? [] : List<dynamic>.from(params!.map((x) => x.toJson())),
    "param1": param1,
  };
}

class OnClickEventParam {
  String? key;
  String? type;
  dynamic value;
  bool? mandatory;

  OnClickEventParam({
    this.key,
    this.type,
    this.value,
    this.mandatory,
  });

  OnClickEventParam copyWith({
    String? key,
    String? type,
    dynamic value,
    bool? mandatory,
  }) =>
      OnClickEventParam(
        key: key ?? this.key,
        type: type ?? this.type,
        value: value ?? this.value,
        mandatory: mandatory ?? this.mandatory,
      );

  factory OnClickEventParam.fromJson(Map<String, dynamic> json) => OnClickEventParam(
    key: json["key"],
    type: json["type"],
    value: json["value"],
    mandatory: json["mandatory"],
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "type": type,
    "value": value,
    "mandatory": mandatory,
  };
}

class OptionsListApi {
  Backoffice? backoffice;
  Backoffice? online;

  OptionsListApi({
    this.backoffice,
    this.online,
  });

  OptionsListApi copyWith({
    Backoffice? backoffice,
    Backoffice? online,
  }) =>
      OptionsListApi(
        backoffice: backoffice ?? this.backoffice,
        online: online ?? this.online,
      );

  factory OptionsListApi.fromJson(Map<String, dynamic> json) => OptionsListApi(
    backoffice: json["backoffice"] == null ? null : Backoffice.fromJson(json["backoffice"]),
    online: json["online"] == null ? null : Backoffice.fromJson(json["online"]),
  );

  Map<String, dynamic> toJson() => {
    "backoffice": backoffice?.toJson(),
    "online": online?.toJson(),
  };
}

class Backoffice {
  String? url;
  String? type;
  List<OnlineParam>? params;
  String? displayKey;
  String? valueKey;

  Backoffice({
    this.url,
    this.type,
    this.params,
    this.displayKey,
    this.valueKey,
  });

  Backoffice copyWith({
    String? url,
    String? type,
    List<OnlineParam>? params,
    String? displayKey,
    String? valueKey,
  }) =>
      Backoffice(
        url: url ?? this.url,
        type: type ?? this.type,
        params: params ?? this.params,
        displayKey: displayKey ?? this.displayKey,
        valueKey: valueKey ?? this.valueKey,
      );

  factory Backoffice.fromJson(Map<String, dynamic> json) => Backoffice(
    url: json["url"],
    type: json["type"],
    params: json["params"] == null ? [] : List<OnlineParam>.from(json["params"]!.map((x) => OnlineParam.fromJson(x))),
    displayKey: json["displayKey"],
    valueKey: json["valueKey"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "type": type,
    "params": params == null ? [] : List<dynamic>.from(params!.map((x) => x.toJson())),
    "displayKey": displayKey,
    "valueKey": valueKey,
  };
}

class Validations {
  MaxValue? regex;
  MaxValue? minValue;
  MaxValue? maxValue;
  Length? minLength;
  Length? maxLength;
  Mandatory? mandatory;
  ValidateDateTime? validateDateTime;
  String? invalid;

  Validations({
    this.regex,
    this.minValue,
    this.maxValue,
    this.minLength,
    this.maxLength,
    this.mandatory,
    this.validateDateTime,
    this.invalid,
  });

  Validations copyWith({
    MaxValue? regex,
    MaxValue? minValue,
    MaxValue? maxValue,
    Length? minLength,
    Length? maxLength,
    Mandatory? mandatory,
    ValidateDateTime? validateDateTime,
    String? invalid,
  }) =>
      Validations(
        regex: regex ?? this.regex,
        minValue: minValue ?? this.minValue,
        maxValue: maxValue ?? this.maxValue,
        minLength: minLength ?? this.minLength,
        maxLength: maxLength ?? this.maxLength,
        mandatory: mandatory ?? this.mandatory,
        validateDateTime: validateDateTime ?? this.validateDateTime,
        invalid: invalid ?? this.invalid,
      );

  factory Validations.fromJson(Map<String, dynamic> json) => Validations(
    regex: json["regex"] == null ? null : MaxValue.fromJson(json["regex"]),
    minValue: json["minValue"] == null ? null : MaxValue.fromJson(json["minValue"]),
    maxValue: json["maxValue"] == null ? null : MaxValue.fromJson(json["maxValue"]),
    minLength: json["minLength"] == null ? null : Length.fromJson(json["minLength"]),
    maxLength: json["maxLength"] == null ? null : Length.fromJson(json["maxLength"]),
    mandatory: json["mandatory"] == null ? null : Mandatory.fromJson(json["mandatory"]),
    validateDateTime: json["validateDateTime"] == null ? null : ValidateDateTime.fromJson(json["validateDateTime"]),
    invalid: json["invalid"],
  );

  Map<String, dynamic> toJson() => {
    "regex": regex?.toJson(),
    "minValue": minValue?.toJson(),
    "maxValue": maxValue?.toJson(),
    "minLength": minLength?.toJson(),
    "maxLength": maxLength?.toJson(),
    "mandatory": mandatory?.toJson(),
    "validateDateTime": validateDateTime?.toJson(),
    "invalid": invalid,
  };
}

class Mandatory {
  String? message;
  dynamic value;

  Mandatory({
    this.message,
    this.value,
  });

  Mandatory copyWith({
    String? message,
    dynamic value,
  }) =>
      Mandatory(
        message: message ?? this.message,
        value: value ?? this.value,
      );

  factory Mandatory.fromJson(Map<String, dynamic> json) => Mandatory(
    message: json["message"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "value": value,
  };
}

class Length {
  String? message;
  dynamic value;

  Length({
    this.message,
    this.value,
  });

  Length copyWith({
    String? message,
    dynamic value,
  }) =>
      Length(
        message: message ?? this.message,
        value: value ?? this.value,
      );

  factory Length.fromJson(Map<String, dynamic> json) => Length(
    message: json["message"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "value": value,
  };
}

class MaxValue {
  String? message;
  String? value;

  MaxValue({
    this.message,
    this.value,
  });

  MaxValue copyWith({
    String? message,
    String? value,
  }) =>
      MaxValue(
        message: message ?? this.message,
        value: value ?? this.value,
      );

  factory MaxValue.fromJson(Map<String, dynamic> json) => MaxValue(
    message: json["message"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "value": value,
  };
}

class ValidateDateTime {
  String? parentField;
  String? compareDateWith;
  String? compareTimeWith;
  String? comparisonType;
  String? message;

  ValidateDateTime({
    this.parentField,
    this.compareDateWith,
    this.compareTimeWith,
    this.comparisonType,
    this.message,
  });

  ValidateDateTime copyWith({
    String? parentField,
    String? compareDateWith,
    String? compareTimeWith,
    String? comparisonType,
    String? message,
  }) =>
      ValidateDateTime(
        parentField: parentField ?? this.parentField,
        compareDateWith: compareDateWith ?? this.compareDateWith,
        compareTimeWith: compareTimeWith ?? this.compareTimeWith,
        comparisonType: comparisonType ?? this.comparisonType,
        message: message ?? this.message,
      );

  factory ValidateDateTime.fromJson(Map<String, dynamic> json) => ValidateDateTime(
    parentField: json["parentField"],
    compareDateWith: json["compareDateWith"],
    compareTimeWith: json["compareTimeWith"],
    comparisonType: json["comparisonType"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "parentField": parentField,
    "compareDateWith": compareDateWith,
    "compareTimeWith": compareTimeWith,
    "comparisonType": comparisonType,
    "message": message,
  };
}

class FormLayoutType {
  String? online;
  String? backoffice;

  FormLayoutType({
    this.online,
    this.backoffice,
  });

  FormLayoutType copyWith({
    String? online,
    String? backoffice,
  }) =>
      FormLayoutType(
        online: online ?? this.online,
        backoffice: backoffice ?? this.backoffice,
      );

  factory FormLayoutType.fromJson(Map<String, dynamic> json) => FormLayoutType(
    online: json["online"],
    backoffice: json["backoffice"],
  );

  Map<String, dynamic> toJson() => {
    "online": online,
    "backoffice": backoffice,
  };
}
