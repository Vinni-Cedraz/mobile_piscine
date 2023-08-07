// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'geolocator_app_tab_controller.dart';

class MyGeolocatorApp extends StatefulWidget {
  const MyGeolocatorApp({super.key});
  @override
  State<MyGeolocatorApp> createState() => _MyGeolocatorAppState();
}

class _MyGeolocatorAppState extends State<MyGeolocatorApp> {
  String lastSearchText = '';

  void updateLastSearchText(String searchText) => setState(() {
        lastSearchText = searchText;
      });

  @override
  Widget build(BuildContext context) => GeolocatorAppTabController(
        lastSearchText: lastSearchText,
        updateLastSearchText: updateLastSearchText,
      ).tabController;
}
