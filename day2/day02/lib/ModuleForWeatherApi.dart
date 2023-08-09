// ignore_for_file: file_names

import 'package:http/http.dart' as http;
import 'dart:convert'; // Import for json decoding

class WeatherByLocation {
  final double latitude;
  final double longitude;

  const WeatherByLocation({
    required this.latitude,
    required this.longitude,
  });

  fetchTodayWeather() async {
    final apiUrl = Uri.parse(
        'https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&hourly=temperature_2m,windspeed_10m&current_weather=true');
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

      return weatherToday;
    }
    return []; // Return an empty list when there are no weatherToday
  }
}
