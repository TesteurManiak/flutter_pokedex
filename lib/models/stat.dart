class Stat {
  int baseStat;
  int effort;
  String name;
  String url;

  Stat({this.baseStat, this.effort, this.name, this.url});

  factory Stat.fromJson(json) {
    return Stat(
      baseStat: json['base_stat'],
      effort: json['effort'],
      name: json['stat']['name'],
      url: json['stat']['url'],
    );
  }
}
