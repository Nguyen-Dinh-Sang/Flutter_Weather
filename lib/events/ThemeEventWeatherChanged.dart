import 'package:flutter/cupertino.dart';
import 'package:flutter_weather/events/BaseEvent.dart';
import 'package:flutter_weather/models/Weather.dart';

class ThemeEventWeatherChanged extends BaseEvent {
  final WeatherCondition weatherCondition;

  const ThemeEventWeatherChanged({@required this.weatherCondition})
      : assert(weatherCondition != null);

  @override
  List<Object> get props => [weatherCondition];
}
