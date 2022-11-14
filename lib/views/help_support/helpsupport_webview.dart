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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Expanded(
                child: WebView(
                    key: _key,
                    javascriptMode: JavascriptMode.unrestricted,
                    initialUrl: _url))
          ],
        ));
  }
}
