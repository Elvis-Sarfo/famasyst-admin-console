import 'package:flutter/material.dart';

class CircularImage extends StatelessWidget {
  final Image child;
  const CircularImage({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: child ??
          Image.asset(
            'assets/images/farmer.png',
            height: 50.0,
            width: 50.0,
          ),
    );
  }
}
