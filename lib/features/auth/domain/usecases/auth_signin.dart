import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:github_search/core/error/failures.dart';
import 'package:github_search/core/services/database/auth_params.dart';
import 'package:github_search/core/usecases/usecase.dart';
import 'package:github_search/features/auth/domain/repositories/login/login_repository.dart';

class AuthSignIn implements UseCase<bool, AuthSignParams> {
  final LoginRepository repository;

  AuthSignIn(this.repository);

  @override
  Future<Either<Failure, bool>> call(AuthSignParams params) async {
    return await repository.authSignIn(params);
  }
}

class AuthSignParams extends Equatable {
  final AuthType authType;

  const AuthSignParams({required this.authType});

  @override
  List<Object> get props => [authType];
}