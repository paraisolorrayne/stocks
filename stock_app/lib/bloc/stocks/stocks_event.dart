import "package:equatable/equatable.dart";

abstract class StocksEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchStocks extends StocksEvent {}

