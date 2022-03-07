import 'package:dio/dio.dart';
import 'package:flutter_app_samples/common/data/exceptions/source_exception.dart';

List<T> getDtosFromDynamicList<T, D>(List<dynamic> list, T Function(D) fromJsonToDto) {
  try {
    return list.map((dynamic e) => fromJsonToDto(e as D)).toList();
  } catch (e) {
    rethrow;
  }
}

T getResponseData<T>(Response response) {
  if (response.data == null) {
    throw const SourceException.emptyData();
  }

  if (response.data is! T) {
    throw SourceException.invalidData('response.data is not of type ${T.runtimeType}}');
  }

  return response.data as T;
}
