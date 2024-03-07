// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:github_search/core/error/failures.dart';
import 'package:github_search/core/usecases/usecase.dart';
import 'package:github_search/features/main/domain/enities/main_entity.dart';
import 'package:github_search/features/main/domain/repositories/main/main_repository.dart';

class GetMainInfo implements UseCase<MainEntity, GetMainParams> {
  final MainRepository repository;

  GetMainInfo(this.repository);

  @override
  Future<Either<Failure, MainEntity>> call(GetMainParams params) async {
    return await repository.getMainInfo(params);
  }
}
class GetMainParams extends Equatable {
  final String query;
  final bool isMock;//For testing

  const GetMainParams({required this.query, this.isMock = false});

  @override
  List<Object> get props => [query];
}