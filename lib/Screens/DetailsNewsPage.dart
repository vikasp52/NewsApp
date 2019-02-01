import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:unfound/Screens/Widgets/commonBodyStrecture.dart';



class DetailNews extends StatelessWidget {
  static String tag = 'description-page';
  DetailNews(this.urlnews);
  final String urlnews;
  Widget build(BuildContext context) {
    return CommonBodyStructure(
      text: "FULL ARTICAL",
      child: Column(
        children: <Widget>[
          Expanded(
            child: MaterialApp(
              routes: {
                "/": (_) => new WebviewScaffold(
                  url: urlnews,
                  appBar: new AppBar(title: new Text("")),
                )
              },
            ),
          ),
        ],
      ),
    );
  }
}
