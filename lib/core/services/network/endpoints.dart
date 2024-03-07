import 'config.dart';
import 'dart:core';

enum Endpoints {
  // Authentication
  search,
  gitHubGraphQL
}

extension EndpointsExtension on Endpoints {
  String getPath({
    List<dynamic>? params,
  }) {
    var url = Config.url.url;
    switch (this) {
      case Endpoints.search:
        return "$url/search/code?q=${params?[0]}&sort=created&order=asc&per_page=3";
      case Endpoints.gitHubGraphQL:
        return "https://api.github.com/graphql";
      default:
        return '';
    }
  }

  String get hostName {
    return Config.baseUrl.value;
  }

  String get scheme {
    return Config.baseScheme.value;
  }

  String get path {
    return Config.baseAPIpath.value;
  }

  Map<String, String> getHeaders(
      {String token = '', Map<String, String>? defaultHeaders}) {
    return {
      if(defaultHeaders != null)
      ...defaultHeaders,
      'Content-Type': 'application/json; charset=UTF-8',
      if (token != '') ...{'Authorization': 'Token $token'}
    };
  }

  Uri buildURL(
      {Map<String, dynamic>? queryParameters, List<dynamic>? urlParams}) {
    var url = Uri(
        scheme: scheme,
        host: hostName,
        path: getPath(params: urlParams),
        queryParameters: queryParameters ?? {});
    return url;
  }
}

