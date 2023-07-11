part of 'homefeed_bloc.dart';

@immutable
abstract class HomeFeedState extends Equatable {}

class HomeInitial extends HomeFeedState {
  @override
  List<Object?> get props => [];
}

class ArticlesLoaded extends HomeFeedState {
  ArticlesLoaded({
    required this.articles,
    required this.query,
    required this.isFetchingMore,
  });

  final List<Article> articles;
  final String? query;
  bool isFetchingMore;

  @override
  List<Object?> get props => [articles, query, isFetchingMore];
}

class Loading extends HomeFeedState {

  @override
  List<Object?> get props => [];
}

class Error extends HomeFeedState {
  Error({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}