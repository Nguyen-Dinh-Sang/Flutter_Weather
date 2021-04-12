import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather/blocs/ThemeBloc.dart';
import 'package:flutter_weather/blocs/WeatherBloc.dart';
import 'package:flutter_weather/events/ThemeEventWeatherChanged.dart';
import 'package:flutter_weather/events/WeatherEvent.dart';
import 'package:flutter_weather/screens/SearchScreen.dart';
import 'package:flutter_weather/screens/SettingsScreen.dart';
import 'package:flutter_weather/screens/TemperatureWidget.dart';
import 'package:flutter_weather/states/BaseState.dart';
import 'package:flutter_weather/states/ThemeState.dart';
import 'package:flutter_weather/states/WeatherState.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Completer<void> _completer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _completer = Completer<void>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
        actions: [
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingsScreen()));
              }),
          IconButton(icon: Icon(Icons.search), onPressed: () async {
            final typedCity = await Navigator.push(context,
                MaterialPageRoute(builder: (context) => CitySearchScreen()));
            if (typedCity != null) {
              BlocProvider.of<WeatherBloc>(context).add(WeatherEventRequested(city: typedCity));
            }
          }),
        ],
      ),
      body: Center(
        child: BlocConsumer<WeatherBloc, BaseState>(
          listener: (context, baseState) {
            if (baseState is WeatherStateSuccess) {
              BlocProvider.of<ThemeBloc>(context).add(
                ThemeEventWeatherChanged(
                    weatherCondition: baseState.weather.weatherCondition),
              );
              _completer?.complete();
              _completer = Completer();
            }
          },
          builder: (context, baseState) {
            if (baseState is WeatherStateLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (baseState is WeatherStateSuccess) {
              final weather = baseState.weather;
              return BlocBuilder<ThemeBloc, BaseState>(
                builder: (context, themeState) {
                  return RefreshIndicator(
                    onRefresh: () {
                      BlocProvider.of<WeatherBloc>(context).add(
                        WeatherEventRefresh(city: weather.location),
                      );
                      return _completer.future;
                    },
                    child: Container(
                      color: (themeState as ThemeState).backgroundColor,
                      child: ListView(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text(
                                weather.location,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: (themeState as ThemeState).textColor,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 2,
                                ),
                              ),
                              Center(
                                child: Text(
                                  'Updated: ${TimeOfDay.fromDateTime(weather.lasUpdated).format(context)}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: (themeState as ThemeState).textColor,
                                  ),
                                ),
                              ),
                              TemperatureWidget(
                                weather: weather,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            if (baseState is WeatherStateFailure) {
              return Text(
                'Something went wrong',
                style: TextStyle(color: Colors.red, fontSize: 16),
              );
            }
            return Center(
              child: Text(
                'Select a location first',
                style: TextStyle(fontSize: 30),
              ),
            );
          },
        ),
      ),
    );
  }
}
