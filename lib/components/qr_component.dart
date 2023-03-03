import 'package:flutter/material.dart';
import '../tcp_var.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../utils/qrcode_handle.dart';
import 'result.dart';

class QRHandler extends StatefulWidget {
  const QRHandler({super.key});

  @override
  State<StatefulWidget> createState() => _QRHandler();
}

class _QRHandler extends State<QRHandler> {
  bool connectPart = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.ease,
      height: !connectPart ? MediaQuery.of(context).size.height - 300 : 150,
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
                    const Text("Quét mã QR", style: TextStyle(fontSize: 20)),
                    SizedBox(
                        height: MediaQuery.of(context).size.height - 354,
                        width: MediaQuery.of(context).size.width,
                        child: MobileScanner(
                            controller: MobileScannerController(detectionTimeoutMs: 1000),
                            onDetect: (capture) => setState(() => {
                                  connectPart = true,
                                  connected.value == "connecting",
                                  qrCheck(capture)
                                })))
                  ])
                : const ConnectionCheck(),
          ],
        ),
      ),
    );
  }
}
