// To parse this JSON data, do
//
//     final appConfigModel = appConfigModelFromJson(jsonString);

import 'dart:convert';

AppConfigModel appConfigModelFromJson(String str) => AppConfigModel.fromJson(json.decode(str));

String appConfigModelToJson(AppConfigModel data) => json.encode(data.toJson());

class AppConfigModel {
  final AppTheme? appTheme;
  final AppConfigData? appConfigData;

  AppConfigModel({
    this.appTheme,
    this.appConfigData,
  });

  AppConfigModel copyWith({
    AppTheme? appTheme,
    AppConfigData? appConfigData,
  }) =>
      AppConfigModel(
        appTheme: appTheme ?? this.appTheme,
        appConfigData: appConfigData ?? this.appConfigData,
      );

  factory AppConfigModel.fromJson(Map<String, dynamic> json) => AppConfigModel(
    appTheme: json["app_theme"] == null ? null : AppTheme.fromJson(json["app_theme"]),
    appConfigData: json["app_config_data"] == null ? null : AppConfigData.fromJson(json["app_config_data"]),
  );

  Map<String, dynamic> toJson() => {
    "app_theme": appTheme?.toJson(),
    "app_config_data": appConfigData?.toJson(),
  };
}

class AppConfigData {
  final int? androidAppVersion;
  final String? iosAppVersion;
  final bool? forceUpdate;
  final String? applicationBaseUrl;
  final String? eTokenBaseUrl;
  final String? appointmentUrl;
  final String? appointmentUrlOrigin;
  final String? appointmentUrlAuthority;
  final String? trackUrl;
  final String? devPublicUrl;
  final String? imageUrl;

  AppConfigData({
    this.androidAppVersion,
    this.iosAppVersion,
    this.forceUpdate,
    this.applicationBaseUrl,
    this.eTokenBaseUrl,
    this.appointmentUrl,
    this.appointmentUrlOrigin,
    this.appointmentUrlAuthority,
    this.trackUrl,
    this.devPublicUrl,
    this.imageUrl,
  });

  AppConfigData copyWith({
    int? androidAppVersion,
    String? iosAppVersion,
    bool? forceUpdate,
    String? applicationBaseUrl,
    String? eTokenBaseUrl,
    String? appointmentUrl,
    String? appointmentUrlOrigin,
    String? appointmentUrlAuthority,
    String? trackUrl,
    String? devPublicUrl,
    String? imageUrl,
  }) =>
      AppConfigData(
        androidAppVersion: androidAppVersion ?? this.androidAppVersion,
        iosAppVersion: iosAppVersion ?? this.iosAppVersion,
        forceUpdate: forceUpdate ?? this.forceUpdate,
        applicationBaseUrl: applicationBaseUrl ?? this.applicationBaseUrl,
        eTokenBaseUrl: eTokenBaseUrl ?? this.eTokenBaseUrl,
        appointmentUrl: appointmentUrl ?? this.appointmentUrl,
        appointmentUrlOrigin: appointmentUrlOrigin ?? this.appointmentUrlOrigin,
        appointmentUrlAuthority: appointmentUrlAuthority ?? this.appointmentUrlAuthority,
        trackUrl: trackUrl ?? this.trackUrl,
        devPublicUrl: devPublicUrl ?? this.devPublicUrl,
        imageUrl: imageUrl ?? this.imageUrl,
      );

  factory AppConfigData.fromJson(Map<String, dynamic> json) => AppConfigData(
    androidAppVersion: json["android_app_version"],
    iosAppVersion: json["ios_app_version"],
    forceUpdate: json["force_update"],
    applicationBaseUrl: json["application_base_url"],
    eTokenBaseUrl: json["e_token_base_url"],
    appointmentUrl: json["appointment_url"],
    appointmentUrlOrigin: json["appointment_url_origin"],
    appointmentUrlAuthority: json["appointment_url_authority"],
    trackUrl: json["track_url"],
    devPublicUrl: json["dev_public_URL"],
    imageUrl: json["image_url"],
  );

  Map<String, dynamic> toJson() => {
    "android_app_version": androidAppVersion,
    "ios_app_version": iosAppVersion,
    "force_update": forceUpdate,
    "application_base_url": applicationBaseUrl,
    "e_token_base_url": eTokenBaseUrl,
    "appointment_url": appointmentUrl,
    "appointment_url_origin": appointmentUrlOrigin,
    "appointment_url_authority": appointmentUrlAuthority,
    "track_url": trackUrl,
    "dev_public_URL": devPublicUrl,
    "image_url": imageUrl,
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
    lightThemeColors: json["light_theme_colors"] == null ? null : ThemeColors.fromJson(json["light_theme_colors"]),
    darkThemeColors: json["dark_theme_colors"] == null ? null : ThemeColors.fromJson(json["dark_theme_colors"]),
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
    tbBorderStyle: json["tb_border_style"] == null ? null : TbBorderStyle.fromJson(json["tb_border_style"]),
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
