import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:stock_app/bloc/details/stock_detail_bloc.dart';
import 'package:stock_app/bloc/details/stock_detail_event.dart';
import 'package:stock_app/bloc/details/stock_detail_state.dart';
import 'package:stock_app/models/stock_detail.dart';
import 'package:stock_app/models/stocks_model.dart';
import 'package:stock_app/repository/stocks/stock_detail_repository.dart';
import 'package:stock_app/screens/login/login_screen.dart';
import 'package:stock_app/widgets/stock_detail_info.dart';
import 'package:stock_app/widgets/stock_position_info.dart';

class StockDetailScreen extends StatelessWidget {
  final StockPosition position;

  StockDetailScreen({required this.position});

  @override
  Widget build(BuildContext context) {
    final storage = FlutterSecureStorage();
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
        return BlocProvider<StockDetailBloc>(
          create: (context) => StockDetailBloc(
            authToken: authToken,
            stockDetailRepository: StockDetailRepository(),
          )..add(FetchStockDetail(position.ticker)),
          child: Scaffold(
            appBar: AppBar(
              title: Text(position.name),
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(),
              ),
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
            body: BlocBuilder<StockDetailBloc, StockDetailState>(
              builder: (context, state) {
                if (state is StockDetailLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is StockDetailLoaded) {
                  return StockDetailWidget(stockDetail: state.stockDetail);
                } else if (state is StockDetailError) {
                  print(state.message);
                  return StockErrorWidget();
                }
                else {
                  return StockErrorWidget();
                }
              },
            ),
          ),
        );
      },
    );
  }

  Widget StockDetailWidget({required StockDetail stockDetail}) {
    return StockDetailInfo(
      stockDetail: stockDetail,
      stockPosition: position
    );
  }

  Widget StockErrorWidget() {
    return StockPositionInfo(
      position: position
    );
  }
}
