import 'package:equatable/equatable.dart';

class RepoEntity extends Equatable {
  final String title;
  final String description;
  final int stars;

  const RepoEntity({
    required this.title,
    required this.stars,
    required this.description,
  });


  @override
  List<Object> get props => [
    title,
    stars,
    description
  ];
}
