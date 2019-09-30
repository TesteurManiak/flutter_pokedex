import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pokedex/data/pokemons.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/models/specie.dart';
import 'package:pokedex/utils/fileData.dart';

class PokeAPI {
  final String _apiUrl = "https://pokeapi.co/api/v2";
  final String _genderUrl = "https://pokeapi.co/api/v2/gender/1/";

  Future fetchTotalPkmn() async {
    if (pkmnCount == null) {
      final response = await http.get("$_apiUrl/pokemon/");
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        pkmnCount = json['count'];
      } else {
        throw Exception('Failed to load pokemon list');
      }
    }
  }

  /// load the next pokemon in the list
  Future fetchNext([int maxRequest = 16]) async {
    int nbRequest = pokemons.length + maxRequest > pkmnCount
        ? pkmnCount - pokemons.length
        : maxRequest;
    for (int i = 0; i < nbRequest; i++) {
      pokemons.add(await fetchPokemon((pokemons.length + 1).toString()));
    }
    pokemons = pokemons.toSet().toList();
  }

  /// Return a pokemon object fetch from the API.
  /// You can use either the pokemon id in the pokedex or its name
  /// to fetch the data.
  Future<Pokemon> fetchPokemon(String id) async {
    // First check if PkmnFile already exists
    var myFile = await localFile(id);
    if ((await myFile.exists())) {
      String content = await readPkmnFile(id);
      var json = jsonDecode(content);
      return Pokemon.fromJson(json);
    }

    final response = await http.get("$_apiUrl/pokemon/$id/");
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      await writeJson(response.body, id);
      return Pokemon.fromJson(json);
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
      species.eggGroups = [];
      json['egg_groups'].forEach((group) {
        species.eggGroups.add(EggGroup.fromJson(group));
      });
      for (final entry in json['flavor_text_entries']) {
        if (entry['language']['name'] == "en") {
          species.flavorText =
              entry['flavor_text'].toString().replaceAll(RegExp(r'\n'), " ");
          break;
        }
      }
      for (final entry in json['genera']) {
        if (entry['language']['name'] == "en") {
          species.genus = entry['genus'];
          break;
        }
      }
    } else {
      throw Exception('Failed to load species ${species.name}');
    }
  }

  Future fetchGenderRate(Specie species) async {
    final response = await http.get(_genderUrl);
    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      for (final specie in json['pokemon_species_details']) {
        if (specie['pokemon_species']['name'] == species.name.toLowerCase()) {
          species.femaleRate = specie['rate'];
          break;
        }
      }
    } else {
      throw Exception('Failed to load gender rate');
    }
  }
}
