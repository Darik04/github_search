enum Config { baseUrl, baseScheme, baseAPIpath, url }

const bool isDev = true;

// const String myUrl = '0.0.0.0';
const String myUrl = 'api.github.com';

extension ConfigExtension on Config {
  String get value {
    switch (this) {
      case Config.baseUrl:
        return !isDev ? "api.github.com" : myUrl;
      case Config.baseAPIpath:
        return '';
      case Config.url:
        return url;
      default:
        return myUrl == '0.0.0.0' ? 'http' : 'https';
    }
  }

  String get url {
    return Config.baseScheme.value +
        "://" +
        Config.baseUrl.value +
        Config.baseAPIpath.value;
  }
}
