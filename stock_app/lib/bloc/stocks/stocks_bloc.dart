import 'package:flutter_bloc/flutter_bloc.dart';
import "package:stock_app/models/stocks_model.dart";
import "package:stock_app/bloc/stocks/stocks_event.dart";
import "package:stock_app/bloc/stocks/stocks_state.dart";
import "package:stock_app/repository/stocks/stocks_repository.dart";

class StocksBloc extends Bloc<StocksEvent, StocksState> {
  final StocksRepository stocksRepository;
  final String authToken;

  StocksBloc({required this.stocksRepository, required this.authToken}) : super(StocksInitial()) {
    on<FetchStocks>((event, emit) async {
      emit(StocksLoading());
      try {
        final StocksModel stocks = await stocksRepository.fetchStocks(authToken);
        emit(StocksLoaded(stocks));
      } catch (e) {
        if (state is StocksError) {
          final retryCount = (state as StocksError).retryCount;
          emit(StocksError(e.toString(), retryCount: retryCount + 1));
        } else {
          emit(StocksError(e.toString()));
        }
      }
    });
  }
}
