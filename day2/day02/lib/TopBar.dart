// ignore_for_file: file_names, avoid_print

import 'package:flutter/material.dart';
import 'ModuleForGeocodingApi.dart';

class TopBar {
  final Function(Map<String, String>, String suggestion) updateLastSearchText;
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
  final Function(Map<String, String>, String suggestion) updateLastSearchText;
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

  @override
  Widget build(BuildContext context) {
    double screenSize =
        MediaQuery.of(context).size.height * MediaQuery.of(context).size.width;
    double fontSize = screenSize * 0.000035;
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: AutosuggestionsFromGeocodingApi(
                  updateLastSearchText: widget.updateLastSearchText,
                  fontSize: fontSize)
              .searchField(fontSize),
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
