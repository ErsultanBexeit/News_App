import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webfeed/domain/rss_feed.dart';
import 'package:webfeed/domain/rss_item.dart';

import 'NewsModel.dart';
import 'package:http/http.dart' as http;

import 'read_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static String rssUrl = 'http://feeds.feedburner.com/yandex/MAOo';
  List _news = [];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Новости'),
        ),
        body: Container(
          child: FutureBuilder(
            future: fetchNews(),
            builder: (context, snap) {
              if (snap.hasData) {
                return ListView.separated(
                  itemBuilder: (context, i) {
                    final RssItem _item = _news[i];
                    return ListTile(
                      onTap: (() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ReadScreen(urlNews: _item.link)));
                      }),
                      title: Text('${_item.title}'),
                      subtitle: Text(
                        '${_item.description}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  },
                  separatorBuilder: (context, i) => Divider(),
                  itemCount: _news.length,
                );
              } else if (snap.hasError) {
                return Center(
                  child: Text(snap.error.toString()),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  fetchNews() async {
    var response = await fetchHttpNews(Uri.parse(rssUrl));
    var chanel = RssFeed.parse(response.body);
    chanel.items!.forEach((element) {
      _news.add(element);
    });
    return _news;
  }

  fetchHttpNews(url) {
    var client = http.Client();
    return client.get(url);
  }
}
