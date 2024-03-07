// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:github_search/core/error/exceptions.dart';
import 'package:github_search/core/error/failures.dart';
import 'package:github_search/core/services/network/network_info.dart';
import 'package:github_search/features/main/data/datasources/main/remote_datasource.dart';
import 'package:github_search/features/main/domain/enities/main_entity.dart';
import 'package:github_search/features/main/domain/repositories/main/main_repository.dart';


class MainRepositoryImpl implements MainRepository {
  final MainRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  MainRepositoryImpl(
      this.remoteDataSource, this.networkInfo);


  /// Получение информации с бэка
  /// главная
  @override
  Future<Either<Failure, MainEntity>> getMainInfo(params) async {
    if (await networkInfo.isConnected) {
      try {
        var res = await remoteDataSource.getMainInfo(params.query, isMock: params.isMock);
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

