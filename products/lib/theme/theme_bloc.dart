import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Events
abstract class ThemeEvent {}
class ToggleTheme extends ThemeEvent {}

// Bloc
class ThemeBloc extends Bloc<ThemeEvent, ThemeMode> {
  ThemeBloc() : super(ThemeMode.system);

  @override
  Stream<ThemeMode> mapEventToState(ThemeEvent event) async* {
    if (event is ToggleTheme) {
      yield state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    }
  }
}
