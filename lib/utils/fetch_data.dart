import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pokedex/models/pokemon.dart';

class PokeAPI {
  final String _apiUrl = "https://pokeapi.co/api/v2";
  final int _limitRequest = 20;

  /// Return a list of the 20 first pokemon
  Future<List<Pokemon>> fetchFirstList() async {
    final response = await http.get("$_apiUrl/pokemon/");
    if (response.statusCode == 200) {
      List<Pokemon> pkmnList = [];
      var json = jsonDecode(response.body);
      return pkmnList;
    } else {
      throw Exception('Failed to load pokemon list');
    }
  }

  /// Return a pokemon object fetch from the API.
  /// You can use either the pokemon id in the pokedex or its name
  /// to fetch the data.
  Future<Pokemon> fetchPokemon(String id) async {
    final response = await http.get("$_apiUrl/pokemon/$id");
    if (response.statusCode == 200) {
      return Pokemon.fromJson(jsonDecode(response.body));
    }
  }
}
