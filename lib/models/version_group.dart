class VersionGroup {
  String name;
  String url;

  VersionGroup(this.name, this.url);

  factory VersionGroup.fromJson(json) {
    return VersionGroup(json['name'], json['url']);
  }

  Map<String, dynamic> toJson() => _versionGroupToJson(this);

  _versionGroupToJson(VersionGroup versionGroup) {
    return {"name": versionGroup.name, "url": versionGroup.url};
  }
}
