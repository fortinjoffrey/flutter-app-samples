import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_app_samples/common/data/exceptions/source_exception.dart';

abstract class ExceptionFactory {
  static SourceException getSourceException(dynamic e) {
    if (e is SourceException) return e;

    SourceException se;

    if (e is DioError) {
      final Response? response = e.response;
      if (response == null) {
        se = SourceException.noResponse(e.message);
      } else if (response.data == null) {
        se = SourceException.emptyData(e.message);
      } else {
        switch (e.type) {
          case DioErrorType.cancel:
            se = SourceException.requestCancelled(e.message);
            break;
          case DioErrorType.connectTimeout:
            se = SourceException.requestTimeout(e.message);
            break;
          case DioErrorType.other:
            se = SourceException.noInternetConnection(e.message);
            break;
          case DioErrorType.receiveTimeout:
            se = SourceException.sendTimeout(e.message);
            break;
          case DioErrorType.response:
            switch (response.statusCode) {
              case 401:
                se = SourceException.unauthorisedRequest(e.message);
                break;
              case 403:
                se = SourceException.forbidden(e.message);
                break;
              case 404:
                se = SourceException.notFound(e.message);
                break;
              case 409:
                se = SourceException.conflict(e.message);
                break;
              case 408:
                se = SourceException.requestTimeout(e.message);
                break;
              case 500:
                se = SourceException.internalServerError(e.message);
                break;
              case 503:
                se = SourceException.serviceUnavailable(e.message);
                break;
              default:
                se = SourceException.defaultError(e.message, response.statusCode);
                break;
            }
            break;
          case DioErrorType.sendTimeout:
            se = SourceException.sendTimeout(e.message);
            break;
          default:
            se = SourceException.defaultError(e.message, response.statusCode);
            break;
        }
      }
    } else if (e is SocketException) {
      se = SourceException.noInternetConnection(e.message);
    } else if (e is FormatException) {
      se = SourceException.formatException(e.message);
    } else if (e is HttpException) {
      se = SourceException.notFound(e.message);
    } else {
      if (e.toString().contains('is not a subtype of')) {
        se = const SourceException.unableToProcess();
      } else {
        se = const SourceException.unexpectedError();
      }
    }
    return se;
  }
}
