import 'package:flutter/material.dart';
import 'dart:async' show Future, Timer;
import 'package:provider/provider.dart';
import 'package:wowtalentcalculator/DetailsScreen/detail_screen_content.dart';
import 'package:wowtalentcalculator/DetailsScreen/talent_tree_widget.dart';
import 'package:wowtalentcalculator/model/talent.dart';
import 'package:wowtalentcalculator/provider/talent_provider.dart';

class DetailScreen extends StatefulWidget {
  final String className;
  final Color classColor;
  final Future<List> talentTrees;
  final List arrowTrees;
  final String expansion;

  DetailScreen(
      {required this.className,
      required this.classColor,
      required this.talentTrees,
      required this.arrowTrees,
      required this.expansion
      });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
      future: widget.talentTrees,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          /// make new talent object every time we go to detail view
          TalentTrees talentTreesObject =
              TalentTrees.fromJson(snapshot.data ?? []);
          talentTreesObject.specTreeList.forEach((talentList) => {
                precacheImage(
                    AssetImage(
                        'assets/background/${talentList.background}.png'),
                    context)
              });

          return ChangeNotifierProvider<TalentProvider>(
              create: (_) {
                return TalentProvider(
                    talentTreesObject, widget.className, widget.expansion, []);
              },
              child: DetailScreenContent(
                talentTrees: talentTreesObject,
                className: widget.className,
                classColor: widget.classColor,
                arrowTrees: widget.arrowTrees,
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
