import 'package:feednewsloadmore/enums/nav_bar_item.dart';
import 'package:feednewsloadmore/ui/widgets/app_bars/main_app_bar.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: MainAppBar(
      title: NavbarItem.profile.title
    ),
    body: Center(
        child: Text(
          NavbarItem.profile.title,
          style: const TextStyle(fontSize: 72),
        )),
  );

}