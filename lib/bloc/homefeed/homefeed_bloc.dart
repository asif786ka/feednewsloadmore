import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:feednewsloadmore/model/article.dart';
import 'package:feednewsloadmore/repository/articlesnews_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

part 'homefeed_event.dart';
part 'homefeed_state.dart';

class HomeFeedBloc extends Bloc<HomeEvent, HomeFeedState> {

  static const pageSize = 20;
  final ArticlesRepository articleRepository;
  int _pageNum = 1;
  bool _isSearchExhausted = false;
  bool _isFetching = false;
  final List<Article> _articles = [];

  HomeFeedBloc({required this.articleRepository}) : super(HomeInitial()) {
    log("HomeBloc init..");
    on<FetchArticles>(_onFetchArticles);
  }

  _onFetchArticles(FetchArticles event, Emitter<HomeFeedState> emit) async {
    if (!_isSearchExhausted && !_isFetching) {
      _isFetching = true;
      emit(_pageNum <= 1
          ? Loading()
          : ArticlesLoaded(articles: _articles, query: event.searchKey, isFetchingMore: true));
      final articlesToAdd = await articleRepository.getPageTopHeadlines(_pageNum, event.searchKey);
      if (articlesToAdd.length < pageSize) {
        _isSearchExhausted = true;
      }
      _articles.addAll(articlesToAdd);
      emit(ArticlesLoaded(articles: _articles, query: event.searchKey, isFetchingMore: false));
      _pageNum++;
      _isFetching = false;
    }
  }
}
