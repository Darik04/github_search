import 'package:dartz/dartz.dart';
import 'package:github_search/core/error/exceptions.dart';
import 'package:github_search/core/error/failures.dart';
import 'package:github_search/core/services/network/network_info.dart';
import 'package:github_search/features/auth/data/datasources/auth/remote_datasource.dart';
import 'package:github_search/features/auth/domain/repositories/login/login_repository.dart';
import 'package:github_search/features/auth/domain/usecases/auth_signin.dart';

class LoginRepositoryImpl implements LoginRepository {
  final AuthenticationRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  LoginRepositoryImpl(
      this.remoteDataSource, this.networkInfo);


  
  @override
  Future<Either<Failure, bool>> authSignIn(AuthSignParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final res = await remoteDataSource.login(params.authType);
        return Right(res);
      } catch (e) {
        if(e is ServerException){
          return Left(ServerFailure(e.message!));
        }
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }




}

