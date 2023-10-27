import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? size;
  final Color? color;
  final FontWeight? weight;
  final bool underLine;

  const CustomText(
      {Key? key,
      required this.text,
      this.size,
      this.color,
      this.weight, this.underLine = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,

      style: TextStyle(
          fontSize: size ?? 16,
          color: color ?? Colors.black,
          decoration:underLine ?  TextDecoration.underline : TextDecoration.none,
          fontWeight: weight ?? FontWeight.normal),
    );
  }
}
