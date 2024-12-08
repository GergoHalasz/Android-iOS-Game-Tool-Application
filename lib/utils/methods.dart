import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String> loadJson(String name, String expansion) async {
  return rootBundle.loadString('data_repo_$expansion/$name.json');
}

Future<List> loadTalentString(String name, String? expansion) async {
  if (expansion == 'start') {
    final prefs = await SharedPreferences.getInstance();

    expansion = prefs.getString('expansion');
    if (expansion == null) {
      expansion = 'vanilla';
      prefs.setString('expansion', 'vanilla');
    }
  }

  String jsonTalent = await loadJson(name, expansion!);
  final jsonResponse = json.decode(jsonTalent);
  return jsonResponse;
}

Future<String> getExpansion() async {
  String? expansion;
  final prefs = await SharedPreferences.getInstance();

  expansion = prefs.getString('expansion');
  expansion = 'vanilla';
  prefs.setString('expansion', 'vanilla');
  return expansion;
}
