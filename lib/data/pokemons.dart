import 'package:pokedex/models/article.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/utils/fetch_data.dart';
import 'package:pokedex/utils/news_api.dart';

List<Pokemon> pokemons = [];

List<Pokemon> searchResult = [];

String searchText = "";

int pkmnCount;

PokeAPI api = PokeAPI();

NewsApi newsApi = NewsApi();

List<ArticleModel> newsList = [];
