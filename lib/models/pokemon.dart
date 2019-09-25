import 'package:flutter/material.dart';
import 'package:pokedex/configs/AppColors.dart';

class Pokemon {
  const Pokemon({
    @required this.name,
    this.types = const [],
    @required this.image,
    @required this.color,
    @required this.id,
  });

  final Color color;
  final String image;
  final String name;
  final List<String> types;
  final int id;

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    List<String> types = [];

    json['types'].forEach((type) {
      types.add(type['type']['name']);
    });

    return Pokemon(
      color: AppColors.lightTeal,
      image: json['sprites']['front_default'],
      name: json['name'],
      types: types,
      id: json['id'],
    );
  }
}
