import 'package:currensee/widgets/customText.dart';
import 'package:flutter/material.dart';

class drawerList extends StatefulWidget {
  final String title;
  final IconData IconShow;
  final VoidCallback onTap;
  drawerList(this.title, this.IconShow, this.onTap);

  @override
  State<drawerList> createState() => _drawerListState();
}

class _drawerListState extends State<drawerList> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: MyText(widget.title, Colors.white, 16),
      trailing: Icon(widget.IconShow,color: Colors.white,),
      onTap: widget.onTap,
    );
  }
}
