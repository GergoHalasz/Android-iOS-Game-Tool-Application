import 'package:flutter/material.dart';
import 'package:wowtalentcalculator/DetailsScreen/details_screen.dart';
import 'package:wowtalentcalculator/utils/colors.dart';
import 'package:wowtalentcalculator/utils/size_config.dart';

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

    return DetailScreen(
        className: 'druid',
        classColor: kColorOrangeDruid,
        talentTrees: druidTalentTrees);
  }
}
