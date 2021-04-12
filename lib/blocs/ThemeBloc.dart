import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather/events/BaseEvent.dart';
import 'package:flutter_weather/events/ThemeEventWeatherChanged.dart';
import 'package:flutter_weather/models/Weather.dart';
import 'package:flutter_weather/states/BaseState.dart';
import 'package:flutter_weather/states/ThemeState.dart';

class ThemeBloc extends Bloc<BaseEvent, BaseState> {
  ThemeBloc()
      : super(ThemeState(
            backgroundColor: Colors.lightBlue, textColor: Colors.white));

  //async cung cấp một Future
  //async* cung cấp một Stream
  @override
  Stream<BaseState> mapEventToState(BaseEvent themeEvent) async* {
    BaseState newThemeState;
    if (themeEvent is ThemeEventWeatherChanged) {
      final weatherCondition = themeEvent.weatherCondition;
      if (weatherCondition == WeatherCondition.clear ||
          weatherCondition == WeatherCondition.lightCloud) {
        newThemeState =
            ThemeState(backgroundColor: Colors.yellow, textColor: Colors.black);
      } else if (weatherCondition == WeatherCondition.hail ||
          weatherCondition == WeatherCondition.snow ||
          weatherCondition == WeatherCondition.sleet) {
        newThemeState = ThemeState(
            backgroundColor: Colors.lightBlue, textColor: Colors.white);
      } else if (weatherCondition == WeatherCondition.heavyCloud ||
          weatherCondition == WeatherCondition.lightRain ||
          weatherCondition == WeatherCondition.showers) {
        newThemeState =
            ThemeState(backgroundColor: Colors.indigo, textColor: Colors.white);
      } else if (weatherCondition == WeatherCondition.thunderstorm) {
        newThemeState =
            ThemeState(backgroundColor: Colors.purple, textColor: Colors.white);
      } else if (weatherCondition == WeatherCondition.heavyRain) {
        newThemeState =
            ThemeState(backgroundColor: Colors.pink, textColor: Colors.white);
      } else if (weatherCondition == WeatherCondition.unknown) {
        newThemeState =
            ThemeState(backgroundColor: Colors.green, textColor: Colors.white);
      }

      yield newThemeState;
    }
  }
}
