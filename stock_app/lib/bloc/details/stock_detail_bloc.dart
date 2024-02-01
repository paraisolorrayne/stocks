import 'package:flutter_bloc/flutter_bloc.dart';
import "package:stock_app/bloc/details/stock_detail_event.dart";
import "package:stock_app/bloc/details/stock_detail_state.dart";
import "package:stock_app/repository/stocks/stock_detail_repository.dart";

class StockDetailBloc extends Bloc<StockDetailEvent, StockDetailState> {
  final String authToken;
  final StockDetailRepository stockDetailRepository;

  StockDetailBloc({required this.authToken, required this.stockDetailRepository}) : super(StockDetailInitial()) {
    on<FetchStockDetail>(_onFetchStockDetail);
  }

  Future<void> _onFetchStockDetail(FetchStockDetail event, Emitter<StockDetailState> emit) async {
    try {
      emit(StockDetailLoading());
      final stockDetail = await stockDetailRepository.getStockDetail(authToken, event.symbol);
      emit(StockDetailLoaded(stockDetail));
    } catch (error) {
      emit(StockDetailError(error.toString()));
    }
  }
}
