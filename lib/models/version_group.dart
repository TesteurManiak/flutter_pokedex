class VersionGroup {
  String name;
  String url;

  VersionGroup(this.name, this.url);

  factory VersionGroup.fromJson(json) {
    return VersionGroup(json['name'], json['url']);
  }
}
