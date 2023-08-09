// ignore_for_file: file_names

import 'package:http/http.dart' as http;
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter/material.dart';
import 'dart:convert'; // Import for json decoding

class AutosuggestionsFromGeocodingApi {
  final Function(String) updateLastSearchText;
  final double fontSize;

  const AutosuggestionsFromGeocodingApi({
    required this.updateLastSearchText,
    required this.fontSize,
  });

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
      suggestionsCallback: _fetchSuggestions,
      itemBuilder: (context, suggestion) {
        return Card(
          child: Container(
            padding: const EdgeInsets.all(25),
            child: Text(suggestion.toString(),
                style: TextStyle(fontSize: fontSize * 0.75)),
          ),
        );
      },
      onSuggestionSelected: (suggestion) {
        updateLastSearchText(suggestion);
      },
    );
  }
}

Future<Iterable<dynamic>> _fetchSuggestions(String query) async {
  if (query.length >= 3) {
    final apiUrl =
        Uri.parse('https://geocoding-api.open-meteo.com/v1/search?name=$query');

    final response = await http.get(apiUrl);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> results = data['results'];

      final suggestions = results
          .map((result) =>
              '${result['name']} ${result['admin1']} ${result['country']}')
          .toList();

      return suggestions;
    }
  }

  return []; // Return an empty list when there are no suggestions
}
