import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      theme: ThemeData(colorSchemeSeed: Colors.red, useMaterial3: true),
      darkTheme:
          ThemeData(colorSchemeSeed: Colors.red, useMaterial3: true, brightness: Brightness.dark),
      themeMode: ThemeMode.system,
      home: const MainArea()));
}