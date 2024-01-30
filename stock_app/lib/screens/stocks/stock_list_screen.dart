import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_app/screens/login/login_screen.dart';
import 'package:stock_app/bloc/portfolio_bloc.dart'; // Adjust with actual import
import 'package:stock_app/models/portfolio.dart'; // Adjust with actual import

class StockListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PortfolioBloc()..add(FetchPortfolio()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Portfolio'),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
  // Assuming you're using SharedPreferences to store the token
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('authentication_token'); // Clear the token

  // Navigate back to the login screen, assuming it's the root of your navigation stack
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (context) => LoginScreen()),
    (Route<dynamic> route) => false,
  );
},
            ),
          ],
        ),
        body: BlocBuilder<PortfolioBloc, PortfolioState>(
          builder: (context, state) {
            if (state is PortfolioLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is PortfolioLoaded) {
              return ListView.builder(
                itemCount: state.portfolio.positions.length,
                itemBuilder: (context, index) {
                  final position = state.portfolio.positions[index];
                  return ListTile(
                    leading: Image.network(position.logoUrl), // Display logo image
                    title: Text(position.name),
                    subtitle: Text('${position.quantity} stocks'),
                    trailing: Text('\$${position.lastPrice.toStringAsFixed(2)}'),
                  );
                },
              );
            } else if (state is PortfolioError) {
              return Center(child: Text('Failed to load portfolio'));
            } else {
              return Container(); // Empty container for uninitialized state
            }
          },
        ),
      ),
    );
  }
}
