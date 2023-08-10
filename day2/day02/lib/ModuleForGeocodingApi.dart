// ignore_for_file: file_names

import 'package:http/http.dart' as http;
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter/material.dart';
import 'dart:convert'; // Import for json decoding

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

class AutosuggestionsFromGeocodingApi {
  final Function(Map<String, String>) updateLastSearchText;
  final double fontSize;

  const AutosuggestionsFromGeocodingApi({
    required this.updateLastSearchText,
    required this.fontSize,
  });

  void onSuggestionSelected(String suggestion) {
    Map<String, String> updatedSearchText =
        LastSearchText(suggestion).updatedSearchText;
    updateLastSearchText(updatedSearchText);
  }

  searchField(double fontSize) {
    return TypeAheadField(
      textFieldConfiguration: TextFieldConfiguration(
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
