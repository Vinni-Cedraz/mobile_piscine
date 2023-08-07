import 'package:flutter/material.dart';
import 'tabcontent.dart';

class TopBar {
  final Function(String) updateLastSearchText;
  final Function() updatePosition;
  const TopBar({
    required this.updateLastSearchText,
    required this.updatePosition,
  });
  AppBar buildAppBar() => AppBar(
          title: TopRowWidgets(
        updateLastSearchText: updateLastSearchText,
        updatePosition: updatePosition,
      ));
}

class TopRowWidgets extends StatelessWidget {
  final Function(String) updateLastSearchText;
  final Function() updatePosition;
  const TopRowWidgets({
    super.key,
    required this.updateLastSearchText,
    required this.updatePosition,
  });

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Expanded(
            flex: 2,
            child: TextField(
              onSubmitted: (text) => updateLastSearchText(text),
              decoration: const InputDecoration(
                hintText: 'Search...',
                icon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: IconButton(
              onPressed: () => updatePosition(),
              icon: const Icon(Icons.location_on),
            ),
          ),
        ],
      );
}

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
