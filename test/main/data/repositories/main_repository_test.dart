import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/core/services/network/network_info.dart';
import 'package:github_search/features/main/data/datasources/main/rest_remote_datasource.dart';
import 'package:github_search/features/main/data/repositories/main_repository_impl.dart';
import 'package:github_search/features/main/domain/repositories/main/main_repository.dart';
import 'package:github_search/features/main/domain/usecases/get_main_info.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'main_repository_test.mocks.dart';
import 'mock_data/actual_repo_data.dart';
import 'mock_data/expected_repo_data.dart';




@GenerateMocks([MainRESTRemoteDataSourceImpl])
void main() {
  const GetMainParams mainParams = GetMainParams(query: 'shop', isMock: true);

  late MockMainRESTRemoteDataSourceImpl mockDatasource;

  late MainRepository mainRepositoryImpl;
  setUp(() {
    mockDatasource = MockMainRESTRemoteDataSourceImpl();
    mainRepositoryImpl = MainRepositoryImpl(mockDatasource, NetworkInfoImpl(InternetConnectionChecker()));
  });

  group("Test MainRepository", () {
    test("Search Repositories - Failed Case, Empty Or Null Api response",
        () async {
      when(mockDatasource.getMainInfo('shop', isMock: true))
          .thenAnswer((realInvocation) async {
        return actualReposEmptyListData;
      });
      dynamic result;
      try {
        result = await mainRepositoryImpl.getMainInfo(mainParams);
      } catch (e) {
        result = e;
      }
      expect(result.value, expectedReposEmptyListData.value);
    });

    test("Search Repositories - Success Case", () async {
      when(mockDatasource.getMainInfo('shop', isMock: true))
          .thenAnswer((realInvocation) async {
        return actualReposNotEmptyListData;
      });
      dynamic result;
      try {
        result = await mainRepositoryImpl.getMainInfo(mainParams);
      } catch (e) {
        result = e;
      }
      expect(result.value, expectedReposListData.value);

    });
  });
}