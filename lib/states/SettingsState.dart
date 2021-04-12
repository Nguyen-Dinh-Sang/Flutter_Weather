import 'package:flutter/cupertino.dart';
import 'package:flutter_weather/states/BaseState.dart';

enum TemperatureUnit { fahrenheit, celsius }

class SettingsState extends BaseState {
  final TemperatureUnit temperatureUnit;

  const SettingsState({@required this.temperatureUnit})
      : assert(temperatureUnit != null);

  @override
  List<Object> get props => [temperatureUnit];
}
