import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:vfs_dynamic_app/data/utils/logger.dart';

/// Handling  all errors
class APIErrorHandler implements Exception {
  dynamic _errorMessage = "";

  APIErrorHandler(this._errorMessage);

  APIErrorHandler.dioException({required DioException error}) {
    _handleDioException(error);
  }

  APIErrorHandler.otherException([String message = ""]) {
    _handleOtherException(message);
  }

  APIErrorHandler.apiException(Error model) {
    _handleApiException(model);
  }

  //error getter
  getErrorMessage() {
    return _errorMessage;
  }

  //error will be type ,cast etc..
  _handleOtherException(String message) {
    if (message.isEmpty) {
      _errorMessage = "Something went Wrong";
    } else {
      _errorMessage = message;
    }
    APIErrorHandler serverError = APIErrorHandler(_errorMessage);
    return serverError;
  }

  //status code will be 200 but errors returned from API
  _handleApiException(Error model) {
    if (model.description.isNotEmpty) {
      final message = model.description;
      _errorMessage = message;
    } else {
      _errorMessage = "Something went wrong";
    }
    APIErrorHandler serverError = APIErrorHandler(_errorMessage);
    return serverError;
  }

  //error will be network related
  _handleDioException(DioException error) {
    APIErrorHandler serverError;
    switch (error.type) {
      case DioExceptionType.cancel:
        _errorMessage = "request cancelled";
        serverError = APIErrorHandler(_errorMessage);
        break;
      case DioExceptionType.connectionTimeout:
        _errorMessage = "connection timeout";
        serverError = APIErrorHandler(_errorMessage);
        break;
      case DioExceptionType.receiveTimeout:
        _errorMessage = "receive timeout";
        serverError = APIErrorHandler(_errorMessage);
        break;
      case DioExceptionType.badResponse:
        if (error.response?.statusCode == 503) {
          _errorMessage = "Something went wrong";
          serverError = APIErrorHandler(_errorMessage);
        } else if (error.response?.statusCode == 429 || error.response?.statusCode == 403) {
          _errorMessage =
              "The system is currently unavailable due to a high user volume, please try again later.";
          serverError = APIErrorHandler(_errorMessage);
        } else if (error.response?.statusCode != 401) {
          _errorMessage = handleBadRequest(error.response?.data, error.response?.extra);
          serverError = APIErrorHandler(_errorMessage);
        } else {
          _errorMessage = "UnAuthorized";
          serverError = APIErrorHandler(_errorMessage);
        }
        break;
      case DioExceptionType.unknown:
        Logger.doLog("Called here unknown");
        _errorMessage = "Something went wrong";
        serverError = APIErrorHandler(_errorMessage);
        break;
      case DioExceptionType.sendTimeout:
        if (kReleaseMode) {
          _errorMessage = "Something went wrong";
        } else {
          _errorMessage = "send timeout";
        }
        serverError = APIErrorHandler(_errorMessage);
        break;
      case DioExceptionType.connectionError:
        _errorMessage = "No Internet connection";
        serverError = APIErrorHandler(_errorMessage);
        break;
      default:
        _errorMessage = error.response?.statusMessage ?? "Something went wrong";
        serverError = APIErrorHandler(_errorMessage);
        break;
    }
    return serverError;
  }

  // this is a sample error structure it might change on your case
  // so you have to add your own error structure  in order to catch the errors
  String handleBadRequest(dynamic errorData, dynamic extras) {
    Logger.doLog("error data :- $errorData, extras :- $extras");
    String error = "";
    if (errorData is String) {
      error = errorData;
    } else if (errorData is Map<String, dynamic>) {
      ErrorResponseModel model = ErrorResponseModel.fromJson(errorData);
      if (model.error.description.isNotEmpty) {
        final message = model.error.description;
        error = message;
      } else {
        error = "Something went wrong";
      }
    }
    return error;
  }
}

class ErrorResponseModel {
  Error error;

  ErrorResponseModel({
    required this.error,
  });

  factory ErrorResponseModel.fromJson(Map<String, dynamic> json) => ErrorResponseModel(
        error: Error.fromJson(json["error"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error.toJson(),
      };
}

class Error {
  String code;
  String description;

  Error({
    required this.code,
    required this.description,
  });

  factory Error.fromJson(Map<String, dynamic> json) => Error(
        code: json["code"].toString(),
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "description": description,
      };
}
