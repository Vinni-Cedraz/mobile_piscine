// ignore_for_file: file_names, avoid_print

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter/material.dart';
import 'dart:convert'; // Import for json decoding

class MyPosition {
  double latitude;
  double longitude;

  MyPosition({required this.latitude, required this.longitude});
}

class LastSearchText {
  final Map<String, String> lastSearchText = {
    'currently': '',
    'today': '',
    'weekly': '',
  };

  LastSearchText(String suggestion) {
    lastSearchText['currently'] = suggestion;
    lastSearchText['today'] = suggestion;
    lastSearchText['weekly'] = suggestion;
  }
  Map<String, String> get updatedSearchText => lastSearchText;
}

class DeterminePosition {
  final String? name;
  final String? admin1;
  final String? country;

  DeterminePosition({this.name, this.admin1, this.country});

  Future<MyPosition> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    dynamic position = await Geolocator.getCurrentPosition();
    MyPosition myPosition =
        MyPosition(latitude: position.latitude, longitude: position.longitude);

    if (name != null && admin1 != null && country != null) {
      final apiUrl = Uri.parse(
          'https://geocoding-api.open-meteo.com/v1/search?name=$name&count=10&language=en&format=json');

      final response = await http.get(apiUrl);

      final List<dynamic> results = json.decode(response.body)['results'];

      for (final result in results) {
        if (result['name'] == name &&
                result['admin1'] == admin1 &&
                result['country'] == country ||
            result['name'] == name && result['country'] == country) {
          final latitude = result['latitude'];
          final longitude = result['longitude'];
          myPosition = MyPosition(latitude: latitude, longitude: longitude);
          break;
        }
      }
      return myPosition; // Return the determined position here
    }
    return myPosition;
  }
}

class AutosuggestionsFromGeocodingApi {
  final Function(Map<String, String>, String suggestion) updateLastSearchText;
  final double fontSize;

  const AutosuggestionsFromGeocodingApi({
    required this.updateLastSearchText,
    required this.fontSize,
  });

  void onSuggestionSelected(String suggestion) {
    Map<String, String> updatedSearchText =
        LastSearchText(suggestion).updatedSearchText;
    updateLastSearchText(updatedSearchText, suggestion);
  }

  searchField(double fontSize) {
    return TypeAheadField(
      textFieldConfiguration: TextFieldConfiguration(
        onSubmitted: (String input) async {
          final suggestions = await _fetchSuggestions(input);
            onSuggestionSelected(suggestions.first);
        },
        autofocus: true,
        style: TextStyle(fontSize: fontSize),
        decoration: const InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(),
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        ),
      ),
      suggestionsCallback: (String input) async {
        final suggestions = await _fetchSuggestions(input);
        if (suggestions.length == 1) {
          onSuggestionSelected(suggestions.first);
        }
        return suggestions;
      },
      itemBuilder: (context, suggestion) {
        return Card(
          child: Container(
            padding: const EdgeInsets.all(25),
            child: Text(suggestion.toString(),
                style: TextStyle(fontSize: fontSize * 0.75)),
          ),
        );
      },
      onSuggestionSelected: onSuggestionSelected,
    );
  }
}

Future<Iterable<String>> _fetchSuggestions(String query) async {
  if (query.length < 3) return [];

  final apiUrl =
      Uri.parse('https://geocoding-api.open-meteo.com/v1/search?name=$query');

  try {
    final response = await http.get(apiUrl);

    if (response.statusCode == 200) {
      final List<dynamic> results = json.decode(response.body)['results'];
      return results.map((result) =>
          '${result['name']}\t${result['admin1'] ?? ''}\t${result['country']}');
    } else {
      return ['${LastSearchText('API error').updatedSearchText['today']}'];
    }
  } catch (e) {
    return [
      '${LastSearchText('Invalid City Name').updatedSearchText['today']}'
    ];
  }
}
