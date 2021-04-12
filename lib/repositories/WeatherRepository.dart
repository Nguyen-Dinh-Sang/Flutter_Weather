import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_weather/models/Weather.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'https://www.metaweather.com';
final locationUrl = (city) => '${baseUrl}/api/location/search/?query=${city}';
final weatherUrl = (locationId) => '${baseUrl}/api/location/${locationId}';

class WeatherRepository {
  final http.Client httpClient;

  WeatherRepository({@required this.httpClient}) : assert(httpClient != null);

  Future<int> getLocationIdFormCity(String city) async {
    final response = await this.httpClient.get(Uri.parse(locationUrl(city)));
    if (response.statusCode == 200) {
      final cities = jsonDecode(response.body) as List;
      return (cities.first)['woeid'] ?? 0;
    } else {
      throw Exception('Error getting location id of: ${city}');
    }
  }

  Future<Weather> fetchWeather(int locationId) async {
    final response =
        await this.httpClient.get(Uri.parse(weatherUrl(locationId)));
    if (response.statusCode == 200) {
      final weatherJson = jsonDecode(response.body);
      return Weather.fromJson(weatherJson);
      // return Weather(
      //     weatherCondition: WeatherCondition.snow,
      //     formattedCondition: 'snow',
      //     minTemp: 10,
      //     temp: 12,
      //     maxTemp: 14,
      //     locationId: 123,
      //     created: '',
      //     lasUpdated: DateTime.now(),
      //     location: '');
    } else {
      throw Exception('Error getting weather from locationId: ${locationId}');
    }
  }

  Future<Weather> getWeatherFromCity(String city) async {
    final int locationId = await getLocationIdFormCity(city);
    return fetchWeather(locationId);
  }
}
