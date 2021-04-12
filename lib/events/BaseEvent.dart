// Equatable giúp so sánh object nhanh hơn mà k cần override lại: bool operator và int hash code.
import 'package:equatable/equatable.dart';

abstract class BaseEvent extends Equatable {
  const BaseEvent();
}