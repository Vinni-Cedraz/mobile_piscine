// ignore_for_file: file_names, avoid_print

import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'TabControllerGeoApp.dart';
import 'ModuleForWeatherApi.dart';
import 'ModuleForGeocodingApi.dart';

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

  _updateLastSearchText(
      Map<String, String> searchText, String suggestion) async {
    String suggestion = "John Doe California";
    List<String> parts = suggestion.split(' ');

    String name = parts[0];
    String admin1 = parts.length == 3 ? parts[1] : '';
    String country = parts[parts.length - 1];
    position =
        await DeterminePosition(name: name, admin1: admin1, country: country)
            .determinePosition();

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

    try {
      final List<String> weeklyWeather = await WeatherByLocation(
              latitude: position!.latitude, longitude: position!.longitude)
          .fetchWeekWeather();
      setState(() {
        lastSearchText['weekly'] = weeklyWeather.join('\n');
      });
    } catch (e) {
      setState(() {
        lastSearchText['weekly'] = e.toString();
      });
    }

    try {
      final List<String> currentWeather = await WeatherByLocation(
              latitude: position!.latitude, longitude: position!.longitude)
          .fetchCurrentWeather();
      setState(() {
        lastSearchText['currently'] = currentWeather.join('\n');
      });
    } catch (e) {
      setState(() {
        lastSearchText['currently'] = e.toString();
      });
    }
  }

  _getCurrentLocation() async {
    position ??= await DeterminePosition().determinePosition();

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

    try {
      final List<String> weeklyWeather = await WeatherByLocation(
              latitude: position!.latitude, longitude: position!.longitude)
          .fetchWeekWeather();
      setState(() {
        lastSearchText['weekly'] = weeklyWeather.join('\n');
      });
    } catch (e) {
      setState(() {
        lastSearchText['weekly'] = e.toString();
      });
    }

    try {
      final List<String> currentWeather = await WeatherByLocation(
              latitude: position!.latitude, longitude: position!.longitude)
          .fetchCurrentWeather();
      setState(() {
        lastSearchText['currently'] = currentWeather.join('\n');
      });
    } catch (e) {
      setState(() {
        lastSearchText['currently'] = e.toString();
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
