import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:provider/provider.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wowtalentcalculator/ad_manager.dart';
import 'package:wowtalentcalculator/ad_state.dart';
import 'package:wowtalentcalculator/api/purchase_api.dart';
import 'package:wowtalentcalculator/provider/talent_provider.dart';

class SaveScreen extends StatefulWidget {
  String buildName;
  String buildKey;
  Function changeBuildKeyAndName;
  Function changeBuildName;
  bool isGlyphSet;

  SaveScreen(
      {required this.buildName,
      required this.buildKey,
      required this.changeBuildKeyAndName,
      required this.changeBuildName,
      required this.isGlyphSet});

  @override
  _SaveScreenState createState() => _SaveScreenState();
}

class _SaveScreenState extends State<SaveScreen> {
  late String buildName;
  late TextEditingController _controller;
  bool isTextEmpty = false;

  @override
  void initState() {
    buildName = widget.buildName;
    _controller = new TextEditingController(text: widget.buildName);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var talentProvider = Provider.of<TalentProvider>(context);
    final adState = Provider.of<AdState>(context);

    Future<void> _saveBuild() async {
      if (_controller.text != "") {
        adState.checkIfCanShowAd(AdManager.interstitialVideoAdPlacementId, true);
        final prefs = await SharedPreferences.getInstance();
        var data = talentProvider.talentTrees.toJson();
        Map dataJson = {
          "build": data,
          "buildName": buildName,
          "buildClass": talentProvider.className,
          "minorGlyphs": talentProvider.minorGlyphs,
          "majorGlyphs": talentProvider.majorGlyphs,
          "selectedRunes": talentProvider.selectedRunes
        };

        String guid = Guid.newGuid.toString();

        var newKey;
        if (talentProvider.expansion == 'cata') {
          int buildNumber =
              prefs.getKeys().where((key) => key.startsWith('c')).length;
          buildNumber++;
          newKey = 'c' + "build_" + buildNumber.toString();
        } else if (talentProvider.expansion == 'wotlk') {
          int buildNumber =
              prefs.getKeys().where((key) => key.startsWith('w')).length;
          buildNumber++;
          newKey = 'w' + "build_" + buildNumber.toString();
        } else if (talentProvider.expansion == "tbc") {
          int buildNumber =
              prefs.getKeys().where((key) => key.startsWith('t')).length;
          buildNumber++;
          newKey = 't' + "build_" + buildNumber.toString();
        } else if (talentProvider.expansion == "vanilla") {
          int buildNumber =
              prefs.getKeys().where((key) => key.startsWith('v')).length;
          buildNumber++;
          newKey = 'v' + "build_" + buildNumber.toString();
        }
        await prefs.setString(widget.buildKey == "" ? newKey : widget.buildKey,
            jsonEncode(dataJson));

        if (widget.buildKey == "") {
          widget.changeBuildKeyAndName(newKey, buildName);
        } else {
          widget.changeBuildName(buildName);
        }
        talentProvider.changeBuildName(buildName);
        Navigator.pop(context);
      } else {
        setState(() {
          isTextEmpty = true;
        });
      }
    }

    return AlertDialog(
        backgroundColor: Color(0xff556F7A),
        title: new Text(
          'Save Build',
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
        actions: [
          TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Color(0xff2E6171),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.white),
              )),
          TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Color(0xff2E6171),
              ),
              onPressed: () {
                _saveBuild();
              },
              child: const Text(
                'Save',
                style: TextStyle(color: Colors.white),
              )),
        ],
        content: DefaultTextStyle(
            style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w900),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    padding: EdgeInsets.all(10),
                    child: Theme(
                      data: new ThemeData(
                        primaryColor: Colors.redAccent,
                        primaryColorDark: Colors.red,
                      ),
                      child: TextField(
                        autofocus: true,
                        controller: _controller,
                        decoration: InputDecoration(
                          errorStyle:
                              TextStyle(color: Colors.red[600], fontSize: 14),
                          errorText:
                              isTextEmpty ? "Build Name Can't Be Empty" : null,
                          counterStyle: TextStyle(color: Colors.white),
                          labelText: 'Name',
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 0.0),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        maxLength: 25,
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w900),
                        onChanged: (text) {
                          buildName = text;
                        },
                      ),
                    )),
              ],
            )));
  }
}
