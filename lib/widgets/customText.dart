import 'package:flutter/material.dart';

class MyText extends StatefulWidget {
  final String title;
  final Color colors;
  final double fontSize;

  MyText(this.title, this.colors, this.fontSize);

  @override
  State<MyText> createState() => _MyTextState();
}

class _MyTextState extends State<MyText> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.title,style: TextStyle(color: widget.colors,fontSize: widget.fontSize,fontFamily: 'Lexend'),);
  }
}
