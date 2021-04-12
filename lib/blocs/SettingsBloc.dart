import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather/events/BaseEvent.dart';
import 'package:flutter_weather/events/SettingsEvent.dart';
import 'package:flutter_weather/states/BaseState.dart';
import 'package:flutter_weather/states/SettingsState.dart';

// basestate sai sai -> SettingState
class SettingsBloc extends Bloc<BaseEvent, BaseState> {
  // satate ban đầu
  SettingsBloc(): super(SettingsState(temperatureUnit: TemperatureUnit.celsius));

  // async* giúp trả về nhiều giá trị cho một lần gọi tùy từng thời điểm
  @override
  Stream<BaseState> mapEventToState(BaseEvent settingsEvent) async*{
    if (settingsEvent is SettingsEventToggleUnit) {
      yield SettingsState(temperatureUnit: (state as SettingsState).temperatureUnit == TemperatureUnit.celsius ? TemperatureUnit.fahrenheit : TemperatureUnit.celsius);
    }
  }
}