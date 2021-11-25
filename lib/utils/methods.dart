import 'dart:convert';

import 'package:flutter/services.dart';

Future<String> loadJson(String name, String expansion) async {
  return await rootBundle.loadString('data_repo_$expansion/$name.json');
}

Future<List> loadTalentString(String name, String expansion) async {
  String jsonTalent = await loadJson(name, expansion);
  final jsonResponse = json.decode(jsonTalent);
  return jsonResponse;
}
