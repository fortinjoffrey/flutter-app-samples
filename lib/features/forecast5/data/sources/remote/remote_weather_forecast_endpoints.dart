const forecast = '/forecast?q=:cityname&units=:units&appid=:appid';

/// Replace the parameters in an endpoints.
/// The [params] argument is a {key: value} map.
String replaceParams(String endpoint, Map<String, String> params) {
  String replaced = endpoint;
  params.forEach(
    (key, value) => replaced = replaced.replaceFirst(':$key', value),
  );
  return replaced;
}
