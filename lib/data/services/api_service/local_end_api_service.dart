import 'package:dio/dio.dart';
import 'package:vfs_dynamic_app/main.dart';

import '../../constants/const_keys.dart';
import '../../utils/encrypt_decrypt_rsa.dart';
import '../../utils/logger.dart';
import 'api_client.dart';
import 'api_error_handler.dart';
import 'api_result.dart';
import 'connectivity_service.dart';

class LocalEndPoints {
  static const String getConfig = "master/GetCategoryList";
  static const String getCountryList = "Country/MobileCountryList";
}

class LocalApiService {
  final DioService _apiClient =
      DioService(baseUrl: appConfigModel!.appConfigData!.applicationBaseUrl!);
  final ConnectivityService _connectivityService = ConnectivityService();

  static final LocalApiService _instance = LocalApiService._internal();

  factory LocalApiService() {
    return _instance;
  }

  LocalApiService._internal();

  String getCurrentDateTimeHeader() {
    final now = DateTime.now();
    String stringModified = now.toString().replaceAll(' ', 'T');
    stringModified =
        stringModified.replaceRange(stringModified.indexOf("."), stringModified.length, "");
    String finalString = "mobile;${stringModified}Z";
    Logger.doLog(finalString);
    String encCurrentDateTime = EncryptionUtils().encryptRSA(finalString);
    Logger.doLog(encCurrentDateTime);
    return encCurrentDateTime;
  }

  Future<ApiResult<dynamic>> getApiCall(
    String endPoint, {
    Map<String, dynamic> queries = const <String, dynamic>{},
    bool showLoaderDialog = true,
  }) async {
    bool isAvailable = await _connectivityService.isConnectionAvailable();
    if (isAvailable) {
      if (showLoaderDialog) {
        // showLoader();
      }
      try {
        Map<String, dynamic> headers = <String, dynamic>{
          ConstKeys.authority: appConfigModel!.appConfigData!.appointmentUrlAuthority,
          ConstKeys.referer: appConfigModel!.appConfigData!.appointmentUrlOrigin,
          ConstKeys.origin: appConfigModel!.appConfigData!.appointmentUrlOrigin,
          ConstKeys.clientSource: getCurrentDateTimeHeader(),
        };
        dynamic response = await _apiClient.get(
          endpoint: endPoint,
          headers: headers,
          queries: queries,
        );
        if (showLoaderDialog) {
          // hideLoader();
        }
        if (response is Map<String, dynamic>) {
          if (response.containsKey("error")) {
            if (response["error"] != null) {
              Error model = Error.fromJson(response["error"]);
              return ApiResult()..setException(APIErrorHandler.apiException(model));
            }
          }
        }
        return ApiResult()..setData(response);
      } catch (e, _) {
        if (showLoaderDialog) {
          // hideLoader();
        }
        if (e is DioException) {
          return ApiResult()..setException(APIErrorHandler.dioException(error: e));
        } else {
          return ApiResult()..setException(APIErrorHandler.otherException());
        }
      }
    } else {
      return ApiResult()..setException(APIErrorHandler.otherException("No Internet connection"));
    }
  }

  Future<ApiResult<dynamic>> postApiCall(String endPoint, dynamic data,
      {bool isFormURLEncoded = true, bool showLoaderDialog = true}) async {
    bool isAvailable = await _connectivityService.isConnectionAvailable();
    if (isAvailable) {
      if (showLoaderDialog) {
        // showLoader();
      }
      try {
        Map<String, dynamic> headers = <String, dynamic>{
          ConstKeys.contentType: ConstKeys.contentTypeValue,
          ConstKeys.referer: appConfigModel!.appConfigData!.appointmentUrlOrigin,
          ConstKeys.clientSource: getCurrentDateTimeHeader(),
        };

        dynamic response = await _apiClient.post(
          endpoint: endPoint,
          headers: headers,
          data: data,
          isFormURLEncoded: isFormURLEncoded,
        );
        if (showLoaderDialog) {
          // hideLoader();
        }
        if (response is Map<String, dynamic>) {
          if (response.containsKey("error")) {
            if (response["error"] != null) {
              Error model = Error.fromJson(response["error"]);
              return ApiResult()..setException(APIErrorHandler.apiException(model));
            }
          }
        }
        return ApiResult()..setData(response);
      } catch (e, _) {
        if (showLoaderDialog) {
          // hideLoader();
        }
        if (e is DioException) {
          return ApiResult()..setException(APIErrorHandler.dioException(error: e));
        } else {
          return ApiResult()..setException(APIErrorHandler.otherException());
        }
      }
    } else {
      return ApiResult()..setException(APIErrorHandler.otherException("No Internet connection"));
    }
  }
}
