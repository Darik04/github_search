
import 'package:github_search/features/main/data/models/repo_model.dart';
import 'package:github_search/features/main/domain/enities/main_entity.dart';

const MainEntity actualReposEmptyListData = MainEntity(
  totalCount: 0,
  items: []
);

const MainEntity actualReposNotEmptyListData = MainEntity(
  totalCount: 0,
  items: [
    RepoModel(title: 'Name', stars: 30, description: 'desc'),
    RepoModel(title: 'Name2', stars: 30, description: 'desc2'),
  ]
);
