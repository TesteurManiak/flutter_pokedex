import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/data/pokemons.dart';
import 'package:pokedex/models/article.dart';
import 'package:pokedex/screens/article/article.dart';
import 'package:pokedex/widgets/poke_news.dart';

class AllArticles extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AllArticlesState();
}

class _AllArticlesState extends State<AllArticles> {
  List<ArticleModel> articlesList;

  _loadArticles() async {
    articlesList = await newsApi.fetchXArticles(20);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _loadArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: articlesList == null
            ? CircularProgressIndicator()
            : ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (context, index) => Divider(),
                itemCount: articlesList == null ? 0 : articlesList.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                ArticlePage(articlesList[index]))),
                    child: PokeNews(
                      title: articlesList[index].title,
                      time: articlesList[index].publishedAt,
                      thumbnail: articlesList[index].urlToImage == null
                          ? null
                          : CachedNetworkImage(
                              imageUrl: articlesList[index].urlToImage,
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
