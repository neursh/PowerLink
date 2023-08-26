import 'package:flutter/material.dart';
import 'package:powerlink/screens/main_page.dart';

void main() {
  runApp(PowerLinkUI());
}

class PowerLinkUI extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PowerLinkUIState();
}

class _PowerLinkUIState extends State<PowerLinkUI> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme:
            ThemeData(colorSchemeSeed: Colors.yellowAccent, useMaterial3: true),
        darkTheme: ThemeData(
            colorSchemeSeed: Colors.yellowAccent,
            useMaterial3: true,
            brightness: Brightness.dark),
        themeMode: ThemeMode.system,
        home: MainPage());
  }
}
