import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:github_search/constants/credentials.dart';
import 'package:github_search/core/services/network/endpoints.dart';
import 'package:github_search/features/auth/data/datasources/auth/remote_datasource.dart';
import 'package:github_search/features/auth/data/repositories/login_repository_impl.dart';
import 'package:github_search/features/auth/domain/repositories/login/login_repository.dart';
import 'package:github_search/features/auth/domain/usecases/auth_signin.dart';
import 'package:github_search/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:github_search/features/main/data/datasources/main/graphql_remote_datasource.dart';
import 'package:github_search/features/main/data/datasources/main/remote_datasource.dart';
import 'package:github_search/features/main/data/datasources/main/rest_remote_datasource.dart';
import 'package:github_search/features/main/data/repositories/main_repository_impl.dart';
import 'package:github_search/features/main/domain/repositories/main/main_repository.dart';
import 'package:github_search/features/main/domain/usecases/get_main_info.dart';
import 'package:github_search/features/main/presentation/bloc/repo/repo_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'constants/main_config_app.dart';
import 'core/services/database/auth_params.dart';
import 'core/services/network/config.dart';
import 'core/services/network/network_info.dart';


final sl = GetIt.instance;

void setupInjections() {

  //Main config of system
  sl.registerLazySingleton<MainConfigApp>(() => MainConfigApp());


  //! External
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  sl.registerFactory<Dio>(
    () => Dio(BaseOptions(
      baseUrl: Config.url.url,
    )),
  );

  sl.registerFactory<GraphQLClient>(
    () => GraphQLClient(
      link: HttpLink(Endpoints.gitHubGraphQL.getPath(), defaultHeaders: {
        'Authorization': 'Token ${CredentialsData.githubAccessToken}'
      }),
      cache: GraphQLCache(),
    )
  );

  ///Authentication
  sl.registerLazySingleton<AuthConfig>(() => AuthConfig());

  //Datasources
  sl.registerLazySingleton<AuthenticationRemoteDataSource>(
    () => AuthenticationRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<MainRemoteDataSource>(
    () => MainConfigApp.dataSourceType == DataSourceType.rest
          ? MainRESTRemoteDataSourceImpl(dio: sl()) 
          : MainGraphQLRemoteDataSourceImpl(client: sl()), 
  );

  //Repositories
  sl.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(sl(), sl()),
  );
  sl.registerLazySingleton<MainRepository>(
    () => MainRepositoryImpl(sl(), sl()),
  );

  //UseCases
  sl.registerLazySingleton(() => AuthSignIn(sl()));
  sl.registerLazySingleton(() => GetMainInfo(sl()));

  //Blocs
  sl.registerFactory<AuthBloc>(
    () => AuthBloc(sl()),
  );
  sl.registerFactory<RepoBloc>(
    () => RepoBloc(sl()),
  );



















}
