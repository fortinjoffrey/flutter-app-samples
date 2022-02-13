import 'package:freezed_annotation/freezed_annotation.dart';

part 'source_exception.freezed.dart';

abstract class _SourceException implements Exception {}

@freezed
class SourceException extends _SourceException with _$SourceException {
  const factory SourceException.requestCancelled(String message) = _RequestCancelled;

  const factory SourceException.unauthorisedRequest(String message) = _UnauthorisedRequest;

  const factory SourceException.forbidden(String message) = _Forbidden;

  const factory SourceException.noResponse(String message) = _NoResponse;

  const factory SourceException.emptyData([String? message]) = _EmptyData;

  const factory SourceException.invalidData([String? message]) = _InvalidData;

  const factory SourceException.notFound(String message) = _NotFound;

  const factory SourceException.requestTimeout(String message) = _RequestTimeout;

  const factory SourceException.sendTimeout(String message) = _SendTimeout;

  const factory SourceException.conflict(String message) = _Conflict;

  const factory SourceException.internalServerError(String message) = _InternalServerError;

  const factory SourceException.notImplemented(String message) = _NotImplemented;

  const factory SourceException.serviceUnavailable(String message) = _ServiceUnavailable;

  const factory SourceException.noInternetConnection(String message) = _NoInternetConnection;

  const factory SourceException.formatException(String message) = _FormatException;

  const factory SourceException.unableToProcess() = _UnableToProcess;

  const factory SourceException.unexpectedError() = _UnexpectedError;

  const factory SourceException.defaultError(String message, int? statusCode) = _DefaultError;
}
