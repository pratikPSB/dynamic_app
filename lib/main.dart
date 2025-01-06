import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flex_seed_scheme/flex_seed_scheme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vfs_dynamic_app/data/model/app_config_model.dart' hide TextStyle;
import 'package:vfs_dynamic_app/data/model/app_modules_by_client_model.dart';
import 'package:vfs_dynamic_app/data/utils/extensions.dart';
import 'package:vfs_dynamic_app/data/utils/fallback_cupertino_localization_delegate.dart';
import 'package:vfs_dynamic_app/data/utils/fallback_material_localization_delegate.dart';
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
List<Module> screensList = List.empty(growable: true);
Map<String, dynamic> appStringMap = {};

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseRemoteConfigService().initialize();
  await EncryptionUtils().initialize();
  await Prefs().initialize();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  late ColorScheme lightColorScheme;
  late ColorScheme darkColorScheme;
  late TextStyle styleLight;
  late TextStyle styleDark;
  late GoRouter router;
  Map<String, dynamic> appLocale = {};
  List<dynamic> appStrings = List.empty(growable: true);

  @override
  void initState() {
    String appConfigString =
        FirebaseRemoteConfigService().getString(FirebaseRemoteConfigKeys.appConfig);
    appConfigModel = appConfigModelFromJson(appConfigString);

    liveServerService = DioService(baseUrl: appConfigModel!.appConfigData!.applicationBaseUrl!);
    mockServerService = DioService(baseUrl: appConfigModel!.appConfigData!.mockServerUrl!);

    String appConfigNewString =
        FirebaseRemoteConfigService().getString(FirebaseRemoteConfigKeys.appModulesByClient);
    appScreensModel = appModuleByClientModelFromJson(appConfigNewString);

    String appStringsRes =
        FirebaseRemoteConfigService().getString(FirebaseRemoteConfigKeys.appStrings);
    appLocale = json.decode(appStringsRes);
    appStrings = appLocale["app_strings"];
    Logger.doLog(appLocale["app_strings"]);

    lightColorScheme = SeedColorScheme.fromSeeds(
      brightness: Brightness.light,
      primary: Color("#F85B30".getColorHexFromStr()),
      primaryKey: Color(appConfigModel!.appTheme!.lightThemeColors!.primary!.getColorHexFromStr()),
      secondaryKey:
          Color(appConfigModel!.appTheme!.lightThemeColors!.secondary!.getColorHexFromStr()),
      tertiaryKey:
          Color(appConfigModel!.appTheme!.lightThemeColors!.tertiary!.getColorHexFromStr()),
      tones: FlexTones.vivid(Brightness.light),
    );

    darkColorScheme = SeedColorScheme.fromSeeds(
      brightness: Brightness.dark,
      primary: Color("#F85B30".getColorHexFromStr()),
      primaryKey: Color(appConfigModel!.appTheme!.darkThemeColors!.primary!.getColorHexFromStr()),
      secondaryKey:
          Color(appConfigModel!.appTheme!.darkThemeColors!.secondary!.getColorHexFromStr()),
      tertiaryKey: Color(appConfigModel!.appTheme!.darkThemeColors!.tertiary!.getColorHexFromStr()),
      tones: FlexTones.vivid(Brightness.dark),
    );

    styleLight = GoogleFonts.getFont(appConfigModel!.appTheme!.textStyle!.font!).copyWith(
      color: Colors.black,
    );

    styleDark = GoogleFonts.getFont(appConfigModel!.appTheme!.textStyle!.font!).copyWith(
      color: Colors.white,
    );

    router = createGoRouter(appScreensModel!.modules!);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeUtils.notifier.value = ThemeUtils.getThemeMode();
    ThemeUtils.changeTheme(true);
    ThemeUtils.changeLocale("en");
    ConstFunctions.enableHapticFeedback();

    return AnimatedBuilder(
      animation: Listenable.merge([ThemeUtils.notifier, ThemeUtils.locale]),
      builder: (context, child) {
        appStringMap = appStrings.firstWhere(
          (element) {
            return element["lang_code"] == ThemeUtils.locale.value;
          },
          orElse: () => appStrings.firstWhere(
            (element) => element["lang_code"] == "en",
          ),
        );
        Logger.doLog(appStringMap["lang_code"]);
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
              supportedLocales: (appLocale["supported_languages"] as List<dynamic>).map(
                (localeCode) {
                  return Locale(localeCode);
                },
              ).toList(),
              locale: Locale(ThemeUtils.locale.value),
              localizationsDelegates: [
                FallbackMaterialLocalizationDelegate(),
                FallbackCupertinoLocalizationDelegate(),
              ],
              darkTheme: ThemeUtils.getTheme(
                  context: context,
                  colorScheme: darkColorScheme,
                  textStyle: styleDark,
                  configTextStyle: appConfigModel!.appTheme!.textStyle!),
              themeMode: ThemeUtils.notifier.value,
              title: 'Flutter Demo',
              routerConfig: router,
            );
          });
        });
      },
    );
  }

  GoRouter createGoRouter(List<Module> moduleList) {
    moduleList.sort(
      (a, b) => a.displayPosition!.compareTo(b.displayPosition!),
    );
    screensList.addAll(moduleList);
    var routesList = <GoRoute>[];
    routesList.add(GoRoute(
      path: "/dashboard",
      builder: (context, state) => DashboardPage(moduleList: screensList),
    ));

    routesList.addAll(screensList.map<GoRoute>((screenData) {
      String routeName = "/${screenData.routeUrl!}";
      Logger.doLog(routeName);
      return GoRoute(
        path: routeName,
        pageBuilder: (context, state) => CustomTransitionPage(
          child: CommonPage(
            title: appStringMap[screenData.displayName] ?? screenData.displayName!,
            screenData: screenData,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0); // Start from the right
            const end = Offset.zero; // End at the center (current screen)
            const curve = Curves.easeInOut;

            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
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
