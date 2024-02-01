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
      onGenerateRoute: (settings) {
        // Verifique a rota e extraia os argumentos, se necessário.
        if (settings.name == '/stockDetailListScreen') {
          final args = settings.arguments
              as StockPosition; // Ajuste o tipo de acordo com o seu objeto de argumento.
          return MaterialPageRoute(
            builder: (context) => StockDetailScreen(position: args),
          );
        }
        // Rota padrão, se não corresponder a nenhuma das condições anteriores.
        return MaterialPageRoute(
          builder: (context) => StockListScreen(),
        );
      },
    );
  }
}
