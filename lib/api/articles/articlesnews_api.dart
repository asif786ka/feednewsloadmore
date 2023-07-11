import 'package:feednewsloadmore/api/articles/responses/get_feednews_response.dart';
import 'package:feednewsloadmore/bloc/homefeed/homefeed_bloc.dart';
import 'package:feednewsloadmore/constants/constants.dart';
import 'package:feednewsloadmore/network/diofeed_client.dart';
import 'package:flutter/cupertino.dart';

class ArticlesApi {

  static const _everything = 'everything';
  static const _topHeadlines = 'top-headlines';

  late final DioFeedClient dioClient = DioFeedClient.instance;

  ArticlesApi();

  Future<GetEverythingResponse> getEverything() async {
    try {
      await Future.delayed(const Duration(seconds: DioFeedClient.testDelaySec));
      final response = await dioClient.get(
          _everything,
          queryParameters: {'apiKey': Constants.apiKey, 'q': ''}
      );
      return response as GetEverythingResponse;
    } catch (e) {
      rethrow;
    }
  }

  Future<GetEverythingResponse> getTopHeadlines(int pageNum, String? query) async {
    try {
      await Future.delayed(const Duration(seconds: DioFeedClient.testDelaySec));
      final response = await dioClient.get(_topHeadlines, queryParameters: {
        'apiKey': Constants.apiKey,
        'country': 'us',
        'page': pageNum,
        'q': query,
        'pageSize': HomeFeedBloc.pageSize,
      });
      return GetEverythingResponse.fromJson(response.data);
    } catch (e) {
      debugPrint("ArticlesApi: Exception - $e");
      rethrow;
    }
  }
}