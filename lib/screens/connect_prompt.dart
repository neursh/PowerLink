import 'package:flutter/material.dart';

import '../components/normal_component.dart';
import '../components/qr_component.dart';

class ConnectPrompt extends StatefulWidget {
  const ConnectPrompt({super.key});

  @override
  State<StatefulWidget> createState() => _ConnectPromptState();
}

class _ConnectPromptState extends State<ConnectPrompt> {
  bool typing = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("PowerLink"), centerTitle: true),
      body: SingleChildScrollView(
          child: Column(children: [
        const InfoBox(
            icon: Icon(Icons.warning_amber),
            content:
                "Chắc chắn rằng máy điện thoại và máy tính của bạn được kết nối tới cùng một mạng!"),
        const InfoBox(
            icon: Icon(Icons.info_outline),
            content:
                "Để bắt đầu ghép nối, hãy mở ứng dụng \"PowerLink Server\" đã được cài đặt trong máy tính của bạn."),
        SizedBox(width: MediaQuery.of(context).size.width - 50, child: const Divider()),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          ElevatedButton.icon(
              onPressed: () {
                showModalBottomSheet<void>(
                    context: context,
                    isScrollControlled: true,
                    builder: (BuildContext context) {
                      return const QRHandler();
                    });
              },
              label: const Text("Kết nối bằng mã QR"),
              icon: const Icon(Icons.qr_code)),
          ElevatedButton.icon(
              onPressed: () {
                showModalBottomSheet<void>(
                    context: context,
                    isScrollControlled: true,
                    builder: (BuildContext context) {
                      return StatefulBuilder(builder: (context, stater) {
                        return const NormalHandler();
                      });
                    });
              },
              label: const Text("Kết nối thủ công"),
              icon: const Icon(Icons.keyboard_outlined)),
        ]),
      ])),
    );
  }
}

class InfoBox extends StatelessWidget {
  final Icon icon;
  final String content;
  const InfoBox({super.key, required this.icon, required this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Card(
            child: SizedBox(
                width: MediaQuery.of(context).size.width - 20,
                child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      icon,
                      const SizedBox(width: 10),
                      Expanded(child: Text(content))
                    ])))));
  }
}
