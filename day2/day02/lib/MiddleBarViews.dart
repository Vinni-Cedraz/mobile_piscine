// ignore_for_file: file_names

import 'package:flutter/material.dart';

class TabContent extends StatelessWidget {
  final String content;
  const TabContent({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Text(content),
      ),
    );
  }
}

class MiddleBarViews {
  final Map<String, String> lastSearchText;
  MiddleBarViews({
    required this.lastSearchText,
  });

  TabBarView buildTabBarView() {
    return TabBarView(
      children: [
        TabContent(
            content:
                '\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\tCurrently\n\n${lastSearchText['currently'] ?? ''}'),
        TabContent(
            content:
                '\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\tToday\n\n${lastSearchText['today'] ?? ''}'),
        TabContent(
            content:
                '\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\tWeekly\n\n${lastSearchText['weekly'] ?? ''}'),
      ],
    );
  }
}
