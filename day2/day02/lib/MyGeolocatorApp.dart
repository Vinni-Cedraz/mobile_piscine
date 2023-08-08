// ignore_for_file: file_names, avoid_print

import 'package:geolocator/geolocator.dart';
import 'determine_position.dart' as geolib;
import 'package:flutter/material.dart';
import 'TabControllerGeoApp.dart';

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
        lastSearchText =
            '${_currentPosition.latitude}, ${_currentPosition.longitude}';
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) => TabControllerGeoApp(
        lastSearchText: lastSearchText,
        updatePosition: _getCurrentLocation,
        updateLastSearchText: _updateLastSearchText,
      ).tabController;
}
