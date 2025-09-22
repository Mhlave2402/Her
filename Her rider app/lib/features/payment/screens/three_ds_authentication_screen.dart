import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class ThreeDSAuthenticationScreen extends StatefulWidget {
  final String redirectUrl;
  final Function(bool) onCompletion;

  const ThreeDSAuthenticationScreen({
    super.key,
    required this.redirectUrl,
    required this.onCompletion,
  });

  @override
  State<ThreeDSAuthenticationScreen> createState() => _ThreeDSAuthenticationScreenState();
}

class _ThreeDSAuthenticationScreenState extends State<ThreeDSAuthenticationScreen> {
  late InAppWebViewController _webViewController;
  bool _isLoading = true;
  bool _is3dsCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('3D Secure Authentication'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            if (!_is3dsCompleted) {
              widget.onCompletion(false);
            }
            Get.back();
          },
        ),
      ),
      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(url: WebUri(widget.redirectUrl)),
            onWebViewCreated: (controller) {
              _webViewController = controller;
            },
            onLoadStart: (controller, url) {
              setState(() => _isLoading = true);
              _check3dsCompletion(url.toString());
            },
            onLoadStop: (controller, url) {
              setState(() => _isLoading = false);
              _check3dsCompletion(url.toString());
            },
            onLoadError: (controller, url, code, message) {
              setState(() => _isLoading = false);
              _check3dsCompletion(url.toString());
            },
          ),
          if (_isLoading)
            const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }

  void _check3dsCompletion(String url) {
    if (url.contains('success') || url.contains('fail') || url.contains('cancel')) {
      _is3dsCompleted = true;
      widget.onCompletion(url.contains('success'));
      Get.back();
    }
  }
}
