import 'package:flutter/material.dart';
import 'dart:async' show Future;
import 'package:provider/provider.dart';
import 'package:wow_talent_calculator/DetailsScreen/detail_screen_content.dart';
import 'package:wow_talent_calculator/DetailsScreen/talent_tree_widget.dart';
import 'package:wow_talent_calculator/model/talent.dart';
import 'package:wow_talent_calculator/provider/talent_provider.dart';

class DetailScreen extends StatelessWidget {
  final String className;
  final Color classColor;
  final Future<List> talentTrees;
  DetailScreen(
      {required this.className,
      required this.classColor,
      required this.talentTrees});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
      future: talentTrees,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          /// make new talent object every time we go to detail view
          TalentTrees talentTreesObject =
              TalentTrees.fromJson(snapshot.data ?? []);
          return ChangeNotifierProvider<TalentProvider>(
              create: (_) => TalentProvider(talentTreesObject),
              child: DetailScreenContent(
                talentTrees: talentTreesObject,
                className: className,
                classColor: classColor,
              ));
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        // By default, show a loading spinner.
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
