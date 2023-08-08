// ignore_for_file: file_names

import 'package:flutter/material.dart';

class TabContent extends StatelessWidget {
  final String title;
  const TabContent({super.key, required this.title});
  @override
  Widget build(BuildContext context) => Center(
        child: Text(title),
      );
}
