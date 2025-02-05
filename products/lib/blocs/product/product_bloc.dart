import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_listing_app/repositories/product_repository.dart';
import 'package:product_listing_app/models/product.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;
  List<Product> _allProducts = []; 

  ProductBloc({required this.productRepository}) : super(ProductInitial()) {
    on<FetchProducts>(_onFetchProducts);
    on<SearchProducts>(_onSearchProducts);
    on<ApplyPriceFilter>(_onApplyPriceFilter); 
  }

  Future<void> _onFetchProducts(
      FetchProducts event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      _allProducts = await productRepository.fetchProducts();
      print("Fetched Products: ${_allProducts.map((p) => p.price).toList()}");
      emit(ProductLoaded(products: _allProducts));
    } catch (e) {
      emit(ProductError('Failed to load products'));
    }
  }

  void _onSearchProducts(SearchProducts event, Emitter<ProductState> emit) {
    if (state is ProductLoaded) {
      final currentState = state as ProductLoaded;
      List<Product> filteredProducts = _allProducts;

      if (event.query.isNotEmpty) {
        filteredProducts = filteredProducts
            .where((product) =>
                product.name.toLowerCase().contains(event.query.toLowerCase()))
            .toList();
      }

      emit(ProductLoaded(
        products: filteredProducts,
        searchQuery: event.query,
      ));
    }
  }

  void _onApplyPriceFilter(ApplyPriceFilter event, Emitter<ProductState> emit) {
    if (state is ProductLoaded) {
      final currentState = state as ProductLoaded;
      List<Product> filteredProducts = _allProducts.where((product) {
        return product.price >= event.minPrice &&
            product.price <= event.maxPrice;
      }).toList();

      print(
          "Filtered Products: ${filteredProducts.map((p) => p.price).toList()}");

      emit(ProductLoaded(
        products: filteredProducts,
        searchQuery: currentState.searchQuery,
      ));
    }
  }
}
