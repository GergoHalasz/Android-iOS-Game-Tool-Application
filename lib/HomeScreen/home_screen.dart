import 'package:flutter/material.dart';
import 'package:wowtalentcalculator/DetailsScreen/expansions_screen.dart';
import 'package:wowtalentcalculator/utils/colors.dart';
import 'package:wowtalentcalculator/utils/size_config.dart';
import 'package:wowtalentcalculator/ArrowWidgets/class_arrow_widget.dart';

/// Main Home Page, show for normal log in
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //home_screen is the first page render that can calculate screen size
    SizeConfig().init(context);

    return ExpansionsScreen();
  }
}
