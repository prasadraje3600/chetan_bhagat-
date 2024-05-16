import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BuyBooksLink extends StatefulWidget {
  String? url;
  BuyBooksLink({this.url, super.key});

  @override
  State<BuyBooksLink> createState() => _BuyBooksLinkState();
}

class _BuyBooksLinkState extends State<BuyBooksLink> {
  late WebViewController controller;

  @override
  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Color.fromRGBO(0, 0, 0, 0))
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
      ..loadRequest(Uri.parse(widget.url!));

    setState(() {});

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xFF021C4F),
        title: Text(
          "Buy Books",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
