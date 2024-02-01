import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:stock_app/bloc/stocks/stocks_bloc.dart';
import 'package:stock_app/bloc/stocks/stocks_event.dart';
import 'package:stock_app/bloc/stocks/stocks_state.dart';
import 'package:stock_app/repository/stocks/stocks_repository.dart';
import 'package:stock_app/screens/login/login_screen.dart';
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
          return Scaffold(body: Center(child: Text('Error retrieving auth token')));
        } else if (snapshot.data == null || snapshot.data!.isEmpty) {
          return Scaffold(body: Center(child: Text('No auth token available')));
        }

        final authToken = snapshot.data!;
        final stocksRepository = StocksRepository();

        return BlocProvider<StocksBloc>(
          create: (context) => StocksBloc(stocksRepository: stocksRepository, authToken: authToken)
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
                        child: StockList(stocks: state.stockModel.positions),
                      ),
                    ],
                  );
                } else if (state is StocksError) {
                  return Center(
                    child: Text(state.error),
                  );
                }
                return Center(child: Text('Unexpected state')); // default return in case none above
              },
            ),
          ),
        );
      },
    );
  }
}
