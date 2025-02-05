import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/product/product_bloc.dart';
import '../blocs/filter/filter_bloc.dart';
import '../widgets/product_card.dart';
import '../widgets/search_bar.dart' as custom;
import '../widgets/filter_bottom_sheet.dart';
import '../widgets/skeleton_loading.dart';
import 'product_detail_screen.dart';
import '../models/product.dart';
import '../repositories/product_repository.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Listing'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return BlocProvider.value(
                    value: context.read<FilterBloc>(),
                    child: const FilterBottomSheet(),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                ProductBloc(productRepository: ProductRepository())
                  ..add(FetchProducts()),
          ),
          BlocProvider(
            create: (context) => FilterBloc(
              productBloc: context.read<ProductBloc>(),
            ),
          ),
        ],
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, productState) {
            if (productState is ProductLoading) {
              return const SkeletonLoading();
            } else if (productState is ProductError) {
              return Center(child: Text(productState.message));
            } else if (productState is ProductLoaded) {
              return Column(
                children: [
                  custom.SearchBar(
                    onSearch: (query) {
                      context.read<ProductBloc>().add(SearchProducts(query));
                    },
                  ),
                  Expanded(
                    child: BlocBuilder<FilterBloc, FilterState>(
                      builder: (context, filterState) {
                        List<Product> displayedProducts = productState.products;

                        // Apply search query filter
                        if (productState.searchQuery.isNotEmpty) {
                          displayedProducts = displayedProducts
                              .where((product) => product.name
                                  .toLowerCase()
                                  .contains(productState.searchQuery.toLowerCase()))
                              .toList();
                        }

                        // Apply price filter if FilterApplied state is active
                        if (filterState is FilterApplied) {
                          displayedProducts = displayedProducts
                              .where((product) =>
                                  product.price >= filterState.minPrice &&
                                  product.price <= filterState.maxPrice)
                              .toList();
                        }

                        return GridView.builder(
                          padding: const EdgeInsets.all(8),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.75,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                          itemCount: displayedProducts.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductDetailScreen(
                                        product: displayedProducts[index]),
                                  ),
                                );
                              },
                              child: ProductCard(
                                  product: displayedProducts[index]),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
            }
            return const Center(child: Text('No products found'));
          },
        ),
      ),
    );
  }
}