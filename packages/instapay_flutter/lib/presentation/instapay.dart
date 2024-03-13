import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:instapay_flutter/data/merchant_transaction.dart';
import 'package:webview_flutter/webview_flutter.dart';

class InstapayFlutter extends StatefulWidget {
  const InstapayFlutter({super.key, required this.transaction});
  final MerchantTransaction transaction;

  @override
  State<InstapayFlutter> createState() => _InstapayFlutterState();
}

class _InstapayFlutterState extends State<InstapayFlutter> {
  late final WebViewController controller;
  int convertToCents(double amount) {
    // Multiply by 100 and round to avoid floating point arithmetic issues
    return (amount * 100).round();
  }

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(
        Uri.parse('https://zngp5d89-3000.inc1.devtunnels.ms/lib/insta_pay.php'),
        method: LoadRequestMethod.post,
        body: jsonToUint8List(
          jsonEncode(
            widget.transaction.toJson(),
          ),
        ),
      );
  }

  Uint8List jsonToUint8List(String jsonString) {
    List<int> bytes = utf8.encode(jsonString);
    return Uint8List.fromList(bytes);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: WebViewWidget(controller: controller),
      ),
    );
  }
}
