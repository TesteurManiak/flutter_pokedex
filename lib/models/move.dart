import 'package:pokedex/models/version_group.dart';

class MoveLearnMethod {
  String name;
  String url;

  MoveLearnMethod(this.name, this.url);

  factory MoveLearnMethod.fromJson(json) {
    return MoveLearnMethod(json['name'], json['url']);
  }
}

class VersionGroupDetail {
  int levelLearnedAt;
  MoveLearnMethod moveLearnMethod;
  VersionGroup versionGroup;

  VersionGroupDetail(
    this.levelLearnedAt,
    this.moveLearnMethod,
    this.versionGroup,
  );

  factory VersionGroupDetail.fromJson(json) {
    return VersionGroupDetail(
      json['level_learned_at'],
      MoveLearnMethod.fromJson(json['move_learn_method']),
      VersionGroup.fromJson(json['version_group']),
    );
  }
}

class Move {
  String name;
  String url;
  int accuracy;

  Move(this.name, this.url);

  factory Move.fromJson(json) {
    return Move(json['move']['name'], json['move']['url']);
  }
}
