import 'package:flutter/cupertino.dart';
import 'package:flutter_weather/states/BaseState.dart';

class ThemeState extends BaseState {
  final Color backgroundColor;
  final Color textColor;

  const ThemeState({@required this.backgroundColor, @required this.textColor})
      : assert(backgroundColor != null),
        assert(textColor != null);

  @override
  List<Object> get props => [backgroundColor, textColor];
}
