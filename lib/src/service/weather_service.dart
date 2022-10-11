import 'dart:convert';

import 'package:http/http.dart';
import 'package:weather_x/src/models/weather.dart';

class WeatherService {
  WeatherService({required this.client});
  final Client client;

  Future<Weather> getWeatherWithCoordinates(
      {required String lat,
      required String long,
      required String appID}) async {
    final response = await client.get(
      Uri.parse(
        "https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$long&appid=$appID&units=metrics",
      ),
    );

    final decodedResponse = jsonDecode(response.body);

    return Weather.fromJson(decodedResponse);
  }

  Future<Weather> getWeather({required String cityName}) async {
    final response = await client.get(
      Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=0f52c9ebddd45c23acfd79f9ea61d772&units=metric",
      ),
    );

    return Weather.fromJson(jsonDecode(response.body));
  }
}
