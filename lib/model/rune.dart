class ClassRunes {
  String? name;
  Runes? runes;

  ClassRunes({this.name, this.runes});

  ClassRunes.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    runes = json['Runes'] != null ? new Runes.fromJson(json['Runes']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    if (this.runes != null) {
      data['Runes'] = this.runes!.toJson();
    }
    return data;
  }
}

class Runes {
  List<Chest>? chest;
  List<Waist>? waist;
  List<Legs>? legs;
  List<Feet>? feet;
  List<Hands>? hands;
  List<Head>? headPhase3;
  List<Wrists>? wristsPhase3;

  Runes(
      {this.chest,
      this.waist,
      this.legs,
      this.hands,
      this.headPhase3,
      this.wristsPhase3});

  Runes.fromJson(Map<String, dynamic> json) {
    if (json['Chest'] != null) {
      chest = <Chest>[];
      json['Chest'].forEach((v) {
        chest!.add(new Chest.fromJson(v));
      });
    }
    if (json['Waist'] != null) {
      waist = <Waist>[];
      json['Waist'].forEach((v) {
        waist!.add(new Waist.fromJson(v));
      });
    }
    if (json['Legs'] != null) {
      legs = <Legs>[];
      json['Legs'].forEach((v) {
        legs!.add(new Legs.fromJson(v));
      });
    }
    if (json['Feet'] != null) {
      feet = <Feet>[];
      json['Feet'].forEach((v) {
        feet!.add(new Feet.fromJson(v));
      });
    }
    if (json['Hands'] != null) {
      hands = <Hands>[];
      json['Hands'].forEach((v) {
        hands!.add(new Hands.fromJson(v));
      });
    }
    if (json['Head (Phase 3)'] != null) {
      headPhase3 = <Head>[];
      json['Head (Phase 3)'].forEach((v) {
        headPhase3!.add(new Head.fromJson(v));
      });
    }
    if (json['Wrists (Phase 3)'] != null) {
      wristsPhase3 = <Wrists>[];
      json['Wrists (Phase 3)'].forEach((v) {
        wristsPhase3!.add(new Wrists.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.chest != null) {
      data['Chest'] = this.chest!.map((v) => v.toJson()).toList();
    }
    if (this.waist != null) {
      data['Waist'] = this.waist!.map((v) => v.toJson()).toList();
    }
    if (this.legs != null) {
      data['Legs'] = this.legs!.map((v) => v.toJson()).toList();
    }
    if (this.feet != null) {
      data['Feet'] = this.feet!.map((v) => v.toJson()).toList();
    }
    if (this.hands != null) {
      data['Hands'] = this.hands!.map((v) => v.toJson()).toList();
    }
    if (this.headPhase3 != null) {
      data['Head (Phase 3)'] = this.headPhase3!.map((v) => v.toJson()).toList();
    }
    if (this.wristsPhase3 != null) {
      data['Wrists (Phase 3)'] =
          this.wristsPhase3!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Chest {
  String? name;
  String? description;
  String? icon;

  Chest({this.name, this.description, this.icon});

  Chest.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    description = json['Description'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['Description'] = this.description;
    data['icon'] = this.icon;
    return data;
  }
}

class Waist {
  String? name;
  String? description;
  String? icon;

  Waist({this.name, this.description, this.icon});

  Waist.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    description = json['Description'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['Description'] = this.description;
    data['icon'] = this.icon;
    return data;
  }
}

class Legs {
  String? name;
  String? description;
  String? icon;

  Legs({this.name, this.description, this.icon});

  Legs.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    description = json['Description'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['Description'] = this.description;
    data['icon'] = this.icon;
    return data;
  }
}

class Feet {
  String? name;
  String? description;
  String? icon;

  Feet({this.name, this.description, this.icon});

  Feet.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    description = json['Description'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['Description'] = this.description;
    data['icon'] = this.icon;
    return data;
  }
}

class Hands {
  String? name;
  String? description;
  String? icon;

  Hands({this.name, this.description, this.icon});

  Hands.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    description = json['Description'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['Description'] = this.description;
    data['icon'] = this.icon;
    return data;
  }
}

class Head {
  String? name;
  String? description;
  String? icon;

  Head({this.name, this.description, this.icon});

  Head.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    description = json['Description'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['Description'] = this.description;
    data['icon'] = this.icon;
    return data;
  }
}

class Wrists {
  String? name;
  String? description;
  String? icon;

  Wrists({this.name, this.description, this.icon});

  Wrists.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    description = json['Description'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['Description'] = this.description;
    data['icon'] = this.icon;
    return data;
  }
}
