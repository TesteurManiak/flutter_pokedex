import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/utils/fetch_data.dart';

List<Pokemon> pokemons = [];

List<Pokemon> searchResult = [];

String searchText = "";

int pkmnCount;

PokeAPI api = PokeAPI();
