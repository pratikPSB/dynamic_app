import 'api_error_handler.dart';

/// Adding all API success/error response into this generic class
class ApiResult<T> {
  APIErrorHandler? _exception;
  T? _data;

  setException(APIErrorHandler error) {
    _exception = error;
  }

  setData(T data) {
    _data = data;
  }
  
  T? get data {
    return _data;
  }

  APIErrorHandler? get getException {
    return _exception;
  }
}
