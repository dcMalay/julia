import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HelpandSupport extends StatefulWidget {
  const HelpandSupport({super.key, this.url});
  final url;
  @override
  State<HelpandSupport> createState() => _HelpandSupportState(this.url);
}

class _HelpandSupportState extends State<HelpandSupport> {
  var _url;
  final _key = UniqueKey();
  _HelpandSupportState(this._url);
  late WebViewController controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: WebView(
            key: _key,
            javascriptMode: JavascriptMode.unrestricted,
            initialUrl: _url,
            onWebViewCreated: (controller) {
              this.controller = controller;
            },
            onPageStarted: (url) {
              controller.runJavascript(
                  "document.getElementByClassName('header').style.display='none'");
            },
          ),
        )
      ],
    ));
  }
}
