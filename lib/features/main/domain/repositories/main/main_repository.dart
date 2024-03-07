import 'package:dartz/dartz.dart';
import 'package:github_search/core/error/failures.dart';
import 'package:github_search/features/main/domain/enities/main_entity.dart';
import 'package:github_search/features/main/domain/usecases/get_main_info.dart';

abstract class MainRepository {
  Future<Either<Failure, MainEntity>> getMainInfo(GetMainParams params);
}