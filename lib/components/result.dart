import 'package:flutter/material.dart';
import '../tcp_var.dart';

ValueNotifier<bool> ready = ValueNotifier<bool>(false);

class ConnectionCheck extends StatelessWidget {
  const ConnectionCheck({super.key});

  @override
  Widget build(BuildContext context) {
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
  }
}
