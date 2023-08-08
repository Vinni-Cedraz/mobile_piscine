// ignore_for_file: file_names, avoid_print

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
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
  List<dynamic> suggestions = []; // Store the suggestions from API

  Future <void> _fetchSuggestions(String query) async {
    if (query.length >= 3) {
      final apiUrl = Uri.parse(
          'https://geocoding-api.open-meteo.com/v1/search?name=$query');

      final response = await http.get(apiUrl);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> results = data['results'];

        setState(() {
          suggestions = results
              .map((result) => {
                    'name': result['name'],
                    'admin1': result['admin1'],
                    'country': result['country'],
                  })
              .toList();
        });
      }
    } else {
      setState(() {
        suggestions = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: TextField(
            onChanged: _fetchSuggestions, // Call the function on text change
            decoration: const InputDecoration(
              hintText: 'Search...',
              icon: Icon(Icons.search),
            ),
          ),
        ),
        Expanded(
          child: IconButton(
            onPressed: widget.updatePosition,
            icon: const Icon(Icons.location_on),
          ),
        ),
        DropdownButton<Map<String, dynamic>>(
          items: suggestions
              .map((suggestion) => DropdownMenuItem<Map<String, dynamic>>(
                    value: suggestion,
                    child: Text(suggestion['name']),
                  ))
              .toList(),
          onChanged: (selectedSuggestion) {
            // Handle selected suggestion
            if (selectedSuggestion != null) {
              final selectedName = selectedSuggestion['name'];
              final selectedAdmin1 = selectedSuggestion['admin1'];
              final selectedCountry = selectedSuggestion['country'];

              // Update the text field with the selected suggestion
              widget.updateLastSearchText(
                  '$selectedName $selectedAdmin1 $selectedCountry');

              // You can also do something with selectedAdmin1 and selectedCountry
            }
          },
        ),
      ],
    );
  }
}
