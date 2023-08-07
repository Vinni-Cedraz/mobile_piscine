import 'package:flutter/material.dart';

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
          appBar: topBar(),
          body: middleBarViews(),
          bottomNavigationBar: bottomBar(),
        ),
      );

  middleBarViews() => TabBarView(
        children: [
          TabContent(title: 'Currently\n$lastSearchText'),
          TabContent(title: 'Today\n$lastSearchText'),
          TabContent(title: 'Weekly\n$lastSearchText'),
        ],
      );

  topBar() => AppBar(
        title: Row(
          children: topRowWidgets(),
        ),
      );

  topRowWidgets() => [
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
            onPressed: () => updateLastSearchText('Geolocator'),
            icon: const Icon(Icons.location_on),
          ),
        ),
      ];

  bottomBar() => const TabBar(
        tabs: [
          Tab(icon: Icon(Icons.calendar_today), text: 'Currently'),
          Tab(icon: Icon(Icons.today), text: 'Today'),
          Tab(icon: Icon(Icons.view_week), text: 'Weekly'),
        ],
      );
}

class TabContent extends StatelessWidget {
  final String title;
  const TabContent({Key? key, required this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(title),
    );
  }
}
