import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather/blocs/SettingsBloc.dart';
import 'package:flutter_weather/blocs/ThemeBloc.dart';
import 'package:flutter_weather/blocs/WeatherBloc.dart';
import 'package:flutter_weather/blocs/WeatherBlocObserver.dart';
import 'package:flutter_weather/repositories/WeatherRepository.dart';
import 'package:flutter_weather/screens/WeatherScreen.dart';
import 'package:http/http.dart' as http;

void main() {
  Bloc.observer = WeatherBlocObserver();

  final WeatherRepository weatherRepository = WeatherRepository(
    httpClient: http.Client(),
  );

  // trường hợp nhiều bloc
  // runApp(MyApp(weatherRepository: weatherRepository,));
  runApp(MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(
          create: (context) => ThemeBloc(),
        ),
        BlocProvider<SettingsBloc>(
          create: (context) => SettingsBloc(),
        ),
        BlocProvider<WeatherBloc>(
            create: (context) =>
                WeatherBloc(weatherRepository: weatherRepository)),
      ],
      child: MyApp(
        weatherRepository: weatherRepository,
      )));
}

class MyApp extends StatelessWidget {
  final WeatherRepository weatherRepository;

  MyApp({Key key, @required this.weatherRepository})
      : assert(weatherRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Weather',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WeatherScreen(),
    );
  }
}
