import 'package:firebase_core/firebase_core.dart';
import 'package:flex_seed_scheme/flex_seed_scheme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vfs_dynamic_app/common_page.dart';
import 'package:vfs_dynamic_app/data/model/app_config.dart' hide TextStyle, Screen;
import 'package:vfs_dynamic_app/data/model/app_config_new.dart';
import 'package:vfs_dynamic_app/data/utils/extensions.dart';
import 'package:vfs_dynamic_app/data/utils/logger.dart';
import 'package:vfs_dynamic_app/data/utils/prefs_utils.dart';
import 'package:vfs_dynamic_app/unknown_page.dart';

import 'data/constants/const_functions.dart';
import 'data/services/remote_config_service/firebase_remote_config_service.dart';
import 'data/utils/size_config.dart';
import 'data/utils/theme_utils.dart';
import 'firebase_options.dart';

AppConfigModel? appConfigModel;
AppConfigNewModel? appConfigNewModel;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseRemoteConfigService().initialize();
  Prefs().initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ThemeUtils.notifier.value = ThemeUtils.getThemeMode();
    ThemeUtils.changeTheme(false);
    ConstFunctions.enableHapticFeedback();

    String appConfigString = FirebaseRemoteConfigService().getString(FirebaseRemoteConfigKeys.appConfig);
    appConfigModel = appConfigModelFromJson(appConfigString);

    String appConfigNewString = FirebaseRemoteConfigService().getString(FirebaseRemoteConfigKeys.appConfigNew);
    appConfigNewModel = appConfigNewModelFromJson(appConfigNewString);

    ColorScheme lightColorScheme = SeedColorScheme.fromSeeds(
      brightness: Brightness.light,
      primaryKey: Color(appConfigModel!.appTheme!.lightThemeColors!.primary!.getColorHexFromStr()),
      secondaryKey:
          Color(appConfigModel!.appTheme!.lightThemeColors!.secondary!.getColorHexFromStr()),
      tertiaryKey: Color(appConfigModel!.appTheme!.lightThemeColors!.tertiary!.getColorHexFromStr()),
      tones: FlexTones.vivid(Brightness.light),
    );

    ColorScheme darkColorScheme = SeedColorScheme.fromSeeds(
      brightness: Brightness.dark,
      primaryKey: Color(appConfigModel!.appTheme!.darkThemeColors!.primary!.getColorHexFromStr()),
      secondaryKey:
          Color(appConfigModel!.appTheme!.darkThemeColors!.secondary!.getColorHexFromStr()),
      tertiaryKey: Color(appConfigModel!.appTheme!.darkThemeColors!.tertiary!.getColorHexFromStr()),
      tones: FlexTones.vivid(Brightness.dark),
    );

    TextStyle styleLight = GoogleFonts.getFont(appConfigModel!.appTheme!.textStyle!.font!).copyWith(
      color: Colors.black,
    );

    TextStyle styleDark = GoogleFonts.getFont(appConfigModel!.appTheme!.textStyle!.font!).copyWith(
      color: Colors.white,
    );

    final router = createGoRouter(appConfigNewModel!.screens!);

    return ValueListenableBuilder(
      valueListenable: ThemeUtils.notifier,
      builder: (_, themeMode, __) {
        return LayoutBuilder(builder: (context, constraints) {
          return OrientationBuilder(builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              theme: ThemeUtils.getTheme(
                context: context,
                colorScheme: lightColorScheme,
                textStyle: styleLight,
                configTextStyle: appConfigModel!.appTheme!.textStyle!,
              ),
              darkTheme: ThemeUtils.getTheme(
                  context: context,
                  colorScheme: darkColorScheme,
                  textStyle: styleDark,
                  configTextStyle: appConfigModel!.appTheme!.textStyle!),
              themeMode: themeMode,
              title: 'Flutter Demo',
              routerConfig: router,
            );
          });
        });
      },
    );
  }

  GoRouter createGoRouter(List<Screen> screensList) {
    return GoRouter(
      initialLocation: screensList[0].route, // Set the initial route dynamically if needed
      routes: screensList.map<GoRoute>((screenData) {
        String routeName = screenData.route!;
        Logger.doLog(routeName);
        return GoRoute(
          path: routeName,
          builder: (context, state) => CommonPage(
            title: screenData.title!,
            screenData: screenData,
          ),
        );
      }).toList(),

      // Handling unknown routes
      errorPageBuilder: (context, state) => const MaterialPage<void>(
        child: UnknownPage(),
      ),
    );
  }
}
