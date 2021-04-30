import 'package:flutter/material.dart';

class ClickableText extends StatelessWidget {
  final List<TextSpan> children;
  final Function onPress;
  final Color color;

  ClickableText({
    Key key,
    this.onPress,
    @required this.children,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        padding: EdgeInsets.all(10),
        child: Center(
          child: RichText(
            text: TextSpan(
              style: TextStyle(fontSize: 16),
              children: children,
            ),
          ),
        ),
      ),
    );
  }
}
