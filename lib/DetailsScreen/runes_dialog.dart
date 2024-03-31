import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wowtalentcalculator/DetailsScreen/rune_widget.dart';
import 'package:wowtalentcalculator/model/rune.dart';
import 'package:wowtalentcalculator/provider/talent_provider.dart';

class RunesDialog extends StatefulWidget {
  const RunesDialog({Key? key}) : super(key: key);

  @override
  _RunesDialogState createState() => _RunesDialogState();
}

class _RunesDialogState extends State<RunesDialog> {
  late TalentProvider talentProvider;
  List<String> runeTypes = [
    "Chest",
    "Waist",
    "Legs",
    "Feet",
    "Hands",
    "Head",
    "Wrists"
  ];
  late ClassRunes classRunes;

  @override
  Widget build(BuildContext context) {
    talentProvider = Provider.of<TalentProvider>(context);
    classRunes = talentProvider.classRunes.firstWhere(
        (element) => element.name!.toLowerCase() == talentProvider.className);

    return AlertDialog(
      title: Text(
        'Runes',
        style: TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.black,
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ...runeTypes.map(
            (runeType) {
              switch (runeType) {
                case "Chest":
                  return RuneWidget(
                    runes: classRunes.runes!.chest,
                    type: "Chest",
                  );
                case "Waist":
                  return RuneWidget(
                    runes: classRunes.runes!.waist,
                    type: "Waist",
                  );
                case "Legs":
                  return RuneWidget(
                    runes: classRunes.runes!.legs,
                    type: "Legs",
                  );
                case "Feet":
                  return RuneWidget(
                    runes: classRunes.runes!.feet,
                    type: "Feet",
                  );
                case "Hands":
                  return RuneWidget(
                    runes: classRunes.runes!.hands,
                    type: "Hands",
                  );
                case "Head":
                  return RuneWidget(
                    runes: classRunes.runes!.headPhase3,
                    type: "Head",
                  );
                case "Wrists":
                  return RuneWidget(
                    runes: classRunes.runes!.wristsPhase3,
                    type: "Wrists",
                  );
                default:
                  return Container();
              }
            },
          )
        ],
      ),
    );
  }
}
