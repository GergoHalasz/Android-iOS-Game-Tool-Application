import 'package:flutter/material.dart';
import 'package:wow_talent_calculator/DetailsScreen/details_screen.dart';
import 'package:wow_talent_calculator/utils/colors.dart';
import 'package:wow_talent_calculator/utils/size_config.dart';

/// Main Home Page, show for normal log in
class HomeScreen extends StatelessWidget {
  final Future<List> druidTalentTrees;
  final Future<List> hunterTalentTrees;
  final Future<List> mageTalentTrees;
  final Future<List> paladinTalentTrees;
  final Future<List> priestTalentTrees;
  final Future<List> rogueTalentTrees;
  final Future<List> shamanTalentTrees;
  final Future<List> warlockTalentTrees;
  final Future<List> warriorTalentTrees;

  HomeScreen(
      {required this.druidTalentTrees,
      required this.hunterTalentTrees,
      required this.mageTalentTrees,
      required this.paladinTalentTrees,
      required this.priestTalentTrees,
      required this.rogueTalentTrees,
      required this.shamanTalentTrees,
      required this.warlockTalentTrees,
      required this.warriorTalentTrees});

  /// open class talents
  _handleOnTap(BuildContext context, String className, Future<List> talentTrees,
      Color classColor) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailScreen(
          className: className,
          talentTrees: talentTrees,
          classColor: classColor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //home_screen is the first page render that can calculate screen size
    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: kColorSelectiveYellow),
        title: Text(
          'Classic Talent Calculator',
          style: TextStyle(
            color: kColorSelectiveYellow,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        backgroundColor: kColorLightLicorice,
      ),
      body: ListView(
        children: <Widget>[
          GestureDetector(
            child: Container(
              width: 50,
              height: 50,
              color: Colors.black,
              child: Text(
                'asd',
                style: TextStyle(color: Colors.white),
              ),
            ),
            onTap: () => _handleOnTap(
                context, 'druid', druidTalentTrees, kColorOrangeDruid),
          )
        ],
      ),
    );
  }
}
