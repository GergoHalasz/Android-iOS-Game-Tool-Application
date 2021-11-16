import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wowtalentcalculator/provider/talent_provider.dart';
import 'package:wowtalentcalculator/utils/colors.dart';
import 'package:wowtalentcalculator/utils/string.dart';

class DrawerScreen extends StatefulWidget {
  Function changeClass;

  DrawerScreen({required this.changeClass});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  bool isOpen = false;
  List<String> classes = [
    'druid',
    'hunter',
    'mage',
    'paladin',
    'priest',
    'rogue',
    'shaman',
    'warlock',
    'warrior'
  ];
  @override
  Widget build(BuildContext context) {

    return Material(
      color: Colors.grey.shade800,
      child: DefaultTextStyle(
        style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w500),
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 15, left: 15),
              child: Text('Builds'),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(color: Colors.white12, height: 0),
            Theme(
                data: Theme.of(context).copyWith(dividerColor: Colors.white12),
                child: ExpansionTile(
                  collapsedIconColor: Colors.white,
                  title: Text('New Builds',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w500)),
                  children: [
                    ...classes.map((element) {
                      return Column(
                        children: [
                          ListTile(
                            onTap: () {
                              widget.changeClass(element);
                            },
                            dense: true,
                            title: Text(
                              capitalize(element),
                              style: TextStyle(color: classColors[element]),
                            ),
                            leading: CircleAvatar(
                              backgroundImage:
                                  AssetImage("assets/Class/icon_$element.png"),
                              backgroundColor: Colors.transparent,
                            ),
                          ),
                          Divider(color: Colors.white12, height: 0)
                        ],
                      );
                    }),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
