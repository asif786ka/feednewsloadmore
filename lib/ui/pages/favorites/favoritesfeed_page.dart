import 'dart:developer';

import 'package:feednewsloadmore/bloc/homefeed/homefeed_bloc.dart';
import 'package:feednewsloadmore/constants/app_colors.dart';
import 'package:feednewsloadmore/enums/nav_bar_item.dart';
import 'package:feednewsloadmore/ui/widgets/app_bars/main_app_bar.dart';
import 'package:feednewsloadmore/ui/widgets/favorite_article_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';



class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<StatefulWidget> createState() => FavoritePageState();
}

class FavoritePageState extends State<FavoritePage>
    with AutomaticKeepAliveClientMixin {
  final _scrollController = ScrollController();

  FavoritePageState() {
    log("FavoritePageState: init..");
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: AppColors.surfaceBg,
      appBar: MainAppBar(title: NavbarItem.favorites.title),
      body: _favoritesArticlesView(),
    );
  }

  Widget _favoritesArticlesView() {
    return BlocBuilder<HomeFeedBloc, HomeFeedState>(
      builder: (context, state) {
        log("favorite_page: state = $state");
        if (state is HomeInitial) {
          context.read<HomeFeedBloc>().add(FetchArticles());
        }
        if (state is ArticlesLoaded) {
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: state.articles.length,
            itemBuilder: (context, position) {
              return FavoriteArticleCard(article: state.articles[position]);
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 4);
            },
            controller: _scrollController
              ..addListener(() {
                _onScroll(context);
              }),
          );
        }
        return const SpinKitWave(
          color: AppColors.appBackground,
        );
      },
    );
  }

  void _onScroll(BuildContext context) {
    final fetchingTh = 0.95 * _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (currentScroll >= fetchingTh) {
      log("FavoritePage: End of scroll..");
      context.read<HomeFeedBloc>().add(FetchArticles());
    }
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
