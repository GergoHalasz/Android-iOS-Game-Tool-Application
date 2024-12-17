import 'package:flutter/material.dart';
import 'package:wowtalentcalculator/ArrowWidgets/class_arrow_widget.dart';
import 'package:wowtalentcalculator/DetailsScreen/details_screen.dart';
import 'package:wowtalentcalculator/DetailsScreen/expansions_screen.dart';
import 'package:wowtalentcalculator/utils/colors.dart';
import 'package:wowtalentcalculator/utils/size_config.dart';

/// Main Home Page, show for normal log in
class HomeScreen extends StatelessWidget {
  final Future<List> druidTalentTrees;
  final Future<String> expansion;

  HomeScreen({required this.druidTalentTrees, required this.expansion});

  @override
  Widget build(BuildContext context) {
    //home_screen is the first page render that can calculate screen size

    return FutureBuilder(
        future: expansion,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return DetailScreen(
                expansion: snapshot.data as String,
                className: 'druid',
                classColor: kColorDruid,
                talentTrees: druidTalentTrees,
                arrowTrees: getArrowClassByName('druid', snapshot.data as String));
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}
