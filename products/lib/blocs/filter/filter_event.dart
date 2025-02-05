part of 'filter_bloc.dart';

abstract class FilterEvent {}

class ApplyFilter extends FilterEvent {
  final double minPrice;
  final double maxPrice;

  ApplyFilter({required this.minPrice, required this.maxPrice});
}

class ResetFilter extends FilterEvent {}