import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_app/bloc/details/stock_detail_bloc.dart';
import 'package:stock_app/models/stocks_model.dart';
import 'package:stock_app/repository/stocks/stock_detail_repository.dart';
import 'package:stock_app/screens/login/login_screen.dart';
import 'package:stock_app/screens/stocks/stock_detail_screen.dart';
import 'package:stock_app/screens/stocks/stock_list_screen.dart';
import 'package:stock_app/utils/secure_storage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stock App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginScreen(),
      routes: {
        '/stockListScreen': (context) => StockListScreen(),
      },
    );
  }
}