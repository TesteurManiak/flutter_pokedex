import 'package:flutter/material.dart';
import 'package:pokedex/configs/AppColors.dart';
import 'package:pokedex/models/ability.dart';
import 'package:pokedex/models/form.dart' as pkmn;
import 'package:pokedex/models/game_indice.dart';
import 'package:pokedex/models/move.dart';
import 'package:pokedex/models/specie.dart';
import 'package:pokedex/models/stat.dart';

/// To add:
/// held_items

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
    this.sprites,
    this.stats,
    this.weight,
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
  final List<String> sprites;
  final List<Stat> stats;
  final int weight;

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    List<String> types = [];
    json['types'].forEach((type) {
      types.add(type['type']['name']);
    });
    Iterable inReverse = types.reversed;
    types = inReverse.toList();

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

    var sprites = List<String>();
    var backSprites = List<String>();
    json['sprites'].forEach((indexKey, sprite) {
      if (sprite != null) {
        if (indexKey.toString().contains('back')) {
          backSprites.add(sprite);
        } else {
          sprites.add(sprite);
        }
      }
    });
    sprites.addAll(backSprites);

    List<Stat> stats = [];
    json['stats'].forEach((stat) {
      stats.add(Stat.fromJson(stat));
    });

    Color color;
    switch (types[0]) {
      case 'rock':
        color = AppColors.rockBrown;
        break;
      case 'ice':
        color = AppColors.iceBlue;
        break;
      case 'fairy':
        color = AppColors.fairyPink;
        break;
      case 'dark':
        color = AppColors.darkBlack;
        break;
      case 'steel':
        color = AppColors.steelGrey;
        break;
      case 'dragon':
        color = AppColors.dragonYellow;
        break;
      case 'flying':
        color = AppColors.flyBlue;
        break;
      case 'ghost':
        color = AppColors.ghostPurple;
        break;
      case 'poison':
        color = AppColors.poisonPurple;
        break;
      case 'grass':
        color = AppColors.grassGreen;
        break;
      case 'fire':
        color = AppColors.fireRed;
        break;
      case 'water':
        color = AppColors.waterBlue;
        break;
      case 'electric':
        color = AppColors.electricYellow;
        break;
      case 'bug':
        color = AppColors.bugGreen;
        break;
      case 'psychic':
        color = AppColors.psychicPurple;
        break;
      case 'ground':
        color = AppColors.groundBrown;
        break;
      case 'fighting':
        color = AppColors.fightBrown;
        break;
      case 'normal':
        color = AppColors.normalGrey;
        break;
      default:
        color = AppColors.unknownGrey;
        break;
    }

    return Pokemon(
      color: color,
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
      sprites: sprites,
      stats: stats,
      weight: json['weight'],
    );
  }
}
