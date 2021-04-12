import 'package:flutter/cupertino.dart';
import 'package:flutter_weather/models/Weather.dart';
import 'package:flutter_weather/states/BaseState.dart';

class WeatherStateInitial extends BaseState {}
class WeatherStateLoading extends BaseState {}
class WeatherStateSuccess extends BaseState {
  final Weather weather;
  const WeatherStateSuccess({@required this.weather}): assert(weather != null);

  @override
  List<Object> get props => [weather];
}

class WeatherStateFailure extends BaseState {}
