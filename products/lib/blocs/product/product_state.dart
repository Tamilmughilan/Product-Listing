part of 'product_bloc.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;
  final String searchQuery;

  ProductLoaded({required this.products, this.searchQuery = ''});
}

class ProductError extends ProductState {
  final String message;

  ProductError(this.message);
}
