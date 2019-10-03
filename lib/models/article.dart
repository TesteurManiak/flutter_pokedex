import 'package:flutter/material.dart';

class ArticleModel {
  final String sourceId;
  final String sourceName;
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String content;

  ArticleModel({
    this.sourceId,
    this.sourceName,
    this.author,
    @required this.title,
    @required this.description,
    @required this.url,
    @required this.urlToImage,
    this.publishedAt,
    @required this.content,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      sourceId: json['source']['id'],
      sourceName: json['source']['name'],
      author: json['author'],
      title: json['title'],
      description: json['description'],
      url: json['url'],
      urlToImage: json['urlToImage'],
      publishedAt: json['publishedAt'],
      content: json['content'],
    );
  }
}
