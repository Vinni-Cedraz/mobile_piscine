import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyGeolocatorApp(),
    );
  }
}

class MyGeolocatorApp extends StatefulWidget {
  const MyGeolocatorApp({super.key});

  @override
  State<MyGeolocatorApp> createState() => _MyGeolocatorApp();
}

class _MyGeolocatorApp extends State<MyGeolocatorApp> {
  String lastSearchText = '';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        appBar: topBar(),
        body: TabBarView(
          children: [
            TabContent(title: 'Currently\n$lastSearchText'),
            TabContent(title: 'Today\n$lastSearchText'),
            TabContent(title: 'Weekly\n$lastSearchText'),
          ],
        ),
        bottomNavigationBar: bottomBar(),
      ),
    );
  }

  AppBar topBar() {
    return AppBar(
      title: Row(
        children: topRowWidgets(),
      ),
    );
  }

  List<Widget> topRowWidgets() => [
        Expanded(
          flex: 2,
          child: TextField(
            onChanged: (text) {
              setState(() {
                lastSearchText = text;
              });
            },
            decoration: const InputDecoration(
              hintText: 'Search...',
              icon: Icon(Icons.search),
            ),
          ),
        ),
        Expanded(
          child: IconButton(
            onPressed: () {
              setState(() {
                lastSearchText = 'Geolocator';
              });
            },
            icon: const Icon(Icons.location_on),
          ),
        ),
      ];

  BottomAppBar bottomBar() {
    return const BottomAppBar(
        child: TabBar(
      tabs: [
        Tab(icon: Icon(Icons.calendar_today), text: 'Currently'),
        Tab(icon: Icon(Icons.today), text: 'Today'),
        Tab(icon: Icon(Icons.view_week), text: 'Weekly'),
      ],
    ));
  }
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
