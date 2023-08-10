// ignore_for_file: file_names, avoid_print

import 'package:geolocator/geolocator.dart';
import 'determine_position.dart' as geolib;
import 'package:flutter/material.dart';
import 'TabControllerGeoApp.dart';
import 'ModuleForWeatherApi.dart';

class MyGeolocatorApp extends StatefulWidget {
  const MyGeolocatorApp({super.key});
  @override
  State<MyGeolocatorApp> createState() => _MyGeolocatorAppState();
}

class _MyGeolocatorAppState extends State<MyGeolocatorApp> {
  Position? position;

  Map<String, String> lastSearchText = {
    'currently': "Current weather text goes here...",
    'today': "Today's weather text goes here...",
    'weekly': "Weekly weather text goes here...",
  };

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _updateLastSearchText(Map<String, String> searchText) => setState(() {
        lastSearchText = searchText;
      });

  _getCurrentLocation() async {
    position ??= await geolib.determinePosition();
    try {
      final List<String> weatherToday = await WeatherByLocation(
              latitude: position!.latitude, longitude: position!.longitude)
          .fetchTodayWeather();
      setState(() {
        lastSearchText['today'] = weatherToday.join('\n');
      });
    } catch (e) {
      setState(() {
        lastSearchText['today'] = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) => TabControllerGeoApp(
        lastSearchText: lastSearchText,
        updatePosition: _getCurrentLocation,
        updateLastSearchText: _updateLastSearchText,
      ).tabController;
}
