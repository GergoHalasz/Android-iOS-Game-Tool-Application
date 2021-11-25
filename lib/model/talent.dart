class TalentTrees {
  late List<TalentTree> specTreeList;

  TalentTrees({
    required this.specTreeList,
  });

  TalentTrees.fromJson(List<dynamic> parsedJson) {
    specTreeList = parsedJson.map((i) => TalentTree.fromJson(i)).toList();
  }

  List<Map<String, dynamic>> toJson() {
    var map1 = specTreeList.map((e) => e.toJson()).toList();
    return map1;
  }
}

class TalentTree {
  late String name;
  late String icon;
  late String background;
  late int points;
  late Talents talents;

  TalentTree(
      {required this.name,
      required this.icon,
      required this.background,
      required this.points,
      required this.talents});

  TalentTree.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    icon = json['Icon'];
    background = json['Background'];
    points = json['Points'];
    talents = Talents.fromJson(json['Talents']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['Name'] = name;
    data['Icon'] = icon;
    data['Background'] = background;
    data['Points'] = points;
    data['Talents'] = talents.toJson();
    return data;
  }
}

class Talents {
  List<Talent> talentList = [];

  Talents({required this.talentList});

  Talents.fromJson(Map<String, dynamic> json) {
    json['Talent'].forEach((v) {
      talentList.add(Talent.fromJson(v));
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['Talent'] = talentList.map((v) => v.toJson()).toList();
    return data;
  }
}

class Talent {
  late String icon;
  late String name;
  late int points;
  late String dependency;
  late List<String> support;
  late List<int> position;
  late bool enable;
  late int tier;
  late Ranks ranks;

  Talent(
      {required this.icon,
      required this.name,
      required this.points,
      required this.dependency,
      required this.support,
      required this.position,
      required this.enable,
      required this.tier,
      required this.ranks});

  Talent.fromJson(Map<String, dynamic> json) {
    icon = json['Icon'];
    name = json['Name'];
    points = json['Points'];
    dependency = json['Dependency'];
    support = json['Support'].cast<String>();
    position = json['Position'].cast<int>();
    enable = json['Enable'];
    tier = json['Tier'] is String ? int.parse(json['Tier']) : json['Tier'];
    ranks = Ranks.fromJson(json['Ranks']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['Icon'] = icon;
    data['Name'] = name;
    data['Points'] = points;
    data['Dependency'] = dependency;
    data['Support'] = support;
    data['Position'] = position;
    data['Enable'] = enable;
    data['Tier'] = tier;
    data['Ranks'] = ranks.toJson();

    return data;
  }
}

class Ranks {
  List<Rank> rankList = [];

  Ranks({required this.rankList});

  Ranks.fromJson(Map<String, dynamic> json) {
    json['Rank'].forEach((v) {
      rankList.add(Rank.fromJson(v));
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Rank'] = rankList.map((v) => v.toJson()).toList();
    return data;
  }
}

class Rank {
  late int number;
  late String description;

  Rank({required this.number, required this.description});

  Rank.fromJson(Map<String, dynamic> json) {
    number =
        json["Number"] is String ? int.parse(json['Number']) : json['Number'];
    description = json['Description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['Number'] = number;
    data['Description'] = description;
    return data;
  }
}
