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
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
				initialIndex: 0,
        child: Scaffold(
          appBar: AppBar(
          ),
          body: const TabBarView(
            children: [
              TabContent(title: 'Currently'),
              TabContent(title: 'Today'),
              TabContent(title: 'Weekly'),
            ],
          ),
          bottomNavigationBar: const BottomAppBar(
            child: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.calendar_today), text: 'Currently'),
                Tab(icon: Icon(Icons.today), text: 'Today'),
                Tab(icon: Icon(Icons.view_week), text: 'Weekly'),
              ],
            ),
          ),
        ));
  }
}

class TabContent extends StatelessWidget {
  final String title;

  const TabContent({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(title),
    );
  }
}
