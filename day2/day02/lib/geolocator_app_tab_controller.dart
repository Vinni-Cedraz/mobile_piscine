import 'package:flutter/material.dart';
import 'bars_and_tabs.dart';

class GeolocatorAppTabController {
  final String lastSearchText;
  final Function(String) updateLastSearchText;
  final Function() updatePosition;
  GeolocatorAppTabController({
    required this.lastSearchText,
    required this.updateLastSearchText,
    required this.updatePosition,
  });

  get tabController => DefaultTabController(
        length: 3,
        initialIndex: 0,
        child: Scaffold(
          appBar: TopBar(
            updateLastSearchText: updateLastSearchText,
            updatePosition: updatePosition,
          ).buildAppBar(),
          body: MiddleBarViews(
            lastSearchText: lastSearchText,
          ).buildTabBarView(),
          bottomNavigationBar: BottomBar().buildTabBar(),
        ),
      );
}
