part of 'auth_bloc.dart';

class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object> get props => [];
}

class InitialState extends AuthState {}

class LoginSuccessState extends AuthState{}
class BlankState extends AuthState{}
class AuthErrorState extends AuthState{
  final String message;
  AuthErrorState({required this.message});
}
class InternetErrorState extends AuthState{}
class ServerErrorState extends AuthState{}