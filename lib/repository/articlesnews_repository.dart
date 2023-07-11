import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:feednewsloadmore/api/articles/articlesnews_api.dart';
import 'package:feednewsloadmore/api/articles/responses/get_feednews_response.dart';
import 'package:feednewsloadmore/model/article.dart';
import 'package:feednewsloadmore/network/diofeed_exceptions.dart';

class ArticlesRepository {

  final ArticlesApi articlesApi = ArticlesApi();

  ArticlesRepository();

  Future<List<Article>> getEveryArticles() async {
    try {
      final GetEverythingResponse response = await articlesApi.getEverything();
      return response.articles.map((articleDto) =>
          Article.fromDto(articleDto)
      ).toList();
    } on DioError catch (e) {
      final errorMessage = DioFeedExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<List<Article>> getPageTopHeadlines(int pageNum, String? query) async {
    try {
      log("ArticlesRepository: getPageTopHeadlines(): pageNum = $pageNum");
      final GetEverythingResponse response = await articlesApi.getTopHeadlines(
          pageNum,
          query
      );
      return response.articles.map((articleDto) =>
          Article.fromDto(articleDto)
      ).toList();
    } on DioError catch (e) {
      final errorMessage = DioFeedExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

}