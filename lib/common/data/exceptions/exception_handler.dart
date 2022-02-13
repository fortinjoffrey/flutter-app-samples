import 'dart:developer';

import 'package:flutter_app_samples/common/data/exceptions/exception_factory.dart';
import 'package:flutter_app_samples/common/data/exceptions/source_exception.dart';

abstract class ExceptionHandler {
  /// Always throws a [SourceException]
  static Never handleErrorAndThrow(dynamic e, {StackTrace? s}) {
    log('An exception was thrown', error: e, stackTrace: s);
    throw ExceptionFactory.getSourceException(e);
  }
}
