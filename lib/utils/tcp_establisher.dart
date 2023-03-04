import 'package:flutter/foundation.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'dart:io';
import 'dart:convert';
import '../tcp_var.dart';

// ignore: non_constant_identifier_names
String retry_ip = "", rety_pass = "";
// ignore: non_constant_identifier_names
int retry_port = 0;

Future<void> qrCheck(BarcodeCapture capture) async {
  var intercept = jsonDecode(capture.barcodes[0].rawValue ?? "{}");
  if (intercept.isNotEmpty) {
    nCheck(ip: intercept["ip"], port: int.parse(intercept["port"]), pass: intercept["pass"]);
  }
}

Future<void> nCheck({String? ip, int? port, String? pass}) async {
  try {
    socket = await Socket.connect(ip ?? retry_ip, port ?? retry_port,
        timeout: const Duration(seconds: 5));
    debugPrint("Connected");
  } catch (_) {
    connected.value = "server_error";
    return;
  }
  socket!.add(utf8.encode(pass ?? rety_pass));
  socket!.listen((List<int> event) async {
    if (utf8.decode(event) == "accept") {
      retry_ip = ip ?? retry_ip;
      rety_pass = pass ?? rety_pass;
      retry_port = port ?? retry_port;
      connected.value = "accepted";
      debugPrint("Password correct");
    } else {
      debugPrint("Wrong password");
      connected.value = "wrong_pass";
      socket!.close();
    }
  }, onError: (_) => {connected.value = "server_error", socket!.close()});
}
