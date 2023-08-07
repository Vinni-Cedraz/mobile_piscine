import 'package:flutter/material.dart';
import 'bars_and_tabs.dart';

class GeolocatorAppTabController {
  final String lastSearchText;
  final Function(String) updateLastSearchText;
  GeolocatorAppTabController({
    required this.lastSearchText,
    required this.updateLastSearchText,
  });

  get tabController => DefaultTabController(
        length: 3,
        initialIndex: 0,
        child: Scaffold(
          appBar:
              TopBar(updateLastSearchText: updateLastSearchText).buildAppBar(),
          body:
              MiddleBarViews(lastSearchText: lastSearchText).buildTabBarView(),
          bottomNavigationBar:
							BottomBar().buildTabBar(),
        ),
      );
}
