import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:vfs_dynamic_app/data/model/app_config.dart' as app_config_model;
import 'package:vfs_dynamic_app/data/utils/extensions.dart';
import 'package:vfs_dynamic_app/data/utils/prefs_utils.dart';

import '../constants/const_keys.dart';

class AppColors {
  static const Color primaryColorDark = Color(0xff02224C);
  static const Color primaryColor = Color(0xff5c8dba);
  static const Color white = Color(0xffffffff);
  static const Color black = Color(0xff000000);
  static const Color primaryColorTrans = Color(0x80000000);

  static const Color primaryDarkColor = Color(0x80800000);
  static const Color shareBorder = Color(0xFFFFCCDF);
  static const Color deleteBorder = Color(0xFFFEDCDC);
  static const Color updateBorder = Color(0xFFFCDCF3);
  static const Color payoutBorder = Color(0xFFD2EDFC);

  static const Color redDull = Color(0xFFFF767B);
  static const Color grayOr = Color(0xFFD7D7D7);
  static const Color grayPicBg = Color(0xFFE5E5E5);
  static const Color grayDark = Color(0xFF9D9898);
  static const Color grayLight = Color(0xFFE5E5E5);
  static const Color inputTextColor = Color(0xFF747688);
  static const Color buttonSecondaryColor = Color(0xFF861A54);
}

class ThemeUtils {
  static const PageTransitionsTheme pageTransitionsTheme = PageTransitionsTheme(builders: {
    TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
    TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
    TargetPlatform.windows: ZoomPageTransitionsBuilder(),
    TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
    TargetPlatform.fuchsia: FadeUpwardsPageTransitionsBuilder(),
  });

  static ThemeData getTheme(
      {required BuildContext context,
      required ColorScheme colorScheme,
      required TextStyle textStyle,
      required app_config_model.TextStyle configTextStyle}) {
    return ThemeData(
      brightness: colorScheme.brightness,
      colorScheme: colorScheme,
      textTheme: context.getTheme().textTheme.copyWith(
            displayLarge: textStyle,
            displayMedium: textStyle,
            displaySmall: textStyle,
            headlineLarge: textStyle,
            headlineMedium: textStyle,
            headlineSmall: textStyle,
            titleLarge: textStyle,
            titleMedium: textStyle,
            titleSmall: textStyle,
            bodyLarge: textStyle,
            bodyMedium: textStyle,
            bodySmall: textStyle,
            labelLarge: textStyle,
            labelMedium: textStyle,
            labelSmall: textStyle,
          ),
      useMaterial3: true,
      pageTransitionsTheme: pageTransitionsTheme,
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: (colorScheme.brightness == Brightness.light)
            ? colorScheme.secondaryContainer
            : colorScheme.surface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.only(
            topStart: Radius.circular(30),
            topEnd: Radius.circular(30),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: (configTextStyle.tbBorderStyle!.borderType! == "box")
            ? OutlineInputBorder(
                borderRadius: configTextStyle.tbBorderStyle!.borderRadius!.modifyCorners(),
                borderSide: BorderSide(
                  color: (configTextStyle.tbBorderStyle!.borderColor != null)
                      ? Color(
                          configTextStyle.tbBorderStyle!.borderColor!.getColorHexFromStr(),
                        )
                      : colorScheme.primary,
                ),
              )
            : UnderlineInputBorder(
                borderRadius: configTextStyle.tbBorderStyle!.borderRadius!.modifyCorners(),
                borderSide: BorderSide(
                  color: (configTextStyle.tbBorderStyle!.borderColor != null)
                      ? Color(
                          configTextStyle.tbBorderStyle!.borderColor!.getColorHexFromStr(),
                        )
                      : colorScheme.primary,
                ),
              ),
        floatingLabelAlignment: FloatingLabelAlignment.start,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
    );
  }

  static final ValueNotifier<ThemeMode> notifier = ValueNotifier(ThemeMode.system);

  static void changeTheme(bool setLightTheme) {
    Prefs().setBoolean(ConstKeys.prefKeyTheme, setLightTheme);
    notifier.value = setLightTheme ? ThemeMode.light : ThemeMode.dark;
  }

  static ThemeMode getThemeMode() {
    if (Prefs().contains(ConstKeys.prefKeyTheme)) {
      final isLightTheme = Prefs().getBoolean(ConstKeys.prefKeyTheme);
      return isLightTheme ? ThemeMode.light : ThemeMode.dark;
    } else {
      return ThemeMode.system;
    }
  }

  static bool isDarkModeEnabled() {
    ThemeMode themeMode = ThemeUtils.getThemeMode();
    if (themeMode == ThemeMode.light) {
      return false;
    } else if (themeMode == ThemeMode.dark) {
      return true;
    } else {
      var brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
      return brightness == Brightness.dark;
    }
  }
}
