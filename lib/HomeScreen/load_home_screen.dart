import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home_screen.dart';

class LoadHomeScreen extends StatelessWidget {
  Future<String> loadJson(String name) async {
    return await rootBundle.loadString('data_repo/$name.json');
  }

  Future<List> loadTalentString(String name) async {
    String jsonTalent = await loadJson(name);
    final jsonResponse = json.decode(jsonTalent);
    return jsonResponse;
  }

  @override
  Widget build(BuildContext context) {
    return HomeScreen(
      druidTalentTrees: loadTalentString('druid'),
      hunterTalentTrees: loadTalentString('hunter'),
      mageTalentTrees: loadTalentString('mage'),
      paladinTalentTrees: loadTalentString('paladin'),
      priestTalentTrees: loadTalentString('priest'),
      rogueTalentTrees: loadTalentString('rogue'),
      shamanTalentTrees: loadTalentString('shaman'),
      warlockTalentTrees: loadTalentString('warlock'),
      warriorTalentTrees: loadTalentString('warrior'),
    );
  }
}
