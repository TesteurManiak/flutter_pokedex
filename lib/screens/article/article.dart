import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/models/article.dart';

class ArticlePage extends StatelessWidget {
  final ArticleModel article;

  ArticlePage(this.article);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
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
              Text(article.content),
            ],
          ),
        ),
      ),
    );
  }
}
