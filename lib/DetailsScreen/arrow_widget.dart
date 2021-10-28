import 'package:flutter/material.dart';

class ArrowWidget extends StatelessWidget {
  const ArrowWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Image(image: AssetImage('assets/Arrows/ArrowMedium.png')),
      
    ]);
  }
}
