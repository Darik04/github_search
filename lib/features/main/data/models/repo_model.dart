import 'package:github_search/features/main/domain/enities/repo_entity.dart';

class RepoModel extends RepoEntity{
  const RepoModel({
    required String title,
    required int stars,
    required String description,

  }) : super(
    title: title,
    stars: stars,
    description: description
  );

  factory RepoModel.fromJsonREST(Map<String, dynamic> json, int starsCount) {
    return RepoModel(
      title: json['name'],
      description: json['repository']['description'] ?? '',
      stars: starsCount,
    );
  }


  factory RepoModel.fromJsonGraphQL(Map<String, dynamic> json) {
    return RepoModel(
      title: json['node']['name'],
      description: json['node']['description'] ?? '',
      stars: json['node']['stargazers']['totalCount'] ?? 0,
    );
  }
}