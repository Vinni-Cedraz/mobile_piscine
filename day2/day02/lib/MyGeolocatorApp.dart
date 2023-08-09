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
  String lastSearchText = '';
  void _updateLastSearchText(String searchText) => setState(() {
        lastSearchText = searchText;
      });

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  _getCurrentLocation() async {
    try {
      Position position = await geolib.determinePosition();
      setState(() {
        lastSearchText = WeatherByLocation(latitude: position.latitude, longitude: position.longitude).fetchTodayWeather()[0];
      });
    } catch (e) {
      setState(() {
        lastSearchText = e.toString();
      });
    }
    print(lastSearchText);
  }

  @override
  Widget build(BuildContext context) => TabControllerGeoApp(
        lastSearchText: lastSearchText,
        updatePosition: _getCurrentLocation,
        updateLastSearchText: _updateLastSearchText,
      ).tabController;
}
