import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wowtalentcalculator/DetailsScreen/classes_screen.dart';
import 'package:wowtalentcalculator/utils/routestyle.dart';
import 'package:wowtalentcalculator/utils/size_config.dart';

class ExpansionsScreen extends StatefulWidget {
  const ExpansionsScreen({Key? key}) : super(key: key);

  @override
  State<ExpansionsScreen> createState() => _ExpansionsScreenState();
}

class _ExpansionsScreenState extends State<ExpansionsScreen> {
  List<String> expansions = ['vanilla', 'tbc', 'wotlk'];

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 10, right: 3.5),
        child: Stack(fit: StackFit.expand, children: [
          Container(
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage("assets/background/mage_fire.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ...expansions.map((element) {
                      return Container(
                          width: SizeConfig.cellSize / 1,
                          height: SizeConfig.cellSize / 1,
                          child: Material(
                            color: Colors.transparent,
                            child: Ink(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        AssetImage("assets/Class/$element.png"),
                                    fit: BoxFit.cover),
                              ),
                              child: Container(
                                child: InkWell(
                                  onTap: () async {
                                    // final prefs = await SharedPreferences.getInstance();
                                    // Navigator.pop(context);
                                    // loadInterstitialAd();

                                    // prefs.setString('expansion', currentExpansionSelected);
                                    // talentProvider.changeExpansion(
                                    //     currentExpansionSelected);
                                    // widget.changeClass(element);
                                    Navigator.push(
                                        context,
                                        buildPageRoute(
                                            ClassesScreen(expansion: element)));
                                  },
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ));
                    })
                  ])),
        ]));
  }
}
