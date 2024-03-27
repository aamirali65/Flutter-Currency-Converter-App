import 'package:currensee/services/connection.dart';
import 'package:currensee/widgets/customText.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetail extends StatelessWidget {
  final String blogUrl;
  NewsDetail({required this.blogUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff182D9E),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          InternetConnection(),
          Container(
            child: WebView(
              initialUrl: blogUrl,
              javascriptMode: JavascriptMode.unrestricted,
            ),
          )
        ],
      )
    );
  }
}
