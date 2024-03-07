import 'dart:io';
import 'package:github_search/constants/credentials.dart';
import 'package:github_search/core/error/exceptions.dart';
import 'package:github_search/core/services/database/auth_params.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

abstract class AuthenticationRemoteDataSource {
  Future<bool> login(AuthType authType);

}

class AuthenticationRemoteDataSourceImpl
    implements AuthenticationRemoteDataSource {

  AuthenticationRemoteDataSourceImpl();

  //Sign in
  @override
  Future<bool> login(AuthType authType) async {
    try{
      //GOOGLE AUTH
      if(authType == AuthType.google){

        final GoogleSignIn googleSignIn = GoogleSignIn();

        final GoogleSignInAccount? googleSignInAccount =
            await googleSignIn.signIn();

        final GoogleSignInAuthentication? googleSignInAuthentication =
            await googleSignInAccount?.authentication;
        

        return googleSignInAuthentication?.accessToken != null;


      //APPLE AUTH
      }else if(authType == AuthType.apple){
        final credential = await SignInWithApple.getAppleIDCredential(
          webAuthenticationOptions: Platform.isIOS
          ? null
          : WebAuthenticationOptions(
              clientId: CredentialsData.appleClientID, 
              redirectUri: Uri.parse(
                CredentialsData.appleRedirectURLForAndroid
              )
            ),
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
        );
        
        return credential.identityToken != null;
      }
      return false;
    }catch(e){
      throw ServerException(message: e.toString());
    }
  }


}
