import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fpdart/fpdart.dart';
import 'package:icu_project/shared/network/local/cache_helper.dart';
import 'package:logger/logger.dart';
import '../../../models/auth/login_model.dart';

Logger logger = Logger();
LoginModel? loginModel;

enum _MethodType { post, get, put, patch }

class DioHelper {
  DioHelper._();

  static const _connectTimeout = Duration(seconds: 50);
  static const _receiveTimeout = Duration(seconds: 50);
  static const _sendTimeout = Duration(seconds: 50);

  static Map<String, String> get _defaultHeaders => {
        "Content-Type": Headers.jsonContentType,
        "Accept": Headers.jsonContentType,
        if (CacheHelper.getData(key: 'token') != null) ...{
          'Authorization': "Token ${CacheHelper.getData(key: 'token')}",
        },
      };

  static final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: _connectTimeout,
      receiveTimeout: _receiveTimeout,
      sendTimeout: _sendTimeout,
      baseUrl: 'https://icu-v0is.onrender.com/api/',
    ),
  );

  // POST method
  static Future<Either<T, APIError>> post<T>({
    dynamic requestBody,
    Map<String, dynamic>? header,
    bool returnDataOnly = true,
    Duration? sendTimeOut = _sendTimeout,
    Duration? receiveTimeout = _receiveTimeout,
    // bool automaticManageIndicator = true,
    required String url,
    Map<String, dynamic> additionalHeaders = const {},
  }) async {
    return _hitApi(
      url: url,
      header: header,
      returnDataOnly: returnDataOnly,
      // automaticManageIndicator: automaticManageIndicator,
      methodType: _MethodType.post,
      requestBody: requestBody,
      additionalHeaders: additionalHeaders,
      receiveTimeout: receiveTimeout,
      sendTimeOut: sendTimeOut,
    );
  }

  static Future<Either<T, APIError>> patch<T>({
    dynamic requestBody,
    Map<String, dynamic>? header,
    bool returnDataOnly = true,
    Duration? sendTimeOut = _sendTimeout,
    Duration? receiveTimeout = _receiveTimeout,
    // bool automaticManageIndicator = true,
    required String url,
    Map<String, dynamic> additionalHeaders = const {},
  }) async {
    return _hitApi(
      url: url,
      header: header,
      returnDataOnly: returnDataOnly,
      // automaticManageIndicator: automaticManageIndicator,
      methodType: _MethodType.patch,
      requestBody: requestBody,
      additionalHeaders: additionalHeaders,
      receiveTimeout: receiveTimeout,
      sendTimeOut: sendTimeOut,
    );
  }

  // PUT method
  static Future<Either<T, APIError>> put<T>({
    dynamic requestBody,
    Map<String, dynamic>? header,
    bool returnDataOnly = true,
    Duration? sendTimeOut = _sendTimeout,
    Duration? receiveTimeout = _receiveTimeout,
    bool automaticManageIndicator = true,
    required String url,
    Map<String, dynamic> additionalHeaders = const {},
  }) async {
    return _hitApi(
      url: url,
      header: header,
      returnDataOnly: returnDataOnly,
      // automaticManageIndicator: automaticManageIndicator,
      methodType: _MethodType.put,
      requestBody: requestBody,
      additionalHeaders: additionalHeaders,
      receiveTimeout: receiveTimeout,
      sendTimeOut: sendTimeOut,
    );
  }

  // GET method
  static Future<Either<T, APIError>> get<T>({
    required String url,
    bool returnDataOnly = true,
    bool automaticManageIndicator = true,
    dynamic queryParameters,
    Duration? sendTimeOut = _sendTimeout,
    Duration? receiveTimeout = _receiveTimeout,
    Map<String, dynamic> additionalHeaders = const {},
  }) async {
    return _hitApi(
      url: url,
      returnDataOnly: returnDataOnly,
      methodType: _MethodType.get,
      requestBody: queryParameters,
      // automaticManageIndicator: automaticManageIndicator,
      additionalHeaders: additionalHeaders,
      receiveTimeout: receiveTimeout,
      sendTimeOut: sendTimeOut,
    );
  }

  // Generic HTTP method
  static Future<Either<T, APIError>> _hitApi<T>({
    required _MethodType methodType,
    required String url,
    bool returnDataOnly = true,
    dynamic requestBody,
    Map<String, dynamic>? header,
    Duration? sendTimeOut = _sendTimeout,
    Duration? receiveTimeout = _receiveTimeout,
    // bool automaticManageIndicator = true,
    Map<String, dynamic> additionalHeaders = const {},
  }) async {
    final Map<String, dynamic> headers =
        header ?? {..._defaultHeaders, ...additionalHeaders};

    logger.v(
      "$methodType:${_dio.options.baseUrl + url}\n$headers\n${requestBody ?? ''}",
    );
    // if (automaticManageIndicator) {
    // snack.Get.find<Indicator>().setBusy();
    // }

    try {
      Response<dynamic> response;
      switch (methodType) {
        case _MethodType.post:
          response = await _dio.post(
            url,
            options: Options(
              headers: headers,
              receiveTimeout: receiveTimeout,
              sendTimeout: sendTimeOut,
            ),
            data: requestBody,
          );
          break;
        case _MethodType.get:
          response = await _dio.get(
            url,
            options: Options(
              headers: headers,
            ),
            queryParameters: requestBody,
          );
          break;
        case _MethodType.put:
          response = await _dio.put(
            url,
            options: Options(
              headers: headers,
              receiveTimeout: receiveTimeout,
              sendTimeout: sendTimeOut,
            ),
            data: requestBody,
          );
          break;
        case _MethodType.patch:
          response = await _dio.patch(
            url,
            options: Options(
              headers: headers,
              receiveTimeout: receiveTimeout,
              sendTimeout: sendTimeOut,
            ),
            data: requestBody,
          );
          break;
      }

      // if (automaticManageIndicator) {
      //   snack.Get.find<Indicator>().setIdle();
      // }

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        Logger().w(response.data);
        return Left(response.data as T);
      } else {
        throw DioError(requestOptions: response.requestOptions);
      }
    } on DioError catch (e) {
      logger.e(
        "$methodType:${_dio.options.baseUrl + url} Headers : $headers [$requestBody] ERORRR DIO EROOORRR ${CacheHelper.getData(key: "token")}",
      );
      // if (automaticManageIndicator) {
      //   snack.Get.find<Indicator>().setIdle();
      // }
      // if (e.response?.statusCode == 401 &&
      //     !e.requestOptions.path.contains(ApiPath.login)) {
      //   snack.Get.offAllNamed(Routes.AUTH_SELECT);
      //   await dataManager.removeLoggedUser();
      // }

      Logger().wtf(e.response?.data);
      final String? error = e.response?.data['non_field_errors']?.first ??
          e.response?.data['errors']?['non_field_errors']?.first ??
          e.response?.data?['error'] ??
          e.response?.data['detail'] ??
          e.response?.data['message'] ??
          e.response?.data['email'] ??
          e.response?.data['username'] ??
          e.response?.data['phone'] ??
          

          getMessege(url, e.response?.statusCode);

      String? val = error;
      if (val != null) {
        return Right(APIError(message: val, msgFromServer: true));
      }

      switch (e.type) {
        case DioErrorType.connectionError:
          if (e.error is SocketException) {
          } else {
            UIHelper.showAlert(e.type.name);
          }
          break;
        default:
          UIHelper.showAlert(e.type.name);
      }
      return Right(
        APIError(message: e.message, status: e.response?.statusCode),
      );
    } catch (e) {
      logger.e(
        "$methodType:${_dio.options.baseUrl + url} Headers : $headers [$requestBody] ERORRR CATCH",
      );
      // if (automaticManageIndicator) {
      //   snack.Get.find<Indicator>().setIdle();
      // }
      return Right(APIError(message: e, status: 1000));
    }
  }

  static String? getMessege(String endpoint, int? code) {
    switch (code) {
      case 400:
        return 'Bad Request';
      case 401:
        return "No active account found with the given credentials";
      case 403:
        return "You are not authorized to access this endpoint";
      case 404:
        return "The endpoint you are trying to access is not found";
      case 406:
        return "Code Expired or not correct";
      case 500:
        return "Something went wrong";
      case 503:
        return "Service is unavailable";
      default:
        return null;
    }
  }
}

class APIError {
  dynamic message = '';
  dynamic status = '';
  bool msgFromServer;

  APIError({this.status, this.message, this.msgFromServer = false}) {
    logger.e("code is $status , and the message is $message");

    if (msgFromServer && message is String && message.isNotEmpty) {
      UIHelper.showAlert('$message');
    }
  }
}

class UIHelper {
  static showAlert(String msg) {
    Fluttertoast.showToast(msg: msg);
  }
}
