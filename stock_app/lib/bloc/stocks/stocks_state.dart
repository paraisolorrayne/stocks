import "package:equatable/equatable.dart";
import "package:stock_app/models/stocks_model.dart";

abstract class StocksState extends Equatable {
  @override
  List<Object> get props => [];
}

class StocksInitial extends StocksState {}

class StocksLoading extends StocksState {}

class StocksLoaded extends StocksState {
  final StocksModel stockModel; // Make sure this class has the fields you're trying to access

  StocksLoaded(this.stockModel);

  @override
  List<Object> get props => [stockModel];
}

class StocksError extends StocksState {
  final String error;
  final int retryCount;

  StocksError(this.error, {this.retryCount = 0});

  @override
  List<Object> get props => [error, retryCount];
}
