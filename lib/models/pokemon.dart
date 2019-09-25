import 'package:flutter/material.dart';
import 'package:pokedex/configs/AppColors.dart';
import 'package:pokedex/models/ability.dart';
import 'package:pokedex/models/form.dart' as pkmn;
import 'package:pokedex/models/game_indice.dart';
import 'package:pokedex/models/move.dart';
import 'package:pokedex/models/specie.dart';

/// To add:
///  held_items
/// sprites
/// stats
/// types
/// weight

class Pokemon {
  const Pokemon({
    @required this.name,
    this.types = const [],
    @required this.image,
    @required this.color,
    @required this.id,
    this.abilities,
    this.baseExperience,
    this.forms,
    this.gameIndices,
    this.height,
    this.isDefault,
    this.locationAreaEncounters,
    this.moves,
    this.order,
    this.species,
  });

  final Color color;
  final String image;
  final String name;
  final List<String> types;
  final int id;
  final List<Ability> abilities;
  final int baseExperience;
  final List<pkmn.Form> forms;
  final List<GameIndice> gameIndices;
  final int height;
  final bool isDefault;
  final String locationAreaEncounters;
  final List<Move> moves;
  final int order;
  final Specie species;

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    List<String> types = [];
    json['types'].forEach((type) {
      types.add(type['type']['name']);
    });

    List<Ability> abilities = [];
    json['abilities'].forEach((ability) {
      abilities.add(Ability.fromJson(ability));
    });

    List<pkmn.Form> forms = [];
    json['forms'].forEach((form) {
      forms.add(pkmn.Form.fromJson(form));
    });

    List<GameIndice> gameIndices = [];
    json['game_indices'].forEach((gameIndice) {
      gameIndices.add(GameIndice.fromJson(gameIndice));
    });

    List<Move> moves = [];
    json['moves'].forEach((move) {
      moves.add(Move.fromJson(move));
    });

    return Pokemon(
      color: AppColors.lightTeal,
      image: json['sprites']['front_default'],
      name: json['name'],
      types: types,
      id: json['id'],
      abilities: abilities,
      baseExperience: json['base_experience'],
      forms: forms,
      gameIndices: gameIndices,
      height: json['height'],
      isDefault: json['is_default'],
      locationAreaEncounters: json['location_area_encounters'],
      moves: moves,
      order: json['order'],
      species: Specie.fromJson(json['species']),
    );
  }
}
