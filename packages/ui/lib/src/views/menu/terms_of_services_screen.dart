import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


@RoutePage()
class TermsOfServiceScreen extends StatefulWidget {
  const TermsOfServiceScreen({super.key});
  static const route = '/terms-and-conditions';

  @override
  State<TermsOfServiceScreen> createState() =>
      _TermsOfServiceScreenState();
}

class _TermsOfServiceScreenState extends State<TermsOfServiceScreen> {
  late final WebViewController controller;
  double progress = 0;
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
        ),
      )
      ..loadRequest(Uri.parse('https://eesup-privacy-policy.web.app/#/'));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: const BackButton(),
            centerTitle: false,
            title: const Text('Terms and Conditions'),
          ),
          body: Column(
            children: [
              LinearProgressIndicator(
                value: progress,
                minHeight: 2,
              ),
              Expanded(child: WebViewWidget(controller: controller)),
            ],
          ),
        ),
      ),
    );
  }
}
