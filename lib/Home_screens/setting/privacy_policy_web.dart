import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class PrivacyPloicyWebView extends StatelessWidget {
  final url;
  PrivacyPloicyWebView(this.url);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(url == 'https://www.skinvision.com/privacy/'? "Privacy Policy":'Terms and Conditions'),
      ),
      body:WebviewScaffold(
        url: url,
        withJavascript: true,
      ),
    );
  }
}
