// ignore_for_file: file_names, avoid_print

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'dart:convert'; // Import for json decoding

class TopBar {
  final Function(String) updateLastSearchText;
  final Function() updatePosition;
  const TopBar({
    required this.updateLastSearchText,
    required this.updatePosition,
  });
  AppBar buildAppBar() => AppBar(
          title: TopRowWidgets(
        updateLastSearchText: updateLastSearchText,
        updatePosition: updatePosition,
      ));
}

class TopRowWidgets extends StatefulWidget {
  final Function(String) updateLastSearchText;
  final Function() updatePosition;

  const TopRowWidgets({
    super.key,
    required this.updateLastSearchText,
    required this.updatePosition,
  });

  @override
  TopRowWidgetsState createState() => TopRowWidgetsState();
}

class TopRowWidgetsState extends State<TopRowWidgets> {
  List<Map<String, dynamic>> suggestions = []; // Store the suggestions from API
  late Map<String, dynamic> selectedSuggestion; // Store the selected suggestion

  Future<Iterable<dynamic>> _fetchSuggestions(String query) async {
    if (query.length >= 3) {
      final apiUrl = Uri.parse(
          'https://geocoding-api.open-meteo.com/v1/search?name=$query');

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

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: TypeAheadField(
            textFieldConfiguration: const TextFieldConfiguration(
              autofocus: true,
              style: TextStyle(fontSize: 10),
              decoration: InputDecoration(
								border: OutlineInputBorder(),
								// contentPadding: EdgeInsets.symmetric(vertical: 2),
								),
            ),
            suggestionsCallback: _fetchSuggestions,
            itemBuilder: (context, suggestion) {
              return Card(
                child: Container(
                  padding: const EdgeInsets.all(25),
                  child: Text(suggestion.toString(),
                      style: const TextStyle(fontSize: 12)),
                ),
              );
            },
            onSuggestionSelected: (suggestion) {
              widget.updateLastSearchText(suggestion);
            },
          ),
        ),
        Expanded(
          child: IconButton(
            onPressed: widget.updatePosition,
            icon: const Icon(Icons.location_on),
          ),
        )
      ],
    );
  }
}
