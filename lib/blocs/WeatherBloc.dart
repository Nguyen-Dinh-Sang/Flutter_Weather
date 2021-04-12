import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather/events/BaseEvent.dart';
import 'package:flutter_weather/events/WeatherEvent.dart';
import 'package:flutter_weather/models/Weather.dart';
import 'package:flutter_weather/repositories/WeatherRepository.dart';
import 'package:flutter_weather/states/BaseState.dart';
import 'package:flutter_weather/states/WeatherState.dart';

class WeatherBloc extends Bloc<BaseEvent, BaseState> {
  final WeatherRepository weatherRepository;

  WeatherBloc({@required this.weatherRepository})
      : assert(weatherRepository != null),
        //khởi tạo state ban đầu
        super(WeatherStateInitial());

  @override
  Stream<BaseState> mapEventToState(BaseEvent watherEvent) async* {
    // switch(watherEvent) {
    //   case
    // }
    if (watherEvent is WeatherEventRequested) {
      // trả về dữ liệu giống return
      yield WeatherStateLoading();
      try {
        final Weather weather =
            await weatherRepository.getWeatherFromCity(watherEvent.city);
        yield WeatherStateSuccess(weather: weather);
      } catch (exception) {
        yield WeatherStateFailure();
      }
    } else if (watherEvent is WeatherEventRefresh) {
      // trả về dữ liệu giống return
      yield WeatherStateLoading();
      try {
        final Weather weather =
            await weatherRepository.getWeatherFromCity(watherEvent.city);
        yield WeatherStateSuccess(weather: weather);
      } catch (exception) {
        yield WeatherStateFailure();
      }
    }
  }
}
