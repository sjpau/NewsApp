import 'package:flutter/material.dart';

class ThemeStyles {
  static const BoxDecoration appBarGradientDecoration = BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Colors.deepPurple,
        Colors.purple,
        Colors.pink,
        Colors.orange,
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  );

  static const TextStyle appBarTitleStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20.0,
    color: Colors.white,
  );

  static const EdgeInsets newsTileMargin = EdgeInsets.all(4.0);
  static const BoxDecoration newsTileImageDecoration = BoxDecoration(
    color: Colors.grey,
  );
  static const TextStyle newsTileTitleStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16.0,
  );
  static const TextStyle newsTileDateStyle = TextStyle(
    color: Colors.grey,
  );
}
