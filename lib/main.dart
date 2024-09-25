import 'package:firebase_core/firebase_core.dart';
import 'package:flex_seed_scheme/flex_seed_scheme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vfs_dynamic_app/data/model/app_config_model.dart' hide TextStyle;
import 'package:vfs_dynamic_app/data/model/app_modules_by_client_model.dart';
import 'package:vfs_dynamic_app/data/utils/extensions.dart';
import 'package:vfs_dynamic_app/data/utils/logger.dart';
import 'package:vfs_dynamic_app/data/utils/prefs_utils.dart';
import 'package:vfs_dynamic_app/module/common_page.dart';
import 'package:vfs_dynamic_app/module/dashboard_page.dart';
import 'package:vfs_dynamic_app/module/unknown_page.dart';

import 'data/constants/const_functions.dart';
import 'data/services/api_service/api_client.dart';
import 'data/services/remote_config_service/firebase_remote_config_service.dart';
import 'data/utils/encrypt_decrypt_rsa.dart';
import 'data/utils/size_config.dart';
import 'data/utils/theme_utils.dart';
import 'firebase_options.dart';

AppConfigModel? appConfigModel;
AppModuleByClientModel? appScreensModel;
late DioService liveServerService;
late DioService mockServerService;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseRemoteConfigService().initialize();
  await EncryptionUtils().initialize();
  await Prefs().initialize();
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

    String appConfigString =
        FirebaseRemoteConfigService().getString(FirebaseRemoteConfigKeys.appConfig);
    appConfigModel = appConfigModelFromJson(appConfigString);

    liveServerService = DioService(baseUrl: appConfigModel!.appConfigData!.applicationBaseUrl!);
    mockServerService = DioService(baseUrl: appConfigModel!.appConfigData!.mockServerUrl!);

    String appConfigNewString =
        FirebaseRemoteConfigService().getString(FirebaseRemoteConfigKeys.appModulesByClient);
    appScreensModel = appModuleByClientModelFromJson(appConfigNewString);

    ColorScheme lightColorScheme = SeedColorScheme.fromSeeds(
      brightness: Brightness.light,
      primaryKey: Color(appConfigModel!.appTheme!.lightThemeColors!.primary!.getColorHexFromStr()),
      secondaryKey:
          Color(appConfigModel!.appTheme!.lightThemeColors!.secondary!.getColorHexFromStr()),
      tertiaryKey:
          Color(appConfigModel!.appTheme!.lightThemeColors!.tertiary!.getColorHexFromStr()),
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

    final router = createGoRouter(appScreensModel!.modules!);

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

  GoRouter createGoRouter(List<Module> screensList) {
    screensList.sort(
      (a, b) => a.displayPosition!.compareTo(b.displayPosition!),
    );
    var routesList = <GoRoute>[];
    routesList.add(GoRoute(
      path: "/dashboard",
      builder: (context, state) => DashboardPage(moduleList:screensList),
    ));
    routesList.addAll(screensList.map<GoRoute>((screenData) {
      String routeName = "/${screenData.routeUrl!}";
      Logger.doLog(routeName);
      return GoRoute(
        path: routeName,
        builder: (context, state) => CommonPage(
          title: screenData.displayName!,
          screenData: screenData,
        ),
      );
    }).toList());

    return GoRouter(
      initialLocation: "/dashboard",
      // Set the initial route dynamically if needed
      routes: routesList,
      // Handling unknown routes
      errorPageBuilder: (context, state) => const MaterialPage<void>(
        child: UnknownPage(),
      ),
    );
  }
}
