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
                'Currently\n${lastSearchText['currently'] ?? ''}'),
        TabContent(
            content:
                'Today\n${lastSearchText['today'] ?? ''}'),
        TabContent(
            content:
                'Weekly\n${lastSearchText['weekly'] ?? ''}'),
      ],
    );
  }
}
