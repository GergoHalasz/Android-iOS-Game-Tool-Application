import 'package:flutter/material.dart';

import 'glyph_dialog.dart';

class GlyphWidget extends StatefulWidget {
  final Function onTap;
  final dynamic glyph;

  const GlyphWidget({Key? key, required this.onTap, required this.glyph})
      : super(key: key);

  @override
  _GlyphWidgetState createState() => _GlyphWidgetState();
}

class _GlyphWidgetState extends State<GlyphWidget> {
  String imgLocation = 'assets/Icons/inventoryslot_empty.png';

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Ink(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 177, 177, 177),
                image: DecorationImage(
                    image: AssetImage(widget.glyph != null
                        ? 'assets/Icons/' + widget.glyph.rune + '.png'
                        : imgLocation),
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
                  widget.onTap();
                },
                onLongPress: () => {},
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          if (widget.glyph != null)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6, top: 2),
                      child: Text(
                        widget.glyph.name,
                        style: TextStyle(
                            color: Colors.amber,
                          fontWeight: FontWeight.bold,
                            fontSize: 14,
                            letterSpacing: -0.5),
                      ),
                    ),
                    Text(
                      widget.glyph.description,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          letterSpacing: -0.5),
                    )
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }
}
