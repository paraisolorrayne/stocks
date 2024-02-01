import 'package:flutter/material.dart';
import 'package:stock_app/screens/login/login_screen.dart';
import 'package:stock_app/screens/stocks/stock_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stock App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginScreen(), // This sets the default route to the LoginScreen
      routes: {
        '/stockListScreen': (context) => StockListScreen(),
        // Define other routes here
      },
    );
  }
}
