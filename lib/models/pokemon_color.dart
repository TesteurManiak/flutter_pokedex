import 'package:flutter/material.dart';

class PokeColor {
  String name;
  String url;

  PokeColor({@required this.name, @required this.url});

  factory PokeColor.fromJson(json) {
    return PokeColor(
      name: json['name'],
      url: json['url'],
    );
  }
}
