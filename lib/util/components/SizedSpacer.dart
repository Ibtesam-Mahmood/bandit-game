
import 'package:flutter/material.dart';

///Horizontally sized spacer
class SizedSpacer extends StatelessWidget {

  //Static Interface

  ///Create a horizontal space with a set height
  factory SizedSpacer.vertical([double height = 0.0]) => SizedSpacer(height: height);

  ///Create a vertical space with a set height
  factory SizedSpacer.horizontal([double width = 0.0]) => SizedSpacer(width: width);

  //Size varaibles
  final double height;
  final double width;

  const SizedSpacer({Key? key, this.height = 0.0, this.width = 0.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
    );
  }
}

class ConstantSizedSpacer extends StatelessWidget{

  ///Create a horizontal space with a set height
  factory ConstantSizedSpacer.vertical([double height = 0.0]) => ConstantSizedSpacer(height: height);

  ///Create a vertical space with a set height
  factory ConstantSizedSpacer.horizontal([double width = 0.0]) => ConstantSizedSpacer(width: width);

  //Size varaibles
  final double height;
  final double width;

  const ConstantSizedSpacer({Key? key, this.height = 0.0, this.width = 0.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
    );
  }
}