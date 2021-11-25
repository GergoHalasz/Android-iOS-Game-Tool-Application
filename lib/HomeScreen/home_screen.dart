import 'package:flutter/material.dart';
import 'package:wowtalentcalculator/DetailsScreen/details_screen.dart';
import 'package:wowtalentcalculator/utils/colors.dart';
import 'package:wowtalentcalculator/utils/size_config.dart';
import 'package:wowtalentcalculator/ArrowWidgets/class_arrow_widget.dart';

/// Main Home Page, show for normal log in
class HomeScreen extends StatelessWidget {
  final Future<List> druidTalentTrees;

  HomeScreen({
    required this.druidTalentTrees,
  });

  /// open class talents
  handleOnTap(BuildContext context, String className, Future<List> talentTrees,
      Color classColor) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailScreen(
            className: className,
            talentTrees: talentTrees,
            classColor: classColor,
            arrowTrees: getArrowClassByName(className,'tbc')),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //home_screen is the first page render that can calculate screen size
    SizeConfig().init(context);

    return DetailScreen(
        className: 'druid',
        classColor: kColorDruid,
        talentTrees: druidTalentTrees,
        arrowTrees: getArrowClassByName('druid','tbc'));
  }
}
