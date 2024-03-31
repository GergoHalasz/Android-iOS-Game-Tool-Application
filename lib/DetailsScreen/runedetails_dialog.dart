import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:wowtalentcalculator/provider/talent_provider.dart';
import 'package:wowtalentcalculator/utils/size_config.dart';

class RuneDetailsDialog extends StatefulWidget {
  final dynamic runes;
  final String type;

  const RuneDetailsDialog({Key? key, required this.runes, required this.type})
      : super(key: key);

  @override
  State<RuneDetailsDialog> createState() => _RuneDetailsDialogState();
}

class _RuneDetailsDialogState extends State<RuneDetailsDialog> {
  late TalentProvider talentProvider;

  @override
  Widget build(BuildContext context) {
    talentProvider = Provider.of<TalentProvider>(context);

    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${widget.type} Runes',
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          InkResponse(
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
            onTap: () {
              talentProvider.deleteSelectedRunes(widget.type);
              Navigator.pop(context);
            },
          ),
        ],
      ),
      backgroundColor: Colors.black,
      content: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Long tap on rune to see the description",
            style: TextStyle(color: Colors.white),
          ),
          ...widget.runes.map((rune) {
            return Column(
              children: [
                Divider(
                  thickness: 0.2,
                ),
                Tooltip(
                    padding: EdgeInsets.all(6),
                    showDuration: Duration(seconds: 10),
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    message: rune.description,
                    child: Material(
                      color: Colors.transparent,
                      child: Ink(
                        child: InkWell(
                          onTap: () {
                            talentProvider.setSelectedRunes(rune, widget.type);
                            Navigator.pop(context);
                          },
                          child: Row(
                            children: [
                              Image.asset("assets/Icons/${rune.icon}.png"),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  rune.name,
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )),
              ],
            );
          })
        ],
      ),
    );
    ;
  }
}
