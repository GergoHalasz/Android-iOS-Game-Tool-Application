import 'dart:convert';

import 'package:flutter/services.dart';

Future<String> loadJson(String name) async {
  return await rootBundle.loadString('data_repo/$name.json');
}

Future<List> loadTalentString(String name) async {
  String jsonTalent = await loadJson(name);
  final jsonResponse = json.decode(jsonTalent);
  return jsonResponse;
}
