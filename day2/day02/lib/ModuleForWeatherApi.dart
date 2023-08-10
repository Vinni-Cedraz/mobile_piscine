// ignore_for_file: file_names

import 'package:http/http.dart' as http;
import 'dart:convert'; // Import for json decoding
import 'WeatherCodeInterpretation.dart';

class WeatherByLocation {
  final double latitude;
  final double longitude;

  const WeatherByLocation({
    required this.latitude,
    required this.longitude,
  });

  fetchTodayWeather() async {
    final apiUrl = Uri.parse(
        'https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&hourly=temperature_2m,windspeed_10m&current_weather=true&forecast_days=1');
    final response = await http.get(apiUrl);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final hourly = data['hourly'];

      final List<String> weatherToday =
          List.generate(hourly['time'].length, (index) {
        final rawTime = hourly['time'][index];
        final formattedTime = rawTime.substring(rawTime.indexOf('T') + 1);
        return '$formattedTime\t\t\t\t\t\t\t\t${hourly['temperature_2m'][index]}°C\t\t\t\t\t\t\t\t${hourly['windspeed_10m'][index]}km/h';
      });

      return weatherToday;
    }
    return []; // Return an empty list when there are no weatherToday
  }

  fetchWeekWeather() async {
    final apiUrl = Uri.parse(
        'https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&hourly=temperature_2m&daily=weathercode,temperature_2m_max,temperature_2m_min,windspeed_10m_max&current_weather=true&timezone=auto');
    final response = await http.get(apiUrl);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final daily = data['daily'];

      final List<String> weatherToday =
          List.generate(daily['time'].length, (index) {
        final rawTime = daily['time'][index];
        final formattedDay = rawTime.substring(rawTime.indexOf('-') + 1);
        final String weatherDescription =
            WeatherCodeInterpretation(daily['weathercode'][index]).getter();
        return '$formattedDay\t\t\t\t\t\t\t${daily['temperature_2m_min'][index]}°C\t\t\t\t\t\t\t${daily['temperature_2m_max'][index]}°C\t\t\t\t\t\t$weatherDescription';
      });

      return weatherToday;
    }
    return []; // Return an empty list when there are no weatherToday
  }

  fetchCurrentWeather() async {
    final apiUrl = Uri.parse(
        'https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&current_weather=true&timezone=auto');
    final response = await http.get(apiUrl);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final current = data['current_weather'];

        return ['${current['temperature']}°C\n${current['windspeed']} km/h'];
    }
    return []; // Return an empty list when there are no weatherToday
  }
}
