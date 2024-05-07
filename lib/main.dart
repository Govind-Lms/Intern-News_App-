import 'package:flutter/material.dart';
import 'package:news_api_app/providers/business_provider.dart';
import 'package:news_api_app/providers/health_provider.dart';
import 'package:news_api_app/providers/tech_provider.dart';
import 'package:news_api_app/view/pages/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((_) => BusinessProvider())),
        ChangeNotifierProvider(create: ((_)=> TechProvider())),
        ChangeNotifierProvider(create: ((_)=> HealthProvider())),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News API',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
