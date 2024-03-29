import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wowtalentcalculator/model/position.dart';
import 'package:wowtalentcalculator/model/talent.dart';
import 'package:wowtalentcalculator/provider/talent_provider.dart';
import 'package:wowtalentcalculator/utils/constants.dart';
import 'package:wowtalentcalculator/utils/size_config.dart';

class LeftCornerArrowWidget extends StatefulWidget {
  final Position startPosition;
  final Position endPosition;
  final String lengthType;
  final String dependencyTalent;
  LeftCornerArrowWidget({
    required this.startPosition,
    required this.endPosition,
    required this.lengthType,
    required this.dependencyTalent,
  });

  @override
  _LeftCornerArrowWidgetState createState() => _LeftCornerArrowWidgetState();
}

class _LeftCornerArrowWidgetState extends State<LeftCornerArrowWidget> {
  String arrowBodyImg = 'assets/Arrows/GreyArrowBody.png';
  String arrowHeadImg = 'assets/Arrows/GreyArrowHead.png';
  String arrowCornerImg = 'assets/Arrows/GreyArrowCorner.png';
  var talentProvider;
  late double arrowBodyTop;
  late double arrowBodyLeft;
  late double arrowBodyWidth;
  late double arrowBodyHeight;
  late double arrowHeadTop;
  late double arrowHeadLeft;
  late double arrowHeadWidth;
  late double leftArrowBodyTop;
  late double leftArrowBodyLeft;
  late double rightArrowBodyHeight;
  late double rightArrowBodyWidth;
  late double arrowCornerTop;
  late double arrowCornerLeft;

  setEnable() {
    Talent dependencyTalent =
        talentProvider.findTalentByName(widget.dependencyTalent);
    if (dependencyTalent.enable) {
      setState(() {
        arrowBodyImg = 'assets/Arrows/ArrowBody.png';
        arrowHeadImg = 'assets/Arrows/ArrowHead.png';
        arrowCornerImg = 'assets/Arrows/ArrowCorner.png';
      });
    } else {
      arrowBodyImg = 'assets/Arrows/GreyArrowBody.png';
      arrowHeadImg = 'assets/Arrows/GreyArrowHead.png';
      arrowCornerImg = 'assets/Arrows/GreyArrowCorner.png';
    }
    }

  void _calculatePositions() {
    arrowBodyTop = SizeConfig.cellSize * (widget.startPosition.row) -
        SizeConfig.cellSize / 2;
    arrowBodyLeft = SizeConfig.cellSize * (widget.startPosition.column - 1) -
        SizeConfig.cellSize / 1.7;
    arrowBodyWidth = kArrowWidthSize;
    arrowBodyHeight = 0;

    arrowHeadTop = SizeConfig.cellSize * (widget.endPosition.row - 1);
    arrowHeadLeft = SizeConfig.cellSize * (widget.startPosition.column - 1) -
        SizeConfig.cellSize / 1.7;
    arrowHeadWidth = kArrowWidthSize;
    leftArrowBodyTop = SizeConfig.cellSize * widget.startPosition.row -
        SizeConfig.cellSize / 1.6;

    rightArrowBodyHeight = kArrowWidthSize;
    rightArrowBodyWidth = SizeConfig.cellSize * 0.52;
    leftArrowBodyLeft =
        SizeConfig.cellSize * (widget.startPosition.column - 1) -
            rightArrowBodyWidth +
            SizeConfig.cellSize / 7;

    arrowCornerTop = SizeConfig.cellSize * (widget.startPosition.row) -
        SizeConfig.cellSize / 1.67;
    arrowCornerLeft = SizeConfig.cellSize * (widget.startPosition.column - 1) -
        SizeConfig.cellSize / 1.78;

    if (widget.lengthType == 'long') {
      arrowBodyHeight = SizeConfig.cellSize * 2.15; //magic number
    } else if (widget.lengthType == 'medium') {
      arrowBodyHeight = SizeConfig.cellSize * 1.50; //magic number
    } else if (widget.lengthType == 'short') {
      arrowBodyHeight = SizeConfig.cellSize * 0.5; //magic number
    }
  }

  @override
  void initState() {
    _calculatePositions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    talentProvider = Provider.of<TalentProvider>(context);

    // set arrow enable or disable depend on the state of talent spell
    setEnable();

    return Stack(
      children: <Widget>[
        /// horizontal bar
        Positioned(
          top: leftArrowBodyTop,
          left: leftArrowBodyLeft,
          child: Container(
              width: rightArrowBodyWidth,
              height: rightArrowBodyHeight,
              child: RotatedBox(
                quarterTurns: 1,
                child: Image.asset(
                  arrowBodyImg,
                  fit: BoxFit.fill,
                ),
              )),
        ),

        /// vertical bar (scale)
        Positioned(
          top: arrowBodyTop,
          left: arrowBodyLeft,
          child: Container(
              width: arrowBodyWidth,
              height: arrowBodyHeight,
              child: Image.asset(
                arrowBodyImg,
                fit: BoxFit.fill,
              )),
        ),

        /// right corner piece
        Positioned(
          top: arrowCornerTop,
          left: arrowCornerLeft,
          child: Container(
              width: SizeConfig.cellSize * 0.2,
              height: SizeConfig.cellSize * 0.2,
              child: Transform.rotate(
                angle: 270 * pi / 180,
                child: Image.asset(
                  arrowCornerImg,
                  fit: BoxFit.fill,
                ),
              )),
        ),

        /// arrow piece
        Positioned(
          top: arrowHeadTop,
          left: arrowHeadLeft,
          child: Container(
              width: arrowHeadWidth,
              child: Image.asset(
                arrowHeadImg,
                fit: BoxFit.fill,
              )),
        ),
      ],
    );
  }
}
