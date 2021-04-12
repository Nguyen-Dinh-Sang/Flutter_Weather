import 'package:flutter/cupertino.dart';
import 'package:flutter_weather/events/BaseEvent.dart';

class WeatherEventRequested extends BaseEvent {
  final String city;

  // Assert kiểm tra xem city khác null ms cho khởi tạo.
  const WeatherEventRequested({@required this.city}) : assert(city != null);

  // Chỉ ra các thuộc tính phân biệt giữa 2 đối tượng WeatherEventRequested;
  @override
  List<Object> get props => [city];
}

class WeatherEventRefresh extends BaseEvent {
  final String city;

  // Assert kiểm tra xem city khác null ms cho khởi tạo.
  const WeatherEventRefresh({@required this.city}) : assert(city != null);

  // Chỉ ra các thuộc tính phân biệt giữa 2 đối tượng WeatherEventRequested;
  @override
  List<Object> get props => [city];
}

