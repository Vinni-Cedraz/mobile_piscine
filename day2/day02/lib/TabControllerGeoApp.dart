// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'TopBar.dart';
import 'MiddleBarViews.dart';
import 'BottomBar.dart';

class TabControllerGeoApp {
  final Map<String, String> lastSearchText;
  final Function(Map<String, String>, String suggestion) updateLastSearchText;
  final Function() updatePosition;
  TabControllerGeoApp({
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
