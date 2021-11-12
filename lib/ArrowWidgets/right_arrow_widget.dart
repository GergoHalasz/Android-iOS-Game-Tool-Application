import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wowtalentcalculator/model/position.dart';
import 'package:wowtalentcalculator/model/talent.dart';
import 'package:wowtalentcalculator/provider/talent_provider.dart';
import 'package:wowtalentcalculator/utils/constants.dart';
import 'package:wowtalentcalculator/utils/size_config.dart';

class RightArrowWidget extends StatefulWidget {
  final Position startPosition;
  final Position endPosition;
  final String lengthType;
  final String dependencyTalent;
  RightArrowWidget({
    required this.startPosition,
    required this.endPosition,
    required this.lengthType,
    required this.dependencyTalent,
  });

  @override
  _RightArrowWidgetState createState() => _RightArrowWidgetState();
}

class _RightArrowWidgetState extends State<RightArrowWidget> {
  String arrowBodyImg = 'assets/Arrows/GreyArrowBody.png';
  String arrowHeadImg = 'assets/Arrows/GreyArrowHead.png';
  var talentProvider;
  late double arrowBodyTop;
  late double arrowBodyLeft;
  late double arrowBodyHeight;
  late double arrowBodyWidth;
  late double arrowHeadTop;
  late double arrowHeadLeft;
  late double arrowHeadHeight;

  setEnable() {
    Talent dependencyTalent =
        talentProvider.findTalentByName(widget.dependencyTalent);
    if (dependencyTalent != null) {
      if (dependencyTalent.enable) {
        setState(() {
          arrowBodyImg = 'assets/Arrows/ArrowBody.png';
          arrowHeadImg = 'assets/Arrows/ArrowHead.png';
        });
      } else {
        arrowBodyImg = 'assets/Arrows/GreyArrowBody.png';
        arrowHeadImg = 'assets/Arrows/GreyArrowHead.png';
      }
    }
  }

  void _calculatePositions() {
    arrowBodyTop = SizeConfig.cellSize * widget.startPosition.row -
        SizeConfig.cellSize / 1.6;
    arrowBodyLeft = SizeConfig.cellSize * widget.startPosition.column -
        SizeConfig.cellSize / 7;
    arrowBodyHeight = kArrowWidthSize;
    arrowBodyWidth = 0;
    arrowHeadTop = SizeConfig.cellSize * widget.endPosition.row -
        SizeConfig.cellSize / 1.6;
    arrowHeadLeft = SizeConfig.cellSize * widget.startPosition.column;
    arrowHeadHeight = kArrowWidthSize;

    if (widget.lengthType == 'short') {
      arrowBodyWidth = SizeConfig.cellSize * 0.15; //magic number
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
        Positioned(
          top: arrowBodyTop,
          left: arrowBodyLeft,
          child: Container(
              width: arrowBodyWidth,
              height: arrowBodyHeight,
              child: RotatedBox(
                quarterTurns: 1,
                child: Image.asset(
                  arrowBodyImg,
                  fit: BoxFit.fill,
                ),
              )),
        ),
        Positioned(
          top: arrowHeadTop,
          left: arrowHeadLeft,
          child: Container(
              height: arrowHeadHeight,
              child: RotatedBox(
                quarterTurns: 3,
                child: Image.asset(
                  arrowHeadImg,
                  fit: BoxFit.fill,
                ),
              )),
        )
      ],
    );
  }
}
