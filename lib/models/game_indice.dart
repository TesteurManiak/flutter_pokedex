class GameIndice {
  int gameIndex;
  String name;
  String url;

  GameIndice(this.gameIndex, this.name, this.url);

  factory GameIndice.fromJson(json) {
    return GameIndice(
      json['game_index'],
      json['version']['name'],
      json['version']['url'],
    );
  }

  Map<String, dynamic> toJson() => _indiceToJson(this);

  _indiceToJson(GameIndice gameIndice) {
    return {
      "game_index": gameIndice.gameIndex,
      "version": {"name": gameIndice.name, "url": gameIndice.url}
    };
  }
}
