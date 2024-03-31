import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wowtalentcalculator/DetailsScreen/runedetails_dialog.dart';
import 'package:wowtalentcalculator/provider/talent_provider.dart';

class RuneWidget extends StatefulWidget {
  final dynamic runes;
  final String type;

  const RuneWidget({Key? key, required this.runes, required this.type})
      : super(key: key);

  @override
  State<RuneWidget> createState() => _RuneWidgetState();
}

class _RuneWidgetState extends State<RuneWidget> {
  late TalentProvider talentProvider;
  String imgLocation = 'assets/Icons/inventoryslot_empty.png';

  @override
  Widget build(BuildContext context) {
    talentProvider = Provider.of<TalentProvider>(context);
    dynamic selectedRune = talentProvider.selectedRunes.length != 0
        ? talentProvider.selectedRunes.firstWhere(
            (rune) => rune["type"] == widget.type,
            orElse: () => null,
          )
        : null;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Material(
        color: Colors.transparent,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Ink(
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 177, 177, 177),
                  image: DecorationImage(
                      image: AssetImage(selectedRune == null
                          ? imgLocation
                          : 'assets/Icons/${selectedRune["rune"].icon}.png'),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(10)),
              child: Container(
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.shade700,
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(10)),
                child: InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return ChangeNotifierProvider<TalentProvider>.value(
                              value: talentProvider,
                              child: RuneDetailsDialog(
                                type: widget.type,
                                runes: widget.runes,
                              ));
                        });
                  },
                  onLongPress: () => {},
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(left: 16),
                child: Text(
                 selectedRune == null? widget.type: selectedRune["rune"].name,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ))
          ],
        ),
      ),
    );
    ;
  }
}
