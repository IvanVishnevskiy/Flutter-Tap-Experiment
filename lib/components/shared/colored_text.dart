import 'package:flutter/material.dart';

class ColoredText extends StatelessWidget {
  const ColoredText(this.text, {super.key, this.color});

  final Color? color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: color ?? Colors.white),
    );
  }
}
