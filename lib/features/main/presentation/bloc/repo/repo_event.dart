part of 'repo_bloc.dart';


abstract class RepoEvent extends Equatable {
  @override
  List<Object?> get props => [];
}


class GetRepoEvent extends RepoEvent{
  final String? query;
  GetRepoEvent({this.query});
}
