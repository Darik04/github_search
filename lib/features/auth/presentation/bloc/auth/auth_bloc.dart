import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:github_search/core/error/failures.dart';
import 'package:github_search/core/services/database/auth_params.dart';
import 'package:github_search/features/auth/domain/usecases/auth_signin.dart';
import '../../../../../locator.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthSignIn authSignIn;
  // final Logout logout;
  
  AuthBloc(this.authSignIn) : super(InitialState()){
    // on<CheckUserLoggedEvent>(_authCheck);
    on<SignInEvent>(_authLogin);
  }


  // void _authCheck(CheckUserLoggedEvent event, Emitter<AuthState> emit) async {

  //   var token = await getTokenLocal(NoParams());
  //   final state = token.fold(
  //     (error) => errorCheck(error),
  //     (token){
  //       if(token != null){
  //         sl<AuthConfig>().token = token;
  //         print('required get user info');
  //         return RequiredGetUserInfoState();
  //       }else{
  //         print('USER IS NOT LOGGED');
  //         sl<AuthConfig>().token = null;
  //         return UserIsNotLoggedState();
  //       }
  //     }
  //   );

  //   emit(state);
  // }



  void _authLogin(SignInEvent event, Emitter<AuthState> emit) async {
    emit(BlankState());
    var authGetToken = await authSignIn(AuthSignParams(authType: event.authType));
    final state = authGetToken.fold(
      (error) => errorCheck(error),
      (loggedIn) {
        if(loggedIn){
          sl<AuthConfig>().authenticatedOption = AuthenticatedOption.authenticated;
          return LoginSuccessState();
        }
        return AuthErrorState(message: 'Повторите попытку');
      }
    );

    emit(state);
  }



  AuthState errorCheck(Failure failure){
    
    print('FAIL: $failure');
    if(failure == ConnectionFailure() || failure == NetworkFailure()){
      return InternetErrorState();
    }else if(failure is ServerFailure){
      return AuthErrorState(message: failure.message.length < 100 ? failure.message : 'Ошибка сервера');
    }else{
      // logout(NoParams());
      sl<AuthConfig>().authenticatedOption = AuthenticatedOption.unauthenticated;
      return AuthErrorState(message: 'Повторите попытку');
    }
  }
}
