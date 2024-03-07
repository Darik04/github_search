
enum AuthenticatedOption {
  unauthenticated, 
  authenticated
}

enum AuthType{
  google,
  apple
}


extension AuthenticatedOptionExtension on AuthenticatedOption {
  String get key {
    switch (this) {
      case AuthenticatedOption.unauthenticated:
        return 'unauthenticated';
      case AuthenticatedOption.authenticated:
        return 'authenticated';
    }
  }
}

class AuthConfig {
  AuthenticatedOption? authenticatedOption;
  
  AuthConfig({
    this.authenticatedOption = AuthenticatedOption.unauthenticated
  });
}
