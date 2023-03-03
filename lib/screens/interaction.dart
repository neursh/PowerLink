import 'dart:convert';

import 'package:flutter/material.dart';
import '../components/result.dart';
import '../tcp_var.dart';
import '../utils/qrcode_handle.dart';

class InteractionHandler extends StatefulWidget {
  const InteractionHandler({super.key});

  @override
  State<StatefulWidget> createState() => _InteractionHandler();
}

class _InteractionHandler extends State<InteractionHandler> {
  @override
  Widget build(BuildContext context) {
    void navigate(String key) {
      try {
        socket!.add(utf8.encode(key));
      } catch (_) {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Mất kết nối"),
                content: const Text("Đã xảy ra lỗi khi cố kết nối với máy tính của bạn!"),
                actions: <Widget>[
                  TextButton(
                    child: const Text("Đóng phiên"),
                    onPressed: () {
                      ready.value = false;
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: const Text("Thử lại"),
                    onPressed: () {
                      nCheck();
                      showModalBottomSheet<void>(
                          context: context,
                          isScrollControlled: true,
                          builder: (BuildContext context) {
                            return const SizedBox(height: 150, child: ConnectionCheck());
                          });
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });
      }
    }

    return Scaffold(
        appBar: AppBar(
            title: const Text("PowerLink"),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.link_off),
              onPressed: () {
                ready.value = false;
                socket!.close();
              },
            )),
        body: Column(children: [
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Card(
                    child: InkWell(
                        splashFactory: NoSplash.splashFactory,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        onTap: () => navigate("f5"),
                        child: const Padding(
                            padding: EdgeInsets.all(10), child: Text("Trình chiếu từ đầu")))),
                Card(
                    child: InkWell(
                        splashFactory: NoSplash.splashFactory,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        onTap: () => navigate("shift+f5"),
                        child: const Padding(
                            padding: EdgeInsets.all(10),
                            child: Text("Trình chiếu trang hiện tại"))))
              ])),
          Expanded(
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                      child: InkWell(
                          splashFactory: NoSplash.splashFactory,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          onTap: () => navigate("right"),
                          child: const SizedBox(child: Icon(Icons.expand_less, size: 60)))))),
          Expanded(
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                      child: InkWell(
                          splashFactory: NoSplash.splashFactory,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          onTap: () => navigate("left"),
                          child: const SizedBox(child: Icon(Icons.expand_more, size: 60)))))),
        ]));
  }
}
