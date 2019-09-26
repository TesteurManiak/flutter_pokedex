import 'package:flutter/material.dart';
import 'package:pokedex/utils/fetch_data.dart';

class Specie {
  String name;
  String url;
  int baseHappiness;
  int captureRate;
  String flavorText;

  Specie({@required this.name, @required this.url}) {
    PokeAPI().fetchSpecies(this);
  }

  factory Specie.fromJson(json) {
    return Specie(
      name: json['name'],
      url: json['url'],
    );
  }
}
