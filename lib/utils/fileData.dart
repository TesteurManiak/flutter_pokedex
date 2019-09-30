import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:pokedex/data/pokemons.dart';
import 'package:pokedex/models/pokemon.dart';

/// Find local path
Future<String> get localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

/// Reference to file location
Future<File> localFile(String id) async {
  final path = await localPath;
  return File('$path/$id.json');
}

/// Write data to JSON
Future<File> writeJson(String json, String id) async {
  final file = await localFile(id);
  return file.writeAsString(json);
}

/// Read json from file
Future<String> readPkmnFile(String id) async {
  try {
    final file = await localFile(id);
    String contents = await file.readAsString();
    return contents;
  } catch (e) {
    return null;
  }
}

Future loadAllSavedPkmn() async {
  for (int i = 1; i < pkmnCount; i++) {
    var myFile = await localFile(i.toString());
    if ((await myFile.exists())) {
      String content = await readPkmnFile(i.toString());
      var json = jsonDecode(content);
      pokemons.add(Pokemon.fromJson(json));
    } else {
      return;
    }
  }
}
