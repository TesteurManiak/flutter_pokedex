import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/models/article.dart';
import 'package:pokedex/screens/article/article.dart';
import 'package:pokedex/widgets/poke_news.dart';

class NewsList extends StatelessWidget {
  final List<ArticleModel> articles;

  NewsList(this.articles);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: articles == null ? 0 : articles.length,
      separatorBuilder: (context, index) => Divider(),
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      ArticlePage(articles[index]))),
          child: PokeNews(
            title: articles[index].title,
            time: articles[index].publishedAt,
            //thumbnail: Image.asset("assets/images/thumbnail.png"),
            thumbnail: articles[index].urlToImage == null
                ? null
                : CachedNetworkImage(
                    imageUrl: articles[index].urlToImage,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
          ),
        );
      },
    );
  }
}
