import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather/blocs/SettingsBloc.dart';
import 'package:flutter_weather/blocs/ThemeBloc.dart';
import 'package:flutter_weather/models/Weather.dart';
import 'package:flutter_weather/states/BaseState.dart';
import 'package:flutter_weather/states/SettingsState.dart';
import 'package:flutter_weather/states/ThemeState.dart';
import 'package:weather_icons/weather_icons.dart';

class TemperatureWidget extends StatelessWidget {
  final Weather weather;

  TemperatureWidget({Key key, this.weather}) : super(key: key);

  // chuyển độ c -> độ f
  int _toFahrenheit(double celsius) => ((celsius * 9 / 5) + 32).round();

  String _formattedTemperatur(double temp, TemperatureUnit temperatureUnit) =>
      temperatureUnit == TemperatureUnit.fahrenheit
          ? '${_toFahrenheit(temp)}°F'
          : '${temp.round()}°C';

  // tạo icon
  BoxedIcon _mapWeatherConditionToIcon(WeatherCondition weatherCondition) {
    switch (weatherCondition) {
      case WeatherCondition.clear:
      case WeatherCondition.lightCloud:
        {
          return BoxedIcon(WeatherIcons.day_sunny);
        }
      case WeatherCondition.heavyCloud:
        {
          return BoxedIcon(WeatherIcons.cloud_up);
        }
      case WeatherCondition.heavyRain:
      case WeatherCondition.lightRain:
      case WeatherCondition.showers:
        {
          return BoxedIcon(WeatherIcons.rain);
        }
      case WeatherCondition.thunderstorm:
        {
          return BoxedIcon(WeatherIcons.thunderstorm);
        }
      case WeatherCondition.unknown:
        {
          return BoxedIcon(WeatherIcons.sunset);
        }
    }
    return BoxedIcon(WeatherIcons.sunset);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _mapWeatherConditionToIcon(weather.weatherCondition),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
              child: BlocBuilder<SettingsBloc, BaseState>(
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        'Min temp: ${_formattedTemperatur(weather.minTemp, (state as SettingsState).temperatureUnit)}',
                        style: TextStyle(
                            fontSize: 18,
                            color: (BlocProvider.of<ThemeBloc>(context).state
                                    as ThemeState)
                                .textColor),
                      ),
                      Text(
                        'Temp: ${_formattedTemperatur(weather.temp, (state as SettingsState).temperatureUnit)}',
                        style: TextStyle(
                            fontSize: 18,
                            color: (BlocProvider.of<ThemeBloc>(context).state
                                    as ThemeState)
                                .textColor),
                      ),
                      Text(
                        'Max temp: ${_formattedTemperatur(weather.maxTemp, (state as SettingsState).temperatureUnit)}',
                        style: TextStyle(
                            fontSize: 18,
                            color: (BlocProvider.of<ThemeBloc>(context).state
                                    as ThemeState)
                                .textColor),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        )
      ],
    );
  }
}
