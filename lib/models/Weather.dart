import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final WeatherCondition weatherCondition;
  final String formattedCondition;
  final double minTemp;
  final double temp;
  final double maxTemp;
  final int locationId;
  final String creatd;
  final DateTime lasUpdated;
  final String location;
}

enum WeatherCondition{
  snow,
  sleet,
  hail,
  thunderstorm,
  heavyRain,
  lightRain,
  showers,
  heavyCloud,
  lightCloud,
  clear,
  unknown,
}

/*{
         "id":4954766934278144,
         "weather_state_name":"Light Cloud",
         "weather_state_abbr":"lc",
         "wind_direction_compass":"S",
         "created":"2021-03-31T00:31:02.909127Z",
         "applicable_date":"2021-03-31",
         "min_temp":9.83,
         "max_temp":21.875,
         "the_temp":22.255,
         "wind_speed":3.966200349661974,
         "wind_direction":171.7784099653297,
         "air_pressure":1024.0,
         "humidity":50,
         "visibility":8.408084287759484,
         "predictability":70
      }*/