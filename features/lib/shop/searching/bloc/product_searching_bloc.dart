import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'product_searching_event.dart';
part 'product_searching_state.dart';

class ProductSearchingBloc extends Bloc<ProductSearchingEvent, ProductSearchingState> {
  ProductSearchingBloc() : super(ProductSearchingInitial()) {
    on<ProductSearchingEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
