import 'package:flutter/material.dart';
import 'pages/news_list_page.dart';
import 'package:newsapp/locators/service_locator.dart'; // Import the service locator

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter News App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: NewsListPage(),
    );
  }
}
