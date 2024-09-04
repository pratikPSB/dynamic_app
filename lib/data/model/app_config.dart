// To parse this JSON data, do
//
//     final appConfigModel = appConfigModelFromJson(jsonString);

import 'dart:convert';

AppConfigModel appConfigModelFromJson(String str) => AppConfigModel.fromJson(json.decode(str));

String appConfigModelToJson(AppConfigModel data) => json.encode(data.toJson());

class AppConfigModel {
  final AppTheme? appTheme;
  final List<Screen>? screens;

  AppConfigModel({
    this.appTheme,
    this.screens,
  });

  AppConfigModel copyWith({
    AppTheme? appTheme,
    List<Screen>? screens,
  }) =>
      AppConfigModel(
        appTheme: appTheme ?? this.appTheme,
        screens: screens ?? this.screens,
      );

  factory AppConfigModel.fromJson(Map<String, dynamic> json) => AppConfigModel(
        appTheme: json["app_theme"] == null ? null : AppTheme.fromJson(json["app_theme"]),
        screens: json["screens"] == null
            ? []
            : List<Screen>.from(json["screens"]!.map((x) => Screen.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "app_theme": appTheme?.toJson(),
        "screens": screens == null ? [] : List<dynamic>.from(screens!.map((x) => x.toJson())),
      };
}

class AppTheme {
  final ThemeColors? lightThemeColors;
  final ThemeColors? darkThemeColors;
  final TextStyle? textStyle;

  AppTheme({
    this.lightThemeColors,
    this.darkThemeColors,
    this.textStyle,
  });

  AppTheme copyWith({
    ThemeColors? lightThemeColors,
    ThemeColors? darkThemeColors,
    TextStyle? textStyle,
  }) =>
      AppTheme(
        lightThemeColors: lightThemeColors ?? this.lightThemeColors,
        darkThemeColors: darkThemeColors ?? this.darkThemeColors,
        textStyle: textStyle ?? this.textStyle,
      );

  factory AppTheme.fromJson(Map<String, dynamic> json) => AppTheme(
        lightThemeColors: json["light_theme_colors"] == null
            ? null
            : ThemeColors.fromJson(json["light_theme_colors"]),
        darkThemeColors: json["dark_theme_colors"] == null
            ? null
            : ThemeColors.fromJson(json["dark_theme_colors"]),
        textStyle: json["text_style"] == null ? null : TextStyle.fromJson(json["text_style"]),
      );

  Map<String, dynamic> toJson() => {
        "light_theme_colors": lightThemeColors?.toJson(),
        "dark_theme_colors": darkThemeColors?.toJson(),
        "text_style": textStyle?.toJson(),
      };
}

class ThemeColors {
  final String? primary;
  final String? secondary;
  final String? tertiary;

  ThemeColors({
    this.primary,
    this.secondary,
    this.tertiary,
  });

  ThemeColors copyWith({
    String? primary,
    String? secondary,
    String? tertiary,
  }) =>
      ThemeColors(
        primary: primary ?? this.primary,
        secondary: secondary ?? this.secondary,
        tertiary: tertiary ?? this.tertiary,
      );

  factory ThemeColors.fromJson(Map<String, dynamic> json) => ThemeColors(
        primary: json["primary"],
        secondary: json["secondary"],
        tertiary: json["tertiary"],
      );

  Map<String, dynamic> toJson() => {
        "primary": primary,
        "secondary": secondary,
        "tertiary": tertiary,
      };
}

class TextStyle {
  final String? font;
  final TbBorderStyle? tbBorderStyle;

  TextStyle({
    this.font,
    this.tbBorderStyle,
  });

  TextStyle copyWith({
    String? font,
    TbBorderStyle? tbBorderStyle,
  }) =>
      TextStyle(
        font: font ?? this.font,
        tbBorderStyle: tbBorderStyle ?? this.tbBorderStyle,
      );

  factory TextStyle.fromJson(Map<String, dynamic> json) => TextStyle(
        font: json["font"],
        tbBorderStyle: json["tb_border_style"] == null
            ? null
            : TbBorderStyle.fromJson(json["tb_border_style"]),
      );

  Map<String, dynamic> toJson() => {
        "font": font,
        "tb_border_style": tbBorderStyle?.toJson(),
      };
}

class TbBorderStyle {
  final String? borderType;
  final int? borderRadius;
  final String? borderColor;

  TbBorderStyle({
    this.borderType,
    this.borderRadius,
    this.borderColor,
  });

  TbBorderStyle copyWith({
    String? borderType,
    int? borderRadius,
    String? borderColor,
  }) =>
      TbBorderStyle(
        borderType: borderType ?? this.borderType,
        borderRadius: borderRadius ?? this.borderRadius,
        borderColor: borderColor ?? this.borderColor,
      );

  factory TbBorderStyle.fromJson(Map<String, dynamic> json) => TbBorderStyle(
        borderType: json["border_type"],
        borderRadius: json["border_radius"],
        borderColor: json["border_color"],
      );

  Map<String, dynamic> toJson() => {
        "border_type": borderType,
        "border_radius": borderRadius,
        "border_color": borderColor,
      };
}

class Screen {
  final String? id;
  final String? pageTitle;
  final List<Field>? fields;

  Screen({
    this.id,
    this.pageTitle,
    this.fields,
  });

  Screen copyWith({
    String? id,
    String? pageTitle,
    List<Field>? fields,
  }) =>
      Screen(
        id: id ?? this.id,
        pageTitle: pageTitle ?? this.pageTitle,
        fields: fields ?? this.fields,
      );

  factory Screen.fromJson(Map<String, dynamic> json) => Screen(
        id: json["id"],
        pageTitle: json["page_title"],
        fields: json["fields"] == null
            ? []
            : List<Field>.from(json["fields"]!.map((x) => Field.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "page_title": pageTitle,
        "fields": fields == null ? [] : List<dynamic>.from(fields!.map((x) => x.toJson())),
      };
}

class Field {
  final String? component;
  final String? uiComponent;
  final Field? leading;
  final Field? title;
  final String? recognizer;
  final String? path;
  final Field? subtitle;
  final Field? trailing;
  final String? label;
  final String? hint;
  final String? validationType;
  final String? inputType;
  final bool? isExpanded;
  final bool? isOptional;
  final int? minLength;
  final int? maxLength;
  final String? actionType;
  final List<Field>? childComponents;
  final List<dynamic>? valueList;
  final String? type;
  final String? text;
  final bool? callApi;
  final String? apiEndPoint;
  final String? apiType;
  final Style? style;

  Field({
    this.component,
    this.uiComponent,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.recognizer,
    this.path,
    this.label,
    this.hint,
    this.validationType,
    this.inputType,
    this.isExpanded,
    this.isOptional,
    this.minLength,
    this.maxLength,
    this.actionType,
    this.childComponents,
    this.valueList,
    this.type,
    this.text,
    this.callApi,
    this.apiEndPoint,
    this.apiType,
    this.style,
  });

  Field copyWith({
    String? component,
    String? uiComponent,
    Field? leading,
    Field? title,
    Field? subtitle,
    Field? trailing,
    String? recognizer,
    String? path,
    String? label,
    String? hint,
    String? validationType,
    String? inputType,
    bool? isExpanded,
    bool? isOptional,
    int? minLength,
    int? maxLength,
    String? actionType,
    List<Field>? childComponents,
    List<dynamic>? valueList,
    String? type,
    String? text,
    bool? callApi,
    String? apiEndPoint,
    String? apiType,
    Style? style,
  }) =>
      Field(
        component: component ?? this.component,
        uiComponent: uiComponent ?? this.uiComponent,
        leading: leading ?? this.leading,
        title: title ?? this.title,
        subtitle: subtitle ?? this.subtitle,
        trailing: trailing ?? this.trailing,
        recognizer: recognizer ?? this.recognizer,
        path: path ?? this.path,
        label: label ?? this.label,
        hint: hint ?? this.hint,
        validationType: validationType ?? this.validationType,
        inputType: inputType ?? this.inputType,
        isExpanded: isExpanded ?? this.isExpanded,
        isOptional: isOptional ?? this.isOptional,
        minLength: minLength ?? this.minLength,
        maxLength: maxLength ?? this.maxLength,
        actionType: actionType ?? this.actionType,
        childComponents: childComponents ?? this.childComponents,
        valueList: valueList ?? this.valueList,
        type: type ?? this.type,
        text: text ?? this.text,
        callApi: callApi ?? this.callApi,
        apiEndPoint: apiEndPoint ?? this.apiEndPoint,
        apiType: apiType ?? this.apiType,
        style: style ?? this.style,
      );

  factory Field.fromJson(Map<String, dynamic> json) => Field(
        component: json["component"],
        uiComponent: json["ui_component"],
        leading: json["leading"] == null ? null : Field.fromJson(json["leading"]),
        title: json["title"] == null ? null : Field.fromJson(json["title"]),
        subtitle: json["subtitle"] == null ? null : Field.fromJson(json["subtitle"]),
        trailing: json["trailing"] == null ? null : Field.fromJson(json["trailing"]),
        recognizer: json["recognizer"],
        path: json["path"],
        label: json["label"],
        hint: json["hint"],
        validationType: json["validation_type"],
        inputType: json["input_type"],
        isExpanded: json["is_expanded"],
        isOptional: json["isOptional"],
        minLength: json["min_length"],
        maxLength: json["max_length"],
        actionType: json["action_type"],
        childComponents: json["child_components"] == null
            ? []
            : List<Field>.from(json["child_components"]!.map((x) => Field.fromJson(x))),
        valueList: json["value_list"] == null
            ? []
            : List<dynamic>.from(json["value_list"]!
                .map((x) => (x is Map<String, dynamic>) ? Field.fromJson(x) : x)),
        type: json["type"],
        text: json["text"],
        callApi: json["call_api"],
        apiEndPoint: json["api_end_point"],
        apiType: json["api_type"],
        style: json["style"] == null ? null : Style.fromJson(json["style"]),
      );

  Map<String, dynamic> toJson() => {
        "component": component,
        "ui_component": uiComponent,
        "leading": leading,
        "title": title,
        "subtitle": subtitle,
        "trailing": trailing,
        "recognizer": recognizer,
        "path": path,
        "label": label,
        "hint": hint,
        "validation_type": validationType,
        "input_type": inputType,
        "is_expanded": isExpanded,
        "isOptional": isOptional,
        "min_length": minLength,
        "max_length": maxLength,
        "action_type": actionType,
        "child_components": childComponents == null
            ? []
            : List<dynamic>.from(childComponents!.map((x) => x.toJson())),
        "value_list": valueList == null ? [] : List<dynamic>.from(valueList!.map((x) => x)),
        "type": type,
        "text": text,
        "call_api": callApi,
        "api_end_point": apiEndPoint,
        "api_type": apiType,
        "style": style?.toJson(),
      };
}

class Style {
  final String? color;
  final String? decoration;
  final String? decorationColor;
  final int? height;
  final int? width;
  final int? size;

  Style({
    this.color,
    this.decoration,
    this.decorationColor,
    this.height,
    this.width,
    this.size,
  });

  Style copyWith({
    String? color,
    String? decoration,
    String? decorationColor,
    int? height,
    int? width,
    int? size,
  }) =>
      Style(
        color: color ?? this.color,
        decoration: decoration ?? this.decoration,
        decorationColor: decorationColor ?? this.decorationColor,
        height: height ?? this.height,
        width: width ?? this.width,
        size: size ?? this.size,
      );

  factory Style.fromJson(Map<String, dynamic> json) => Style(
        height: json["height"],
        width: json["width"],
        size: json["size"],
        color: json["color"],
        decoration: json["decoration"],
        decorationColor: json["decoration_color"],
      );

  Map<String, dynamic> toJson() => {
        "color": color,
        "decoration": decoration,
        "decoration_color": decorationColor,
        "height": height,
        "width": width,
        "size": size,
      };
}
