
// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:github_search/core/error/failures.dart';
import 'package:github_search/features/auth/domain/usecases/auth_signin.dart';

abstract class LoginRepository {
  Future<Either<Failure, bool>> authSignIn(AuthSignParams params);
}