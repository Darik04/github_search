part of 'repo_bloc.dart';

abstract class RepoState extends Equatable {
  const RepoState();
  @override
  List<Object> get props => [];
}

class RepoInitialState extends RepoState {}
class RepoLoadingState extends RepoState {}
class RepoErrorState extends RepoState {
  final String message;
  RepoErrorState({required this.message});
}
class RepoInternetErrorState extends RepoState{}

class GotSuccessRepoState extends RepoState{}
class RepoBlankState extends RepoState{}