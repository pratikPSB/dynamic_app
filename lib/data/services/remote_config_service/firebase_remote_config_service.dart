import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

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
          "{\"app_theme\":{\"light_theme_colors\":{\"primary\":\"02224C\",\"secondary\":\"5c8dba\",\"tertiary\":\"02224C\"},\"dark_theme_colors\":{\"primary\":\"5c8dba\",\"secondary\":\"02224C\",\"tertiary\":\"02224C\"},\"text_style\":{\"font\":\"Puritan\",\"tb_border_style\":{\"border_type\":\"box\",\"border_radius\":10,\"border_color\":\"ff0000\"}}},\"screens\":[{\"id\":\"login_screen\",\"page_title\":\"Login\",\"fields\":[{\"component\":\"TextBox\",\"ui_component\":\"edit_text\",\"label\":\"Email address\",\"hint\":\"Type Email address...\",\"validation_type\":\"email\",\"input_type\":\"email_address\",\"is_expanded\":true,\"isOptional\":true,\"min_length\":0,\"max_length\":0,\"action_type\":\"action_next\",\"style\":{\"height\":0,\"width\":0,\"size\":0}},{\"component\":\"Row\",\"ui_component\":\"row\",\"child_components\":[{\"component\":\"DropDown\",\"ui_component\":\"drop_down\",\"is_expanded\":false,\"style\":{\"height\":0,\"width\":25,\"size\":0},\"value_list\":[\"+91\",\"+1\"]},{\"component\":\"TextBox\",\"ui_component\":\"edit_text\",\"label\":\"Phone Number\",\"hint\":\"Type Phone Number...\",\"validation_type\":\"length\",\"input_type\":\"phone\",\"isOptional\":false,\"is_expanded\":true,\"min_length\":7,\"max_length\":13,\"action_type\":\"action_done\",\"style\":{\"height\":0,\"width\":0,\"size\":0}}]},{\"component\":\"DropDown\",\"ui_component\":\"drop_down\",\"is_expanded\":true,\"style\":{\"height\":0,\"width\":0,\"size\":0},\"value_list\":[\"India\",\"USA\",\"Bangladesh\",\"Nepal\"]},{\"component\":\"Button\",\"ui_component\":\"button\",\"type\":\"filled_button\",\"text\":\"Sign Up\",\"call_api\":true,\"api_end_point\":\"\",\"api_type\":\"GET\",\"style\":{\"height\":0,\"width\":0,\"size\":0},\"is_expanded\":true}]},{\"id\":\"upload_document\",\"page_title\":\"Upload Documents\",\"fields\":[{\"component\":\"ListView\",\"ui_component\":\"list_view\",\"is_expanded\":true,\"value_list\":[{\"component\":\"ListItem\",\"ui_component\":\"list_tile\",\"leading\":{\"component\":\"Image\",\"ui_component\":\"image\",\"type\":\"network\",\"path\":\"https://www.svgrepo.com/show/345223/three-dots-vertical.svg\",\"style\":{\"height\":0,\"width\":0,\"size\":8}},\"title\":{\"component\":\"Row\",\"ui_component\":\"row\",\"child_components\":[{\"component\":\"TextBox\",\"ui_component\":\"text\",\"text\":\"Passport Bio Page\",\"label\":\"\",\"hint\":\"\",\"validation_type\":\"\",\"input_type\":\"\",\"is_expanded\":false,\"isOptional\":true,\"action_type\":\"\",\"style\":{\"height\":0,\"width\":0,\"size\":0,\"text_size\":\"16\"}},{\"component\":\"Button\",\"ui_component\":\"button\",\"type\":\"text_button\",\"text\":\"Click to see\",\"call_api\":false,\"api_end_point\":\"\",\"api_type\":\"\",\"is_expanded\":false,\"style\":{\"width\":0,\"color\":\"546567\",\"decoration\":\"underline\",\"decoration_color\":\"546567\"}}]},\"subtitle\":{\"component\":\"RichText\",\"ui_component\":\"rich_text\",\"child_components\":[{\"component\":\"TextBox\",\"ui_component\":\"text_span\",\"text\":\"Choose File\",\"recognizer\":\"TapGestureRecognizer\"},{\"component\":\"TextBox\",\"ui_component\":\"text_span\",\"text\":\"JPEG files upto 20k\",\"recognizer\":\"\"}]},\"trailing\":{\"component\":\"Image\",\"ui_component\":\"image\",\"type\":\"network\",\"path\":\"https://www.svgrepo.com/show/345223/three-dots-vertical.svg\",\"style\":{\"height\":0,\"width\":0,\"size\":8}}},{\"component\":\"ListItem\",\"ui_component\":\"list_tile\",\"title\":{\"component\":\"Row\",\"ui_component\":\"row\",\"child_components\":[{\"component\":\"TextBox\",\"ui_component\":\"text\",\"text\":\"Passport Bio Page\",\"label\":\"\",\"hint\":\"\",\"validation_type\":\"\",\"input_type\":\"\",\"is_expanded\":false,\"isOptional\":true,\"action_type\":\"\",\"style\":{\"height\":0,\"width\":0,\"size\":0,\"text_size\":\"16\"}},{\"component\":\"Button\",\"ui_component\":\"button\",\"type\":\"text_button\",\"text\":\"Click to see\",\"call_api\":false,\"api_end_point\":\"\",\"api_type\":\"\",\"is_expanded\":false,\"style\":{\"width\":0,\"color\":\"546567\",\"decoration\":\"underline\",\"decoration_color\":\"546567\"}}]},\"subtitle\":{\"component\":\"TextBox\",\"ui_component\":\"rich_text\",\"child_components\":[{\"component\":\"TextBox\",\"ui_component\":\"text_span\",\"text\":\"Choose File\",\"recognizer\":\"TapGestureRecognizer\"},{\"component\":\"TextBox\",\"ui_component\":\"text_span\",\"text\":\"JPEG files upto 20k\",\"recognizer\":\"\"}]}}]},{\"component\":\"Button\",\"ui_component\":\"button\",\"type\":\"filled_button\",\"text\":\"Save and Continue\",\"call_api\":true,\"api_end_point\":\"\",\"api_type\":\"MULTIPART\",\"is_expanded\":true,\"style\":{\"height\":0,\"width\":0,\"size\":0}}]}]}",
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
    if(!kIsWeb) await _registerListener();
  }

  String getString(String key) => _remoteConfig.getString(key); // NEW
  bool getBool(String key) => _remoteConfig.getBool(key); // NEW
  int getInt(String key) => _remoteConfig.getInt(key); // NEW
  double getDouble(String key) => _remoteConfig.getDouble(key); // NEW
}
