part of 'auth_bloc.dart';

class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}


// class CheckUserLoggedEvent extends AuthEvent {}

class SignInEvent extends AuthEvent {
  final AuthType authType;
  SignInEvent({required this.authType});

}
