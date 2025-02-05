part of 'product_bloc.dart';

abstract class ProductEvent {}

class FetchProducts extends ProductEvent {}

class SearchProducts extends ProductEvent {
  final String query;

  SearchProducts(this.query);
}

class ApplyPriceFilter extends ProductEvent {
  final double minPrice;
  final double maxPrice;

  ApplyPriceFilter({required this.minPrice, required this.maxPrice});
}
