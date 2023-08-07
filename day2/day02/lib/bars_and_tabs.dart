import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'tabcontent.dart';

class TopBar {
  final Function(String) updateLastSearchText;
  final Function(Position) updatePosition;
  final Position currentPosition;
  const TopBar({
    required this.updateLastSearchText,
    required this.updatePosition,
    required this.currentPosition,
  });
  AppBar buildAppBar() => AppBar(
          title: TopRowWidgets(
        updateLastSearchText: updateLastSearchText,
        currentPosition: currentPosition,
        updatePosition: updatePosition,
      ));
}

class TopRowWidgets extends StatelessWidget {
  final Function(String) updateLastSearchText;
  final Function(Position) updatePosition;
  final Position currentPosition;
  const TopRowWidgets(
      {super.key,
      required this.updateLastSearchText,
      required this.updatePosition,
      required this.currentPosition});
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
              onPressed: () => updatePosition(currentPosition),
              icon: const Icon(Icons.location_on),
            ),
          ),
        ],
      );
}

class MiddleBarViews {
  final String lastSearchText;
  final Position currentPosition;
  MiddleBarViews({required this.lastSearchText, required this.currentPosition});
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
