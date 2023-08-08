// ignore_for_file: file_names

import 'package:flutter/material.dart';

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

class TopRowWidgets extends StatelessWidget {
  final Function(String) updateLastSearchText;
  final Function() updatePosition;
  const TopRowWidgets({
    super.key,
    required this.updateLastSearchText,
    required this.updatePosition,
  });

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Expanded(
            flex: 2,
            child: TextField(
              onSubmitted: (text) => updateLastSearchText(text),
              decoration: const InputDecoration(
                hintText: 'Search...',
                icon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: IconButton(
              onPressed: () => updatePosition(),
              icon: const Icon(Icons.location_on),
            ),
          ),
        ],
      );
}
