class Ability {
  String name;
  String url;
  bool isHidden;
  int slot;

  Ability({
    this.name,
    this.url,
    this.isHidden,
    this.slot,
  });

  factory Ability.fromJson(Map<String, dynamic> json) {
    return Ability(
      name: json['ability']['name'],
      url: json['ability']['url'],
      isHidden: json['is_hidden'],
      slot: json['slot'],
    );
  }

  Map<String, dynamic> toJson() => _abilityToJson(this);

  _abilityToJson(Ability ability) {
    return {
      "ability": {
        "name": ability.name,
        "url": ability.url,
      },
      "is_hidden": ability.isHidden,
      "slot": ability.slot
    };
  }
}
