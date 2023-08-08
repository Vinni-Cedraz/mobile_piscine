// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  test('Fetch suggestions from API', () async {
    final apiUrl = Uri.parse(
      'https://geocoding-api.open-meteo.com/v1/search?name=Par',
    );

    final response = await http.get(apiUrl);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> results = data['results'];

      // Verify that the response contains the 'Paris' suggestion
      expect(
        results.any((result) => result['name'] == 'Paris'),
        true,
      );
    } else {
      // Handle API error if needed
      fail('API request failed');
    }
    // Verify that the response container the
  });
}
