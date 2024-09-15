import 'package:currency_main/application/provider/userprovider_currency.dart';
import 'package:currency_main/presentation/home_screen/home_screen.dart';
import 'package:currency_main/presentation/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProviderCurrency()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        // home: HomeScreen(),
      ),
    );
  }
}
