import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wowtalentcalculator/DetailsScreen/glyph_dialog.dart';
import 'package:wowtalentcalculator/DetailsScreen/glyph_widget.dart';
import 'package:wowtalentcalculator/model/glyph.dart';

import '../provider/talent_provider.dart';

class GlyphsScreen extends StatefulWidget {
  final ClassGlyphs classGlyphs;

  const GlyphsScreen({Key? key, required this.classGlyphs}) : super(key: key);

  @override
  State<GlyphsScreen> createState() => _GlyphsScreenState();
}

class _GlyphsScreenState extends State<GlyphsScreen> {
  String imgLocation = '';
  List majorGlyphs = [null, null, null];
  List minorGlyphs = [null, null, null];
  late List<Glyph> allMinorGlyphs;
  late List<Glyph> allMajorGlyphs;
  late TalentProvider talentProvider;

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    talentProvider = Provider.of<TalentProvider>(context);
    majorGlyphs = talentProvider.majorGlyphs;
    minorGlyphs = talentProvider.minorGlyphs;
    allMajorGlyphs =
        [...widget.classGlyphs.glyphs!.major!.glyph!].where((glyph) {
      bool isNotSelected = true;
      majorGlyphs.forEach((element) {
        if (element != null && element.name == glyph.name) {
          isNotSelected = false;
        }
      });
      return isNotSelected;
    }).toList();

    allMinorGlyphs =
        [...widget.classGlyphs.glyphs!.minor!.glyph!].where((glyph) {
      bool isNotSelected = true;
      minorGlyphs.forEach((element) {
        if (element != null && element.name == glyph.name) {
          isNotSelected = false;
        }
      });
      return isNotSelected;
    }).toList();

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    talentProvider.setGlyphs(
        talentProvider.minorGlyphs, talentProvider.majorGlyphs);
  }

  @override
  Widget build(BuildContext context) {
    ClassGlyphs classGlyphs = widget.classGlyphs;
    talentProvider = Provider.of<TalentProvider>(context);

    onGlyphSelected(int index, bool isMajorGlyph, Glyph glyph) {
      print(glyph);
      setState(() {
        if (isMajorGlyph) {
          majorGlyphs[index] = glyph;
          allMajorGlyphs = allMajorGlyphs.where((dbGlyph) {
            return dbGlyph.name != glyph.name;
          }).toList();
        } else {
          minorGlyphs[index] = glyph;
          allMinorGlyphs = allMinorGlyphs.where((dbGlyph) {
            return dbGlyph.name != glyph.name;
          }).toList();
        }
      });
      talentProvider.setGlyphs(minorGlyphs, majorGlyphs);
    }

    showGlyphDialog(int index, bool isMajorGlyph) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return GlyphDialog(
                isMajorGlyphs: isMajorGlyph,
                majorGlyphs: allMajorGlyphs,
                minorGlyphs: allMinorGlyphs,
                onGlyphSelected: (Glyph? glyph) {
                  if (glyph != null) {
                    if (isMajorGlyph && majorGlyphs[index] != null) {
                      allMajorGlyphs.add(majorGlyphs[index]);
                      allMajorGlyphs.sort((a, b) {
                        return a.name!
                            .toLowerCase()
                            .compareTo(b.name!.toLowerCase());
                      });
                    } else if (!isMajorGlyph && minorGlyphs[index] != null) {
                      allMinorGlyphs.add(minorGlyphs[index]!);
                      allMinorGlyphs.sort((a, b) {
                        return a.name!
                            .toLowerCase()
                            .compareTo(b.name!.toLowerCase());
                      });
                    }

                    onGlyphSelected(index, isMajorGlyph, glyph);
                  } else {
                    if (isMajorGlyph && majorGlyphs[index] != null) {
                      allMajorGlyphs.add(majorGlyphs[index]);
                      allMajorGlyphs.sort((a, b) {
                        return a.name!
                            .toLowerCase()
                            .compareTo(b.name!.toLowerCase());
                      });
                      setState(() {
                        majorGlyphs[index] = null;
                      });
                    } else if (!isMajorGlyph && minorGlyphs[index] != null) {
                      allMinorGlyphs.add(minorGlyphs[index]);
                      allMinorGlyphs.sort((a, b) {
                        return a.name!
                            .toLowerCase()
                            .compareTo(b.name!.toLowerCase());
                      });
                      setState(() {
                        minorGlyphs[index] = null;
                      });
                    }
                  }
                });
          });
    }

    return Scaffold(
      backgroundColor: Color(0xff556F7A),
      appBar: AppBar(
        centerTitle: true,
        title: Column(children: [
          Text('Set Glyphs'),
          Text(
            'Save the build to save the glyphs',
            style: TextStyle(fontSize: 14),
          )
        ]),
        backgroundColor: Color(0xff2E6171),
      ),
      body: DefaultTextStyle(
          style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontFamily: "Roboto",
              fontWeight: FontWeight.w900),
          child: Padding(
              padding: EdgeInsets.all(10),
              child: RawScrollbar(
                thumbColor: Colors.white,
                thumbVisibility: true,
                thickness: 3.5,
                radius: Radius.circular(20),
                controller: _scrollController,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12, top: 6),
                        child: Text('Major Glyphs'),
                      ),
                      ...talentProvider.majorGlyphs.mapIndexed((index, glyph) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: GlyphWidget(
                            onTap: () => showGlyphDialog(index, true),
                            glyph: glyph,
                          ),
                        );
                      }),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Text('Minor Glyphs'),
                      ),
                      ...talentProvider.minorGlyphs.mapIndexed((index, glyph) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: GlyphWidget(
                            onTap: () => showGlyphDialog(index, false),
                            glyph: glyph,
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ))),
    );
  }
}
