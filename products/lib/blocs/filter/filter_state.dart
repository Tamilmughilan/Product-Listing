part of 'filter_bloc.dart';

abstract class FilterState {}

class FilterInitial extends FilterState {}

class FilterApplied extends FilterState {
  final double minPrice;
  final double maxPrice;

  FilterApplied({required this.minPrice, required this.maxPrice});
}

class FilterReset extends FilterState {}