import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:stock_app/bloc/details/stock_detail_bloc.dart';
import 'package:stock_app/bloc/details/stock_detail_event.dart';
import 'package:stock_app/bloc/stocks/stocks_bloc.dart';
import 'package:stock_app/bloc/stocks/stocks_event.dart';
import 'package:stock_app/bloc/stocks/stocks_state.dart';
import 'package:stock_app/models/stocks_model.dart';
import 'package:stock_app/repository/stocks/stock_detail_repository.dart';
import 'package:stock_app/repository/stocks/stocks_repository.dart';
import 'package:stock_app/screens/login/login_screen.dart';
import 'package:stock_app/screens/stocks/stock_detail_screen.dart';
import 'package:stock_app/utils/secure_storage.dart';
import 'package:stock_app/widgets/portfolio_header.dart';
import 'package:stock_app/widgets/stock_list.dart';

class StockListScreen extends StatelessWidget {
  final storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: storage.read(key: 'authentication_token'),
      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        } else if (snapshot.hasError) {
          return Scaffold(
              body: Center(child: Text('Error retrieving auth token')));
        } else if (snapshot.data == null || snapshot.data!.isEmpty) {
          return Scaffold(body: Center(child: Text('No auth token available')));
        }

        final authToken = snapshot.data!;
        final stocksRepository = StocksRepository();

        return BlocProvider<StocksBloc>(
          create: (context) => StocksBloc(
              stocksRepository: stocksRepository, authToken: authToken)
            ..add(FetchStocks()),
          child: Scaffold(
            appBar: AppBar(
              title: Text('Portfolio'),
              actions: [
                IconButton(
                  icon: Icon(Icons.logout),
                  onPressed: () async {
                    await storage.delete(key: 'authentication_token');
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                      (Route<dynamic> route) => false,
                    );
                  },
                ),
              ],
            ),
            body: BlocBuilder<StocksBloc, StocksState>(
              builder: (context, state) {
                return RefreshIndicator(
                  onRefresh: () async {
                    BlocProvider.of<StocksBloc>(context).add(FetchStocks());
                  },
                  child: _buildStockList(context, state),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildStockList(BuildContext context, StocksState state) {
    if (state is StocksLoading) {
      return Center(child: CircularProgressIndicator());
    } else if (state is StocksLoaded) {
      return Column(
        children: [
          PortfolioHeader(
            currentValue: state.stockModel.currentValue,
            percentageChange: state.stockModel.percentageChange,
          ),
          Expanded(
            child: StockList(
              stocks: state.stockModel.positions,
              onStockTap: (stock) => navigateToDetail(context, stock),
            ),
          ),
        ],
      );
    } else if (state is StocksError) {
      if (state.retryCount >= 3) {
        return Center(child: Text('Error to load'));
      } else {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Failed to load stocks. Please try again.'),
              ElevatedButton(
                child: Text('Try Again'),
                onPressed: () {
                  BlocProvider.of<StocksBloc>(context).add(FetchStocks());
                },
              ),
            ],
          ),
        );
      }
    } else {
      return Center(child: Text('Unexpected state'));
    }
  }

  void navigateToDetail(BuildContext context, StockPosition position) async {
    // Create an instance of SecureStorage or make sure that getAuthToken is a static method
    final SecureStorage secureStorage = SecureStorage();
    final String? authToken = await secureStorage.getAuthToken();

    if (authToken == null) {
      // Handle the case where there is no token
      // For example, navigate to an error screen or show an error message
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BlocProvider<StockDetailBloc>(
            create: (context) => StockDetailBloc(
              authToken: authToken,
              stockDetailRepository: StockDetailRepository(),
            )..add(FetchStockDetail(position.ticker)),
            child: StockDetailScreen(position: position),
          ),
        ),
      );
    }
  }
}

class ErrorScreen extends StatelessWidget {
  final String message;
  const ErrorScreen({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: Center(
        child: Text(message),
      ),
    );
  }
}
