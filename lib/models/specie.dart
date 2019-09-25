class Specie {
  String name;
  String url;

  Specie(this.name, this.url);

  factory Specie.fromJson(json) {
    return Specie(json['name'], json['url']);
  }
}
