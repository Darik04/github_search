import 'package:github_search/core/error/exceptions.dart' as ex;
import 'package:github_search/features/main/data/datasources/main/remote_datasource.dart';
import 'package:github_search/features/main/data/models/repo_model.dart';
import 'package:github_search/features/main/domain/enities/main_entity.dart';
import 'package:github_search/features/main/domain/enities/repo_entity.dart';
import 'package:graphql_flutter/graphql_flutter.dart';


class MainGraphQLRemoteDataSourceImpl
    implements MainRemoteDataSource {
  final GraphQLClient client;

  MainGraphQLRemoteDataSourceImpl({required this.client});



  /// Get main info 
  @override
  Future<MainEntity> getMainInfo(String query, {bool isMock = false}) async {

    try{

      final getUsersQuery = '''{
  search(query: "$query", type: REPOSITORY, first: 3) {
    repositoryCount
    edges {
      node {
        ... on Repository {
          name
          description
          stargazers {totalCount}
        }
      }
    }
  }
}''';

      final QueryOptions options = QueryOptions(document: gql(getUsersQuery));
      
      final QueryResult response = await client.query(options);

      if(response.data != null && !response.hasException){
        List<RepoEntity> repositories = (response.data!['search']['edges'] as List)
            .map((json) => RepoModel.fromJsonGraphQL(json))
            .toList();

        return MainEntity(
          totalCount: response.data!['search']['repositoryCount'],//For Example total count 
          items: repositories,
        );
      }
      throw ex.ServerException(message: 'Ошибка с сервером');
    }catch(e){
      throw ex.ServerException(message: e.toString());
    }
  }


}
