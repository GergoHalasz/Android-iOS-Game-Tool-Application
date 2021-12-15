import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wowtalentcalculator/ad_state.dart';
import 'package:wowtalentcalculator/provider/talent_provider.dart';

class SaveScreen extends StatefulWidget {
  String buildName;
  String buildKey;
  Function changeBuildKeyAndName;
  Function changeBuildName;

  SaveScreen(
      {required this.buildName,
      required this.buildKey,
      required this.changeBuildKeyAndName,
      required this.changeBuildName});

  @override
  _SaveScreenState createState() => _SaveScreenState();
}

class _SaveScreenState extends State<SaveScreen> {
  late String buildName;
  late TextEditingController _controller;

  @override
  void didChangeDependencies() {
    final adState = Provider.of<AdState>(context);

    InterstitialAd.load(
        adUnitId: adState.interstitialAdUnitId,
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            adState.interstitialAd = ad;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error');
          },
        ));
    super.didChangeDependencies();
  }

  @override
  void initState() {
    buildName = widget.buildName;
    _controller = new TextEditingController();
    _controller.text = widget.buildName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var talentProvider = Provider.of<TalentProvider>(context);
    final adState = Provider.of<AdState>(context);

    Future<void> _saveBuild() async {
      final prefs = await SharedPreferences.getInstance();
      var data = talentProvider.talentTrees.toJson();
      Map dataJson = {
        "build": data,
        "buildName": buildName,
        "buildClass": talentProvider.className
      };

      var newKey = talentProvider.expansion == "tbc"
          ? 't' + "build_" + Guid.newGuid.toString()
          : 'v' + "build_" + Guid.newGuid.toString();
      await prefs.setString(widget.buildKey == "" ? newKey : widget.buildKey,
          jsonEncode(dataJson));
      if (widget.buildKey == "") {
        widget.changeBuildKeyAndName(newKey, buildName);
      } else {
        widget.changeBuildName(buildName);
      }
      talentProvider.changeBuildName(buildName);

      Navigator.pop(context);
      adState.interstitialAd?.show();
    }

    return Scaffold(
        backgroundColor: Colors.grey.shade700,
        appBar: AppBar(
            centerTitle: true,
            title: Text('Save Build'),
            backgroundColor: Colors.black,
            actions: <Widget>[
              Container(
                  padding: EdgeInsets.only(right: 15),
                  child: InkResponse(
                    child: Icon(
                      Icons.save,
                    ),
                    onTap: () {
                      _saveBuild();
                      FocusScope.of(context).unfocus();
                    },
                  )),
            ]),
        body: DefaultTextStyle(
            style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w900),
            child: Column(
              children: [
                Container(
                    padding: EdgeInsets.all(10),
                    child: Theme(
                      data: new ThemeData(
                        primaryColor: Colors.redAccent,
                        primaryColorDark: Colors.red,
                      ),
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
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
