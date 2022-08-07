
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class ReadScreen extends StatefulWidget {
  final urlNews;

  ReadScreen({@required this.urlNews});

  @override
  _ReadScreenState createState() => _ReadScreenState();
}
class _ReadScreenState extends State<ReadScreen> {
  @override
  Widget build(BuildContext context) {

     return MaterialApp (
      debugShowCheckedModeBanner: false,

      home:Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Новости'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: WebView(
          initialUrl: '${widget.urlNews}',
          javascriptMode: JavascriptMode.unrestricted,
        )
        )
        );
  }
  }