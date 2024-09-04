import 'package:firebase_remote_config/firebase_remote_config.dart';

import '../../utils/logger.dart';

class FirebaseRemoteConfigKeys {
  static const String appConfig = 'app_config';
}

class FirebaseRemoteConfigService {
  final FirebaseRemoteConfig _remoteConfig; // NEW

  FirebaseRemoteConfigService._() : _remoteConfig = FirebaseRemoteConfig.instance; // MODIFIED

  static FirebaseRemoteConfigService? _instance; // NEW
  factory FirebaseRemoteConfigService() => _instance ??= FirebaseRemoteConfigService._(); // NEW

  Future<void> _setConfigSettings() async => _remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(minutes: 1),
          minimumFetchInterval: const Duration(microseconds: 0),
        ),
      );

  Future<void> _setDefaults() async => _remoteConfig.setDefaults(
        const {
          FirebaseRemoteConfigKeys.appConfig:
              "{\"android_app_version\":18,\"ios_app_version\":\"1.0.8\",\"force_update\":false,\"application_base_url\":\"https://vfs-vfwhl.synovergetech.com/\",\"e_token_base_url\":\"https://feedback.vfsglobal.com/EITSETokenUAT/ETokenGeneration/\",\"appointment_url\":\"https://lift-api.vfsglobal.com/\",\"appointment_url_origin\":\"https://visa.vfsglobal.com/\",\"appointment_url_authority\":\"lift-api.vfsglobal.com\",\"track_url\":\"https://lift.vfsglobal.com/PG-Component/API/PGComponent/TrackPaymentStatus/\",\"dev_public_URL\":\"https://vfs-vfwhl.synovergetech.com/home/webpage?pageCategoryId\u003d\",\"country_config\":[{\"country\":\"Dubai\",\"code\":\"ARE\",\"chatbot_base_url\":\"https://vfseu.mioot.com/\",\"ams_access\":true,\"chatbot_access\":true,\"face_liveliness_access\":false,\"recaptcha_login_access\":false,\"recaptcha_appointment_access\":false,\"dm_visa\":true,\"dm_piazza_italia\":true,\"dm_for_italian_citizens\":true,\"dm_etoken\":false,\"chatbot_request_body\":[{\"country_from\":\"ARE\",\"country_to\":\"ITA\",\"language_code\":\"ar\"},{\"country_from\":\"ARE\",\"country_to\":\"ITA\",\"language_code\":\"en\"}]},{\"country\":\"Mozambique\",\"code\":\"MOZ\",\"chatbot_base_url\":\"https://vfs.mioot.com/\",\"ams_access\":false,\"chatbot_access\":true,\"face_liveliness_access\":false,\"recaptcha_login_access\":false,\"recaptcha_appointment_access\":false,\"dm_visa\":true,\"dm_piazza_italia\":true,\"dm_for_italian_citizens\":true,\"dm_etoken\":false,\"chatbot_request_body\":[{\"country_from\":\"MOZ\",\"country_to\":\"ITA\",\"language_code\":\"pt\"},{\"country_from\":\"MOZ\",\"country_to\":\"ITA\",\"language_code\":\"it\"},{\"country_from\":\"MOZ\",\"country_to\":\"ITA\",\"language_code\":\"en\"}]},{\"country\":\"Azerbaijan\",\"code\":\"AZE\",\"chatbot_base_url\":\"https://vfs.mioot.com/\",\"ams_access\":true,\"chatbot_access\":true,\"face_liveliness_access\":false,\"recaptcha_login_access\":false,\"recaptcha_appointment_access\":false,\"dm_visa\":true,\"dm_piazza_italia\":true,\"dm_for_italian_citizens\":true,\"dm_etoken\":false,\"chatbot_request_body\":[{\"country_from\":\"AZE\",\"country_to\":\"ITA\",\"language_code\":\"az\"},{\"country_from\":\"AZE\",\"country_to\":\"ITA\",\"language_code\":\"it\"},{\"country_from\":\"AZE\",\"country_to\":\"ITA\",\"language_code\":\"en\"}]},{\"country\":\"Algeria\",\"code\":\"DZA\",\"chatbot_base_url\":\"https://vfs.mioot.com/\",\"ams_access\":true,\"chatbot_access\":true,\"face_liveliness_access\":true,\"recaptcha_login_access\":true,\"recaptcha_appointment_access\":true,\"dm_visa\":true,\"dm_piazza_italia\":true,\"dm_for_italian_citizens\":true,\"dm_etoken\":false,\"chatbot_request_body\":[{\"country_from\":\"DZA\",\"country_to\":\"ITA\",\"language_code\":\"en\"},{\"country_from\":\"DZA\",\"country_to\":\"ITA\",\"language_code\":\"ar\"},{\"country_from\":\"DZA\",\"country_to\":\"ITA\",\"language_code\":\"fr\"},{\"country_from\":\"DZA\",\"country_to\":\"ITA\",\"language_code\":\"it\"}]},{\"country\":\"Morocco\",\"code\":\"MAR\",\"chatbot_base_url\":\"https://vfs.mioot.com/\",\"ams_access\":true,\"chatbot_access\":true,\"face_liveliness_access\":false,\"recaptcha_login_access\":false,\"recaptcha_appointment_access\":false,\"dm_visa\":true,\"dm_piazza_italia\":true,\"dm_for_italian_citizens\":true,\"dm_etoken\":false,\"chatbot_request_body\":[{\"country_from\":\"MAR\",\"country_to\":\"ITA\",\"language_code\":\"en\"},{\"country_from\":\"MAR\",\"country_to\":\"ITA\",\"language_code\":\"ar\"},{\"country_from\":\"MAR\",\"country_to\":\"ITA\",\"language_code\":\"fr\"},{\"country_from\":\"MAR\",\"country_to\":\"ITA\",\"language_code\":\"it\"}]},{\"country\":\"India\",\"code\":\"IND\",\"chatbot_base_url\":\"https://vfseu.mioot.com/\",\"ams_access\":false,\"chatbot_access\":true,\"face_liveliness_access\":false,\"recaptcha_login_access\":false,\"recaptcha_appointment_access\":false,\"dm_visa\":true,\"dm_piazza_italia\":true,\"dm_for_italian_citizens\":true,\"dm_etoken\":false,\"chatbot_request_body\":[{\"country_from\":\"IND\",\"country_to\":\"ITA\",\"language_code\":\"en\"}]},{\"country\":\"South Africa\",\"code\":\"ZAF\",\"chatbot_base_url\":\"https://vfseu.mioot.com/\",\"ams_access\":true,\"chatbot_access\":true,\"face_liveliness_access\":false,\"recaptcha_login_access\":false,\"recaptcha_appointment_access\":false,\"dm_visa\":true,\"dm_piazza_italia\":true,\"dm_for_italian_citizens\":true,\"dm_etoken\":false,\"chatbot_request_body\":[{\"country_from\":\"ZAF\",\"country_to\":\"ITA\",\"language_code\":\"en\"}]},{\"country\":\"Kuwait\",\"code\":\"KWT\",\"chatbot_base_url\":\"https://vfseu.mioot.com/\",\"ams_access\":true,\"chatbot_access\":true,\"face_liveliness_access\":false,\"recaptcha_login_access\":false,\"recaptcha_appointment_access\":false,\"dm_visa\":true,\"dm_piazza_italia\":true,\"dm_for_italian_citizens\":true,\"dm_etoken\":false,\"chatbot_request_body\":[{\"country_from\":\"KWT\",\"country_to\":\"ITA\",\"language_code\":\"en\"}]},{\"country\":\"Bangladesh\",\"code\":\"BGD\",\"chatbot_base_url\":\"https://vfs.mioot.com/\",\"ams_access\":false,\"chatbot_access\":true,\"face_liveliness_access\":false,\"recaptcha_login_access\":false,\"recaptcha_appointment_access\":false,\"dm_visa\":true,\"dm_piazza_italia\":true,\"dm_for_italian_citizens\":true,\"dm_etoken\":false,\"chatbot_request_body\":[{\"country_from\":\"BGD\",\"country_to\":\"ITA\",\"language_code\":\"en\"}]},{\"country\":\"Philippines\",\"code\":\"PHL\",\"chatbot_base_url\":\"https://vfs.mioot.com/\",\"ams_access\":true,\"chatbot_access\":true,\"face_liveliness_access\":false,\"recaptcha_login_access\":false,\"recaptcha_appointment_access\":false,\"dm_visa\":true,\"dm_piazza_italia\":true,\"dm_for_italian_citizens\":true,\"dm_etoken\":false,\"chatbot_request_body\":[{\"country_from\":\"PHL\",\"country_to\":\"ITA\",\"language_code\":\"en\"}]},{\"country\":\"Kenya\",\"code\":\"KEN\",\"chatbot_base_url\":\"https://vfs.mioot.com/\",\"ams_access\":true,\"chatbot_access\":true,\"face_liveliness_access\":false,\"recaptcha_login_access\":false,\"recaptcha_appointment_access\":false,\"dm_visa\":true,\"dm_piazza_italia\":true,\"dm_for_italian_citizens\":true,\"dm_etoken\":false,\"chatbot_request_body\":[{\"country_from\":\"KEN\",\"country_to\":\"ITA\",\"language_code\":\"en\"}]},{\"country\":\"Thailand\",\"code\":\"THA\",\"chatbot_base_url\":\"\",\"ams_access\":true,\"chatbot_access\":false,\"face_liveliness_access\":false,\"recaptcha_login_access\":false,\"recaptcha_appointment_access\":false,\"dm_visa\":true,\"dm_piazza_italia\":true,\"dm_for_italian_citizens\":true,\"dm_etoken\":false,\"chatbot_request_body\":[{\"country_from\":\"THA\",\"country_to\":\"ITA\",\"language_code\":\"en\"},{\"country_from\":\"THA\",\"country_to\":\"ITA\",\"language_code\":\"it\"},{\"country_from\":\"THA\",\"country_to\":\"ITA\",\"language_code\":\"th\"}]},{\"country\":\"Indonesia\",\"code\":\"IDN\",\"chatbot_base_url\":\"https://vfs.mioot.com/\",\"ams_access\":true,\"chatbot_access\":true,\"face_liveliness_access\":false,\"recaptcha_login_access\":false,\"recaptcha_appointment_access\":false,\"dm_visa\":true,\"dm_piazza_italia\":true,\"dm_for_italian_citizens\":true,\"dm_etoken\":false,\"chatbot_request_body\":[{\"country_from\":\"IDN\",\"country_to\":\"ITA\",\"language_code\":\"en\"}]}]}",
        },
      );

  Future<void> _fetchAndActivate() async {
    bool updated = await _remoteConfig.fetchAndActivate();
    if (updated) {
      Logger.doLog('The config has been fetched.');
    } else {
      Logger.doLog('The config is not updated.');
    }
  }

  bool isUpdated = false;

  Future<void> _registerListener() async {
    _remoteConfig.onConfigUpdated.listen((event) async {
      bool activated = await _remoteConfig.activate();
      if (activated) {
        isUpdated = true;
        Logger.doLog('The config has been updated.');
      } else {
        Logger.doLog('The config is not updated.');
      }
    });
  }

  Future<void> initialize() async {
    await _setConfigSettings();
    await _setDefaults();
    await _fetchAndActivate();
    await _registerListener();
  }

  String getString(String key) => _remoteConfig.getString(key); // NEW
  bool getBool(String key) => _remoteConfig.getBool(key); // NEW
  int getInt(String key) => _remoteConfig.getInt(key); // NEW
  double getDouble(String key) => _remoteConfig.getDouble(key); // NEW
}
