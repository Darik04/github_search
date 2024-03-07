import 'package:github_search/features/main/domain/enities/main_entity.dart';

abstract class MainRemoteDataSource {
  Future<MainEntity> getMainInfo(String query, {bool isMock = false});
}