import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../tcp_var.dart';
import '../utils/tcp_establisher.dart';

ValueNotifier<bool> ready = ValueNotifier<bool>(false);

class ConnectionCheck extends StatelessWidget {
  final String? ip;
  final int? port;
  final String? pass;
  final BarcodeCapture? capture;
  const ConnectionCheck({super.key, this.ip, this.port, this.pass, this.capture});

  void initState() {
    connected.value = "connecting";
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: establish(),
        builder: (context, snapshot) {
          return AnimatedBuilder(
              animation: connected,
              builder: ((context, child) {
                connected.value != "connecting"
                    ? Future.delayed(const Duration(seconds: 3)).then((_) {
                        if (connected.value == "accepted") {
                          ready.value = true;
                        }
                        Navigator.of(context).popUntil((route) => route.isFirst);
                      })
                    : null;
                return Center(
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                      connected.value == "accepted"
                          ? "Đã kết nối thành công!"
                          : connected.value == "wrong_pass"
                              ? "Sai mật khẩu!"
                              : connected.value == "server_error"
                                  ? "Không thể kết nối!"
                                  : "Đang kết nối...",
                      style: const TextStyle(fontSize: 20)),
                  const SizedBox(height: 20),
                  connected.value == "accepted"
                      ? const Icon(Icons.file_download_done, size: 40)
                      : connected.value == "wrong_password"
                          ? const Icon(Icons.close, size: 40)
                          : connected.value == "server_error"
                              ? const Icon(Icons.block, size: 40)
                              : const CircularProgressIndicator()
                ]));
              }));
        });
  }

  Future<void> establish() async {
    connected.value = "connecting";
    await Future.delayed(const Duration(seconds: 1));
    if (capture != null) {
      await qrCheck(capture!);
    } else {
      await nCheck(ip: ip, port: port, pass: pass);
    }
  }
}
