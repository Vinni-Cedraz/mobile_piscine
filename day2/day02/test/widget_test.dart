// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

// ignore_for_file: avoid_print, unused_local_variable

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
      List<dynamic> results = data['results'];

      List<dynamic> suggestions;
      suggestions = results
          .map((result) => {
                'name': result['name'] ?? 'nil',
                'admin1': result['admin1'] ?? 'nil',
                'country': result['country'] ?? 'nil',
              })
          .toList();
      // Print
      // print(data);

      // print(suggestions);
      // Verify that the response contains the 'Paris' suggestion
      expect(
        results.any((result) => result['name'] == 'Paris'),
        true,
      );
      // Verify that the response contains the 'Paris' suggestion
      expect(
        results[0]['name'] == 'Paris',
        true,
      );
      expect(
        results[1]['name'] == 'Par',
        true,
      );
    }
  });

  test('getTodayWeather', () async {
    final apiUrl = Uri.parse(
        'https://api.open-meteo.com/v1/forecast?latitude=52&longitude=14&hourly=temperature_2m,windspeed_10m&current_weather=true');
    final response = await http.get(apiUrl);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final hourly = data['hourly'];

      final List<String> weatherToday =
          List.generate(hourly['time'].length, (index) {
        final rawTime = hourly['time'][index];
        final formattedTime = rawTime.substring(rawTime.indexOf('T') + 1);
        return '$formattedTime\t\t${hourly['temperature_2m'][index]}°C\t\t${hourly['windspeed_10m'][index]}km/h\n';
      });

      print(weatherToday);
      return weatherToday;
    }
    return []; // Return an empty list when there are no weatherToday
  });
}
