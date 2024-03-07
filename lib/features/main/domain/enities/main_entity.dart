import 'package:equatable/equatable.dart';
import 'package:github_search/features/main/domain/enities/repo_entity.dart';

class MainEntity extends Equatable {
  final int totalCount;
  final List<RepoEntity> items;

  const MainEntity({
    required this.totalCount,
    required this.items,
  });


  @override
  List<Object> get props => [
    totalCount,
    items
  ];
}
