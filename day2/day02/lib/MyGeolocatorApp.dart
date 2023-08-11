// ignore_for_file: file_names, avoid_print

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
  MyPosition? position;

  Map<String, String> lastSearchText = {
    'currently': "",
    'today': "",
    'weekly': "",
  };

  _updateLastSearchTextByCityName(
      Map<String, String> searchText, String suggestion) async {
    lastSearchText = LastSearchText(suggestion).updatedSearchText;

    List<String> parts = suggestion.split(RegExp(r'\s+'));

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
        lastSearchText['today'] =
            '${lastSearchText['today'] ?? ''}\n${weatherToday.join('\n')}';
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
        lastSearchText['weekly'] =
            '${lastSearchText['weekly'] ?? ''}\n${weeklyWeather.join('\n')}';
      });
    } catch (e) {
      setState(() {});
    }

    try {
      final List<String> currentWeather = await WeatherByLocation(
              latitude: position!.latitude, longitude: position!.longitude)
          .fetchCurrentWeather();
      setState(() {
        lastSearchText['currently'] =
            '${lastSearchText['currently'] ?? ''}\n${currentWeather.join('\n')}';
      });
    } catch (e) {
      setState(() {
        lastSearchText['currently'] = e.toString();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _updateLastSearchTextByCurrentLocation();
  }

  _updateLastSearchTextByCurrentLocation() async {
    position = await DeterminePosition().determinePosition();
    final cityName = await getCityName(position!.latitude, position!.longitude);
    lastSearchText = LastSearchText(cityName).lastSearchText;

    print('\n\n\n\n\n\n\n');
    print('CITYNAME: $cityName');
    print('\n\n\n\n\n\n\n');

    try {
      final List<String> weatherToday = await WeatherByLocation(
              latitude: position!.latitude, longitude: position!.longitude)
          .fetchTodayWeather();
      setState(() {
        lastSearchText['today'] =
            '${lastSearchText['today'] ?? ''}\n${weatherToday.join('\n')}';
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
        lastSearchText['weekly'] =
            '${lastSearchText['weekly'] ?? ''}\n${weeklyWeather.join('\n')}';
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
        lastSearchText['currently'] =
            '${lastSearchText['currently'] ?? ''}\n${currentWeather.join('\n')}';
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
        updatePosition: _updateLastSearchTextByCurrentLocation,
        updateLastSearchText: _updateLastSearchTextByCityName,
      ).tabController;
}
