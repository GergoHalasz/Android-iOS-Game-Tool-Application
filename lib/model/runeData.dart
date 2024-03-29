class RuneData {
  List<RuneType> chest;
  List<RuneType> waist;
  List<RuneType> legs;
  List<RuneType> feet;
  List<RuneType> hands;
  List<RuneType> headPhase3;
  List<RuneType> wristsPhase3;

  RuneData({
    required this.chest,
    required this.waist,
    required this.legs,
    required this.feet,
    required this.hands,
    required this.headPhase3,
    required this.wristsPhase3,
  });

  factory RuneData.fromJson(Map<String, dynamic> json) {
    return RuneData(
      chest: _parseRuneTypes(json['Chest']),
      waist: _parseRuneTypes(json['Waist']),
      legs: _parseRuneTypes(json['Legs']),
      feet: _parseRuneTypes(json['Feet']),
      hands: _parseRuneTypes(json['Hands']),
      headPhase3: _parseRuneTypes(json['Head_Phase_3']),
      wristsPhase3: _parseRuneTypes(json['Wrists_Phase_3']),
    );
  }

  static List<RuneType> _parseRuneTypes(List<dynamic> typesJson) {
    return typesJson.map((typeJson) => RuneType.fromJson(typeJson)).toList();
  }
}

class RuneType {
  String name;
  String description;
  String icon;

  RuneType({
    required this.name,
    required this.description,
    required this.icon,
  });

  factory RuneType.fromJson(Map<String, dynamic> json) {
    return RuneType(
      name: json['Name'],
      description: json['Description'],
      icon: json['icon'],
    );
  }
}