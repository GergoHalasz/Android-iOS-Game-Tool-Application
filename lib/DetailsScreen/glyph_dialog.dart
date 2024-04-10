import 'package:flutter/material.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';

import '../model/glyph.dart';
import '../utils/size_config.dart';

class GlyphDialog extends StatefulWidget {
  final List<Glyph> majorGlyphs;
  final List<Glyph> minorGlyphs;
  final Function onGlyphSelected;
  final bool isMajorGlyphs;

  const GlyphDialog(
      {Key? key,
      required this.majorGlyphs,
      required this.minorGlyphs,
      required this.onGlyphSelected,
      required this.isMajorGlyphs})
      : super(key: key);

  @override
  _GlyphDialogState createState() => _GlyphDialogState();
}

class _GlyphDialogState extends State<GlyphDialog> {
  String value = "";
  final TextEditingController _controller = TextEditingController();
  ScrollController _scrollController = ScrollController();
  final tooltipController = JustTheController();

  void _showDescription() {
    tooltipController.showTooltip();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color(0xff556F7A),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Long press the glyph to see the description',style: TextStyle(color: Colors.white),),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.only(top: 4.0, bottom: 10),
            child: TextField(
              controller: _controller,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
              autocorrect: false,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      _controller.value = _controller.value.copyWith(
                        text: '',
                        selection: TextSelection.collapsed(offset: ''.length),
                      );
                      setState(() {
                        value = '';
                      });
                    },
                  ),
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(color: Colors.white),
                  label: Text('Search Glyph Name')),
              onChanged: (text) {
                setState(() {
                  value = text;
                });
                print(text);
              },
            ),
          ),
          Container(
            height: SizeConfig.screenHeight / 3.2,
            decoration: BoxDecoration(
                border: Border.all(color: Color.fromARGB(255, 85, 85, 85))),
            width: double.maxFinite,
            child: RawScrollbar(
              thumbColor: Colors.white,
              controller: _scrollController,
              thickness: 3.5,
              radius: Radius.circular(20),
              child: ListView(
                controller: _scrollController,
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    margin: EdgeInsets.zero,
                    color: Colors.grey.shade700,
                    child: ListTile(
                        onTap: () {
                          widget.onGlyphSelected(null);
                          Navigator.pop(context);
                        },
                        title: Text(
                          "None",
                          style: TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(255, 222, 222, 222)),
                        ),
                        leading: Icon(
                          Icons.block,
                          size: 35,
                        )),
                  ),
                  if (widget.isMajorGlyphs)
                    ...widget.majorGlyphs.where((glyph) {
                      List<String> words = value.split(' ');

                      words = words.map((word) {
                        return word.toLowerCase();
                      }).toList();
                      bool contains = true;
                      words.forEach((word) {
                        if (!glyph.name!.toLowerCase().contains(word)) {
                          contains = false;
                        }
                      });
                      return contains;
                    }).map((glyph) {
                      return Tooltip(
                        padding: EdgeInsets.all(6),
                        showDuration: Duration(seconds: 10),
                        textStyle: TextStyle(color: Colors.black),
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Column(
                          children: [
                            Divider(
                              height: 0,
                              thickness: 1,
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0),
                              ),
                              margin: EdgeInsets.zero,
                              color: Colors.grey.shade700,
                              child: ListTile(
                                onTap: () {
                                  widget.onGlyphSelected(glyph);
                                  Navigator.pop(context);
                                },
                                title: Text(
                                  glyph.name!,
                                  style: TextStyle(
                                      fontSize: 15,
                                      color:
                                          Color.fromARGB(255, 222, 222, 222)),
                                ),
                                leading: Image.asset(
                                  'assets/Icons/' + glyph.rune! + '.png',
                                  width: 35,
                                  height: 35,
                                ),
                              ),
                            ),
                          ],
                        ),
                        message: glyph.description,
                      );
                    }),
                  if (!widget.isMajorGlyphs)
                    ...widget.minorGlyphs.where((glyph) {
                      List<String> words = value.split(' ');

                      words = words.map((word) {
                        return word.toLowerCase();
                      }).toList();
                      bool contains = true;
                      words.forEach((word) {
                        if (!glyph.name!.toLowerCase().contains(word)) {
                          contains = false;
                        }
                      });
                      return contains;
                    }).map((glyph) {
                      return Tooltip(
                          message: glyph.description,
                          padding: EdgeInsets.all(6),
                          showDuration: Duration(seconds: 10),
                          textStyle: TextStyle(color: Colors.black),
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Column(
                            children: [
                              Divider(
                                height: 0,
                                thickness: 1,
                              ),
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0),
                                ),
                                margin: EdgeInsets.zero,
                                color: Colors.grey.shade700,
                                child: ListTile(
                                  onTap: () {
                                    widget.onGlyphSelected(glyph);
                                    Navigator.pop(context);
                                  },
                                  title: Text(
                                    glyph.name!,
                                    style: TextStyle(
                                        fontSize: 15,
                                        color:
                                            Color.fromARGB(255, 222, 222, 222)),
                                  ),
                                  leading: Image.asset(
                                    'assets/Icons/' + glyph.rune! + '.png',
                                    width: 35,
                                    height: 35,
                                  ),
                                ),
                              ),
                            ],
                          ));
                    })
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
