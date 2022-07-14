class ClassGlyphs {
  String? name;
  Glyphs? glyphs;

  ClassGlyphs({this.name, this.glyphs});

  ClassGlyphs.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    glyphs =
    json['Glyphs'] != null ? new Glyphs.fromJson(json['Glyphs']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    if (this.glyphs != null) {
      data['Glyphs'] = this.glyphs!.toJson();
    }
    return data;
  }
}

class Glyphs {
  Minor? minor;
  Minor? major;

  Glyphs({this.minor, this.major});

  Glyphs.fromJson(Map<String, dynamic> json) {
    minor = json['Minor'] != null ? new Minor.fromJson(json['Minor']) : null;
    major = json['Major'] != null ? new Minor.fromJson(json['Major']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.minor != null) {
      data['Minor'] = this.minor!.toJson();
    }
    if (this.major != null) {
      data['Major'] = this.major!.toJson();
    }
    return data;
  }
}

class Minor {
  List<Glyph>? glyph;

  Minor({this.glyph});

  Minor.fromJson(Map<String, dynamic> json) {
    if (json['Glyph'] != null) {
      glyph = <Glyph>[];
      json['Glyph'].forEach((v) {
        glyph!.add(new Glyph.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.glyph != null) {
      data['Glyph'] = this.glyph!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Glyph {
  String? id;
  String? name;
  String? rune;
  String? description;

  Glyph({this.id, this.name, this.rune, this.description});

  Glyph.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    rune = json['Rune'];
    description = json['Description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Name'] = this.name;
    data['Rune'] = this.rune;
    data['Description'] = this.description;
    return data;
  }
}
