import 'package:flutter/material.dart';
import '../services/constants.dart';

class NavItem extends StatelessWidget {
  NavItem({
    Key key,
    @required this.title,
    @required this.tapEvent,
    this.selectedItemColor,
    this.selectedItemTextColor,
  }) : super(key: key);

  final String title;
  final GestureTapCallback tapEvent;
  final Color selectedItemColor;
  final Color selectedItemTextColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: tapEvent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: selectedItemColor,
          border: Border.all(
            color: kPrimaryColor,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        margin: EdgeInsets.symmetric(
          horizontal: 5,
        ),
        child: Text(
          title,
          style: TextStyle(
            color: selectedItemTextColor,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }
}
