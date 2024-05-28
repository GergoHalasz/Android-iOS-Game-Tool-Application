import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wowtalentcalculator/ad_state.dart';
import 'package:wowtalentcalculator/api/purchase_api.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  bool isOpen = false;
  List builds = [];
  Future<List> _getSavedBuilds() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> keys = prefs.getKeys().toList();
    return keys.map((key) {
      if (key.contains("build_"))
        return {"build": jsonDecode(prefs.getString(key)!), "key": key};
    }).toList();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _getSavedBuilds().then((res) => {
          setState(() {
            builds = res;
          })
        });
    super.initState();
  }

  Widget stackBehindDismiss() {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 20.0),
      color: Colors.red,
      child: Icon(
        Icons.delete,
        color: Colors.white,
      ),
    );
  }

  onDeleteBuild(buildContext, key) async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    sharedPreference.remove(key);
    _getSavedBuilds().then((res) => {
          setState(() {
            builds = res;
          })
        });
  }

  String _termsUrl =
      'https://github.com/HalaszGergo123/wow-talent-calculator/blob/main/terms_and_conditions.md';
  String _privacyUrl =
      'https://github.com/HalaszGergo123/wow-talent-calculator/blob/main/privacy_policy.md';

  @override
  Widget build(BuildContext context) {
    final adState = Provider.of<AdState>(context);

    return Material(
      color: Color(0xff556F7A),
      child: DefaultTextStyle(
        style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w500),
        child: ListView(
          children: [
            SizedBox(
              height: 10,
            ),
            ListTile(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: new Text("Classic Talent Calculator"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            RichText(
                                text: TextSpan(
                              style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                TextSpan(
                                  text:
                                      "Copyright 2024 Halasz Gergo.All rights reserved.\n\nLogo and store icons created using Icons8 icons are based on remasterings by warcrafttavern.com\n\n",
                                ),
                                TextSpan(
                                  text:
                                      "This application is not affiliated with Blizzard Entertainment® or World of Warcraft in any way. All the World of Warcraft texts, logos, images and trademarks are property of Blizzard Entertainment® and are used according to community guidelines.World of Warcraft, Warcraft and Blizzard Entertainment are trademarks or registered trademarks of Blizzard Entertainment, Inc. in the U.S. and/or other countries.",
                                  style: TextStyle(fontSize: 13),
                                )
                              ],
                            )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  child: Text(
                                    'Privacy Policy',
                                    style: TextStyle(
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline,
                                        fontSize: 13),
                                  ),
                                  onTap: () {
                                    launch(_privacyUrl);
                                  },
                                ),
                                InkWell(
                                  child: Text(
                                    'Terms and Conditions',
                                    style: TextStyle(
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline,
                                        fontSize: 13),
                                  ),
                                  onTap: () {
                                    launch(_termsUrl);
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    });
              },
              leading: Icon(Icons.info, color: Colors.white),
              title: Text(
                'About',
                style: TextStyle(color: Colors.white),
              ),
            ),
            if (!adState.isAdFreeVersion)
              Divider(color: Colors.white12, height: 0),
            if (!adState.isAdFreeVersion)
              ListTile(
                leading: Icon(Icons.not_interested, color: Colors.white),
                title: Text(
                  'Remove Ads',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () async {
                  final adState = Provider.of<AdState>(context, listen: false);
                  if (!adState.isAdFreeVersion) {
                    final offerings = await PurchaseApi.fetchOffers();
                    final isSuccess = await Purchases.purchasePackage(
                        offerings[0].availablePackages[0]);
                    if (isSuccess.allPurchasedProductIdentifiers.length == 1) {
                      adState.changeToAdFreeVersion();
                    }
                  }
                },
              ),
            Divider(color: Colors.white12, height: 1),
            ListTile(
              leading:
                  Icon(Icons.replay_circle_filled_sharp, color: Colors.white),
              title: Text(
                'Restore Purchases',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () async {
                try {
                  final adState = Provider.of<AdState>(context, listen: false);
                  if (!adState.isAdFreeVersion) {
                    CustomerInfo restoredInfo =
                        await Purchases.restorePurchases();
                    if (restoredInfo.allPurchasedProductIdentifiers.length >
                            0 &&
                        (restoredInfo.allPurchasedProductIdentifiers[0] ==
                                "wowtc_ad_free_version" ||
                            restoredInfo.allPurchasedProductIdentifiers[0] ==
                                "123456")) {
                      adState.changeToAdFreeVersion();
                    } else {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: new Text("Restore Purchases"),
                              content: Text(
                                  "Please sign in with your Google/Apple account you did the purchase."),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('OK'))
                              ],
                            );
                          });
                    }
                  }
                  // ... check restored purchaserInfo to see if entitlement is now active
                } on PlatformException catch (e) {
                  print(e);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
