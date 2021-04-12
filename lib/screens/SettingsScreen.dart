import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather/blocs/SettingsBloc.dart';
import 'package:flutter_weather/events/SettingsEvent.dart';
import 'package:flutter_weather/states/BaseState.dart';
import 'package:flutter_weather/states/SettingsState.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: <Widget>[
          BlocBuilder<SettingsBloc, BaseState>(
            builder: (context, baseState) {
              return ListTile(
                title: Text('Temperature Unit'),
                isThreeLine: true,
                subtitle: Text((baseState as SettingsState).temperatureUnit ==
                        TemperatureUnit.celsius
                    ? 'Celsius'
                    : 'Fahrenheit'),
                trailing: Switch(
                  value: (baseState as SettingsState).temperatureUnit ==
                      TemperatureUnit.celsius,
                  onChanged: (_) => BlocProvider.of<SettingsBloc>(context)
                      .add(SettingsEventToggleUnit()),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
