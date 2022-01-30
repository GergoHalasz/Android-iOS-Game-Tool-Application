import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wowtalentcalculator/ad_state.dart';
import 'package:wowtalentcalculator/api/purchase_api.dart';
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
  bool isTextEmpty = false;

  @override
  void didChangeDependencies() {
    final adState = Provider.of<AdState>(context);
    if (adState.interstitialAd == null && !adState.isAdFreeVersion) {
      adState.createInterstitialAd();
    }
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
      if (_controller.text != "") {
        if (!adState.isAdFreeVersion) {
          adState.interstitialAd?.show();
          adState.interstitialAd?.dispose();
          adState.createInterstitialAd();
        }
        final prefs = await SharedPreferences.getInstance();
        var data = talentProvider.talentTrees.toJson();
        Map dataJson = {
          "build": data,
          "buildName": buildName,
          "buildClass": talentProvider.className
        };

        var newKey;
        if (talentProvider.expansion == 'wotlk') {
          newKey = 'w' + "build_" + Guid.newGuid.toString();
        } else {
          newKey = talentProvider.expansion == "tbc"
              ? 't' + "build_" + Guid.newGuid.toString()
              : 'v' + "build_" + Guid.newGuid.toString();
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

    return Scaffold(
        backgroundColor: Color(0xff556F7A),
        appBar: AppBar(
            centerTitle: true,
            title: Text('Save Build'),
            backgroundColor: Color(0xff2E6171),
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
            child: SafeArea(
              child: Stack(children: [
                Column(
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
                              errorStyle: TextStyle(color: Colors.red[600], fontSize: 14),
                              errorText: isTextEmpty ? "Value Can't Be Empty" : null,
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
                ),
                SizedBox(
                  height: 100,
                ),
                if (!adState.isAdFreeVersion)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 100),
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text('Support me by removing the ads! :)')),
                  ),
                if (!adState.isAdFreeVersion)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        width: 300,
                        child: ListTile(
                          leading:
                              Icon(Icons.not_interested, color: Colors.white),
                          title: Text(
                            'Remove Ads',
                            style: TextStyle(color: Colors.white),
                          ),
                          onTap: () async {
                            if (!adState.isAdFreeVersion) {
                              final offerings = await PurchaseApi.fetchOffers();
                              final isSuccess = await Purchases.purchasePackage(
                                  offerings[0].availablePackages[0]);
                              if (isSuccess == true) {
                                adState.changeToAdFreeVersion();
                              }
                            }
                          },
                        ),
                      ),
                    ),
                  ),
              ]),
            )));
  }
}
