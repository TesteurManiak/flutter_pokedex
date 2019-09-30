import 'package:flutter/material.dart';
import 'package:pokedex/data/pokemons.dart';
import 'package:pokedex/utils/fetch_data.dart';

class EggGroup {
  String name;
  String url;

  EggGroup(this.name, this.url);

  factory EggGroup.fromJson(json) {
    return EggGroup(json['name'], json['url']);
  }
}

class Specie {
  String name;
  String url;
  int baseHappiness;
  int captureRate;
  String flavorText;
  String genus;
  List<EggGroup> eggGroups;
  int femaleRate;

  Specie({@required this.name, @required this.url});

  factory Specie.fromJson(json) {
    return Specie(
      name: json['name'],
      url: json['url'],
    );
  }
}
