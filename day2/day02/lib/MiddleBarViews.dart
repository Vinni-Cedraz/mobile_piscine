// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'TabContent.dart';

class MiddleBarViews {
  final String lastSearchText;
  MiddleBarViews({required this.lastSearchText});
  TabBarView buildTabBarView() {
    return TabBarView(
      children: [
        TabContent(title: 'Currently\n$lastSearchText'),
        TabContent(title: 'Today\n$lastSearchText'),
        TabContent(title: 'Weekly\n$lastSearchText'),
      ],
    );
  }
}
