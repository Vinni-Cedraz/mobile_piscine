import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'bars_and_tabs.dart';

class GeolocatorAppTabController {
  final String lastSearchText;
  final Position currentPosition;
  final Function(String) updateLastSearchText;
  final Function(Position) updatePosition;
  GeolocatorAppTabController({
    required this.lastSearchText,
    required this.updateLastSearchText,
    required this.currentPosition,
    required this.updatePosition,
  });

  get tabController => DefaultTabController(
        length: 3,
        initialIndex: 0,
        child: Scaffold(
          appBar: TopBar(
            updateLastSearchText: updateLastSearchText,
            currentPosition: currentPosition,
            updatePosition: updatePosition,
          ).buildAppBar(),
          body: MiddleBarViews(
                  lastSearchText: lastSearchText,
                  currentPosition: currentPosition)
              .buildTabBarView(),
          bottomNavigationBar: BottomBar().buildTabBar(),
        ),
      );
}
