import 'dart:developer';

import 'package:feednewsloadmore/bloc/homefeed/homefeed_bloc.dart';
import 'package:feednewsloadmore/bloc/navbar_main/navbar_main_bloc.dart';
import 'package:feednewsloadmore/constants/app_colors.dart';
import 'package:feednewsloadmore/enums/nav_bar_item.dart';
import 'package:feednewsloadmore/repository/articlesnews_repository.dart';
import 'package:feednewsloadmore/ui/pages/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'favorites/favoritesfeed_page.dart';
import 'home/homefeed_page.dart';

class NavbarMainPage extends StatelessWidget {

  final PageController _pageController = PageController();

  final _navbarPages = [
    const HomePage(),
    const FavoritePage(),
    const ProfilePage()
  ];

  final List<NavigationDestination> _navDestinations = [
    NavigationDestination(
        icon: Icon(NavbarItem.home.icon, color: AppColors.iconColor),
        label: NavbarItem.home.title
    ),
    NavigationDestination(
        icon: Icon(NavbarItem.favorites.icon, color: AppColors.iconColor),
        label: NavbarItem.favorites.title
    ),
    NavigationDestination(
        icon: Icon(NavbarItem.profile.icon, color: AppColors.iconColor),
        label: NavbarItem.profile.title
    ),
  ];

  NavbarMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NavbarMainBloc(),
        ),
        BlocProvider(
          create: (context) =>
              HomeFeedBloc(
                  articleRepository: context.read<ArticlesRepository>()
              ),
        ),
      ],
      child: _navBarMainView(),
    );
  }

  Scaffold _navBarMainView() {
    return Scaffold(
      body: BlocListener<NavbarMainBloc, NavbarMainState>(
        listener: (context, state) {
          _pageController.jumpToPage(state.item.index);
        },
        child: PageView(
          controller: _pageController,
          onPageChanged: _onPageChanged,
          physics: const NeverScrollableScrollPhysics(),
          children: _navbarPages,
        ),
      ),
      bottomNavigationBar: _bottomNavigationBarView(),
    );
  }

  Widget _bottomNavigationBarView() {
    return BlocBuilder<NavbarMainBloc, NavbarMainState>(
        builder: (context, state) {
          return NavigationBarTheme(
            data: NavigationBarThemeData(
              backgroundColor: AppColors.appBackground,
              indicatorColor: Colors.amber[800],
            ),
            child: NavigationBar(
              height: 64,
              destinations: _navDestinations,
              labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
              selectedIndex: state.item.index,
              onDestinationSelected: (index) =>
                  context.read<NavbarMainBloc>().add(
                      NavbarItemPressed(NavbarItem.values.elementAt(index))),
            ),
          );
        },
      );
  }

  void _onPageChanged(int value) {
    log("_onPageChanged: page $value");
  }

}
