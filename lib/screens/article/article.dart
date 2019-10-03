import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/models/article.dart';
import 'package:pokedex/utils/launch_url.dart';

class ArticlePage extends StatelessWidget {
  final ArticleModel article;

  ArticlePage(this.article);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    child: Icon(Icons.arrow_back),
                    onPressed: Navigator.of(context).pop,
                  ),
                ],
              ),
              article.urlToImage == null
                  ? Container()
                  : CachedNetworkImage(imageUrl: article.urlToImage),
              SizedBox(height: 40),
              Text(
                article.title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: 20),
              Divider(),
              SizedBox(height: 20),
              Text(article.content == null
                  ? article.description
                  : article.content),
              SizedBox(height: 10),
              FlatButton(
                onPressed: () => launchUrl(article.url),
                child: Text(
                  "source",
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
