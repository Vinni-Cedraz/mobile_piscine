// ignore_for_file: file_names

import 'package:flutter/material.dart';

class BottomBar {
  TabBar buildTabBar() {
    return const TabBar(
      tabs: [
        Tab(icon: Icon(Icons.calendar_today), text: 'Currently'),
        Tab(icon: Icon(Icons.today), text: 'Today'),
        Tab(icon: Icon(Icons.view_week), text: 'Weekly'),
      ],
    );
  }
}
