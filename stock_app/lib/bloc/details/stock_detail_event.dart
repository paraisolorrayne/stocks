import "package:equatable/equatable.dart";

abstract class StockDetailEvent extends Equatable {
  const StockDetailEvent();

  @override
  List<Object> get props => [];
}

class FetchStockDetail extends StockDetailEvent {
  final String symbol;

  const FetchStockDetail(this.symbol);

  @override
  List<Object> get props => [symbol];
}
