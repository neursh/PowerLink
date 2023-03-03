import 'package:flutter/material.dart';

import 'connect_prompt.dart';
import '../components/result.dart';
import 'interaction.dart';

class MainArea extends StatefulWidget {
  const MainArea({super.key});

  @override
  State<StatefulWidget> createState() => _MainAreaState();
}

class _MainAreaState extends State<MainArea> {
  bool typing = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: ready,
        builder: (context, child) {
          return !ready.value ? const ConnectPrompt() : const InteractionHandler();
        });
  }
}
