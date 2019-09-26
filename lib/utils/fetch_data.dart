import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pokedex/data/pokemons.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/models/specie.dart';

class PokeAPI {
  final String _apiUrl = "https://pokeapi.co/api/v2";
  final int limitRequest = 8;

  /// load the next pokemon in the list
  Future fetchNext([int nbRequest = 10]) async {
    final response = await http.get("$_apiUrl/pokemon/");
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      int count = json['count'];
      int nbRequest = pokemons.length + limitRequest > count
          ? count - pokemons.length
          : limitRequest;
      for (int i = 0; i < nbRequest; i++) {
        pokemons.add(await fetchPokemon((pokemons.length + 1).toString()));
      }
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
    } else {
      throw Exception('Failed to load pokemon $id');
    }
  }

  Future fetchSpecies(Specie species) async {
    final response = await http.get(species.url);
    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      species.baseHappiness = json['base_happiness'];
      species.captureRate = json['apture_rate'];
      for (final entry in json['flavor_text_entries']) {
        if (entry['language']['name'] == "en") {
          species.flavorText =
              entry['flavor_text'].toString().replaceAll(RegExp(r'\n'), " ");
          break;
        }
      }
    } else {
      throw Exception('Failed to load species ${species.name}');
    }
  }
}
