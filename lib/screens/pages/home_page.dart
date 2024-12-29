import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  InAppWebViewController? webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: WebUri("https://www.google.com/maps"),
        ),
        initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
            javaScriptEnabled: true, // Enable JavaScript for interactivity
            supportZoom: true, // Allow zooming in/out
            useOnDownloadStart: true, // Handle downloads if necessary
          ),
        ),
        onWebViewCreated: (controller) {
          webViewController = controller;
        },
        onLoadStop: (controller, url) {
          print("Page finished loading: $url");
        },
        onLoadError: (controller, url, code, message) {
          print("Error loading page: $message");
        },

      ),
    );
  }
}
