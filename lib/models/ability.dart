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
}
