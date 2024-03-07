import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/core/error/exceptions.dart';
import 'package:github_search/core/services/network/endpoints.dart';
import 'package:github_search/features/main/data/datasources/main/remote_datasource.dart';
import 'package:github_search/features/main/data/datasources/main/rest_remote_datasource.dart';
import 'package:github_search/features/main/domain/usecases/get_main_info.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'main_remote_datasource_test.mocks.dart';
import 'mock_data/actual_repo_json.dart';
import 'mock_data/expected_repo_data.dart';



@GenerateMocks([Dio])
void main() {
  const GetMainParams mainParams = GetMainParams(query: 'shop', isMock: true);

  late MockDio mockDio;

  late MainRemoteDataSource mainRemoteDataSource;
  setUp(() {
    mockDio = MockDio();
    mainRemoteDataSource = MainRESTRemoteDataSourceImpl(dio: mockDio);
  });

  RequestOptions requestOptions = RequestOptions(path: Endpoints.search.getPath(params: [mainParams.query]));

  group("Test MainRemoteDataSource", () {
    test("Search Repositories - Failed Case", () async {


      when(mockDio.get(
        Endpoints.search.getPath(params: [mainParams.query]),
      )).thenAnswer((realInvocation) async {
        return Response(requestOptions: requestOptions, statusCode: 400);
      });

      Object result;

      try {
        result = await mainRemoteDataSource.getMainInfo(mainParams.query);
      } catch (e) {
        result = e;
      }

      expect(result, ServerException(message: 'Ошибка с сервером'));
    });



    test("Search Repositories - Empty Case", () async {
      when(mockDio.get(
        Endpoints.search.getPath(params: [mainParams.query]),
      ))
          .thenAnswer((realInvocation) async {

        return Future.value(Response(
          requestOptions: requestOptions,
          statusCode: 200,
          data: actualReposEmptyJson,
        ));
      });
      Object result;
      try {
        // Compare actual result with expected result
        result = await mainRemoteDataSource.getMainInfo(mainParams.query, isMock: true);
      } catch (e) {
        result = e;
      }
      expect(result, expectedReposEmptyListData);
    });

    test("Search Repositories - Not Empty Case", () async {
      when(mockDio.get(
        Endpoints.search.getPath(params: [mainParams.query]),
      ))
          .thenAnswer((realInvocation) async {
        // Actual result
        return Future.value(Response(
          requestOptions: requestOptions,
          statusCode: 200,
          data: actualReposOneItemJson,
        ));
      });

      when(mockDio.get(
        'https://api.github.com/repos/aosabook/500lines/stargazers',
      ))
          .thenAnswer((realInvocation) async {
        // Actual result
        return Future.value(Response(
          requestOptions: requestOptions,
          statusCode: 200,
          data: List.generate(30, (index) => {}),
        ));
      });

      
      Object result;
      try {
        // Compare actual result with expected result
        result = await mainRemoteDataSource.getMainInfo(mainParams.query, isMock: true);
      } catch (e) {
        result = e;
      }
      expect(result, expectedReposNotEmptyListData);
    });
  });
}