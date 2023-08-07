// ignore_for_file: file_names, avoid_print

import 'package:geolocator/geolocator.dart';
import 'determine_position.dart' as geolib;
import 'package:flutter/material.dart';
import 'geolocator_app_tab_controller.dart';

class MyGeolocatorApp extends StatefulWidget {
  const MyGeolocatorApp({super.key});
  @override
  State<MyGeolocatorApp> createState() => _MyGeolocatorAppState();
}

class _MyGeolocatorAppState extends State<MyGeolocatorApp> {
  late Position _currentPosition;
  String lastSearchText = '';

  void _updateLastSearchText(String searchText) => setState(() {
        lastSearchText = searchText;
      });

  void _updatePosition(Position searchText) => setState(() {
        lastSearchText = '${searchText.latitude}, ${searchText.longitude}';
      });

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await geolib.determinePosition();
      setState(() {
        _currentPosition = position;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) => GeolocatorAppTabController(
        lastSearchText: lastSearchText,
        currentPosition: _currentPosition,
        updatePosition: _updatePosition,
        updateLastSearchText: _updateLastSearchText,
      ).tabController;
}
