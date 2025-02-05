import 'package:flutter_bloc/flutter_bloc.dart';
import '../product/product_bloc.dart';

part 'filter_event.dart';
part 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  final ProductBloc productBloc;

  FilterBloc({required this.productBloc}) : super(FilterInitial()) {
    on<ApplyFilter>(_onApplyFilter);
    on<ResetFilter>(_onResetFilter);
  }

  void _onApplyFilter(ApplyFilter event, Emitter<FilterState> emit) {
  emit(FilterApplied(minPrice: event.minPrice, maxPrice: event.maxPrice));

  productBloc.add(
    ApplyPriceFilter(minPrice: event.minPrice, maxPrice: event.maxPrice),
  );
}

  void _onResetFilter(ResetFilter event, Emitter<FilterState> emit) {
    emit(FilterReset());
    productBloc.add(FetchProducts());
  }
}
