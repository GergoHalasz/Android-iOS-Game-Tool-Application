import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String> loadJson(String name, String expansion) async {
  return rootBundle.loadString('data_repo_$expansion/$name.json');
}

Future<List> loadTalentString(String name, String? expansion) async {
  if (expansion == 'start') {
    final prefs = await SharedPreferences.getInstance();
  }

  String jsonTalent = await loadJson(name, expansion!);
  final jsonResponse = json.decode(jsonTalent);
  return jsonResponse;
}
