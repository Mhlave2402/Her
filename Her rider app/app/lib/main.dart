import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'features/currency/currency_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize currency service with user's location
  final currencyService = CurrencyService();
  await currencyService.initialize();
  
  runApp(
    ChangeNotifierProvider.value(
      value: currencyService,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SheGo User App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currencyService = Provider.of<CurrencyService>(context);
    
    return Scaffold(
      appBar: AppBar(title: Text('SheGo User App')),
      body: Center(
        child: Text(
          'Current currency: ${currencyService.currencySymbol}',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
