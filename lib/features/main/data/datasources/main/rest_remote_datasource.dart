import 'package:dio/dio.dart';
import 'package:github_search/constants/credentials.dart';
import 'package:github_search/core/error/exceptions.dart';
import 'package:github_search/core/services/network/endpoints.dart';
import 'package:github_search/core/utils/helpers/dio_helper.dart';
import 'package:github_search/features/main/data/datasources/main/remote_datasource.dart';
import 'package:github_search/features/main/data/models/repo_model.dart';
import 'package:github_search/features/main/domain/enities/main_entity.dart';
import 'package:github_search/features/main/domain/enities/repo_entity.dart';


class MainRESTRemoteDataSourceImpl
    implements MainRemoteDataSource {
  final Dio dio;

  MainRESTRemoteDataSourceImpl({required this.dio});



  /// Get main info 
  @override
  Future<MainEntity> getMainInfo(String query, {bool isMock = false}) async {

    try{
      Response response = await dio.get(Endpoints.search.getPath(params: [query]),
        options: isMock
        ? null
        : Options(
          headers: Endpoints.search.getHeaders(defaultHeaders: {
            'Authorization': 'Token ${CredentialsData.githubAccessToken}'
          }),
          validateStatus: (status) => status! < 501,
        ));
      
      //My Debugger
      printRes(response);


      if (response.statusCode == 200) {
        final items = response.data['items'] as List;
        List<RepoEntity> repositories = [];

        for (var i = 0; i < items.length; i++) {
          Response responseItem = await dio.get(items[i]['repository']['stargazers_url'],
          options: isMock
          ? null
          : Options(
            headers: Endpoints.search.getHeaders(),
            validateStatus: (status) => status! < 501,
          ));

          final stargazersCount = (responseItem.data as List).length;

          repositories.add(RepoModel.fromJsonREST(items[i], stargazersCount));
        }

        return MainEntity(
          totalCount: response.data['total_count'],//For Example total count 
          items: repositories,
        );
      }
      throw ServerException(message: 'Ошибка с сервером');
    }catch(e){
      throw ServerException(message: 'Ошибка с сервером');
    }
  }


}
