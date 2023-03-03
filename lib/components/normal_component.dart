import 'package:flutter/material.dart';

import '../tcp_var.dart';
import '../utils/qrcode_handle.dart';
import 'result.dart';

class NormalHandler extends StatefulWidget {
  const NormalHandler({super.key});

  @override
  State<StatefulWidget> createState() => _NormalHandler();
}

class _NormalHandler extends State<NormalHandler> {
  bool connectPart = false;
  String ip = "", port = "", pass = "";
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.ease,
      height: !connectPart ? MediaQuery.of(context).size.height - 100 : 150,
      child: Center(
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                    height: 5,
                    width: 80,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.grey))),
            !connectPart
                ? Column(children: [
                    const Text("Nhập thông tin", style: TextStyle(fontSize: 20)),
                    const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                            "Những thông tin này được cung cấp khi mở\n\"PowerLink Server\"",
                            textAlign: TextAlign.center)),
                    SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(children: [
                              const SizedBox(height: 10),
                              Row(children: [
                                Expanded(
                                    flex: 2,
                                    child: TextFormField(
                                        onChanged: (t) => ip = t,
                                        decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: "Địa chỉ IP"))),
                                const SizedBox(width: 5),
                                Expanded(
                                    flex: 1,
                                    child: TextFormField(
                                        onChanged: (t) => port = t,
                                        decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: "Cổng kết nối")))
                              ]),
                              const SizedBox(height: 10),
                              TextFormField(
                                  onChanged: (t) => pass = t,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(), labelText: "Mật khẩu")),
                              const SizedBox(height: 20),
                              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                TextButton(
                                    onPressed: () => setState(() => Navigator.of(context).pop()),
                                    child: const Text("Hủy")),
                                const SizedBox(width: 10),
                                FilledButton.tonal(
                                    onPressed: !connectPart
                                        ? () => setState(() => {
                                              connectPart = true,
                                              connected.value == "connecting",
                                              nCheck(ip: ip, port: int.parse(port), pass: pass)
                                            })
                                        : null,
                                    child: const Text("Kết nối"))
                              ])
                            ])))
                  ])
                : const ConnectionCheck(),
          ],
        ),
      ),
    );
  }
}
