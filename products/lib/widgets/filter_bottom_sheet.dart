import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/filter/filter_bloc.dart';

class FilterBottomSheet extends StatelessWidget {
  const FilterBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterBloc, FilterState>(
      builder: (context, state) {
        double currentMinPrice = 0;
        double currentMaxPrice = 1000;

        if (state is FilterApplied) {
          currentMinPrice = state.minPrice;
          currentMaxPrice = state.maxPrice;
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Filter by Price',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              RangeSlider(
                values: RangeValues(currentMinPrice, currentMaxPrice),
                min: 0,
                max: 1000,
                divisions: 10,
                labels: RangeLabels(
                  '\$${currentMinPrice.toStringAsFixed(2)}',
                  '\$${currentMaxPrice.toStringAsFixed(2)}',
                ),
                onChanged: (values) {
                  print("Selected Range: ${values.start} - ${values.end}");
                  currentMinPrice = values.start;
                  currentMaxPrice = values.end;
                },
                onChangeEnd: (values) {
                  print(
                      "Applying Filter with Range: ${values.start} - ${values.end}");
                  context.read<FilterBloc>().add(
                        ApplyFilter(
                          minPrice: values.start,
                          maxPrice: values.end,
                        ),
                      );
                },
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      context.read<FilterBloc>().add(ResetFilter());
                      Navigator.pop(context);
                    },
                    child: const Text('Reset'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.read<FilterBloc>().add(
                            ApplyFilter(
                              minPrice: currentMinPrice,
                              maxPrice: currentMaxPrice,
                            ),
                          );
                      Navigator.pop(context);
                    },
                    child: const Text('Apply'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
