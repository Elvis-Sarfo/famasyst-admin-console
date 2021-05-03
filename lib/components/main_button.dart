import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    Key key,
    @required this.title,
    @required this.tapEvent,
    @required this.color,
    this.iconData,
    this.isLoading,
    this.disabled,
  }) : super(key: key);

  final String title;
  final GestureTapCallback tapEvent;
  final Color color;
  final IconData iconData;
  final bool isLoading, disabled;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: iconData == null
          ? ElevatedButton(
              onPressed: tapEvent,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(color),
                padding: MaterialStateProperty.all(
                  EdgeInsets.symmetric(
                    horizontal: 35,
                    vertical: 15,
                  ),
                ),
              ),
              child: isLoading != null && isLoading
                  ? Image.asset(
                      'assets/images/spinner.gif',
                      width: 19.0,
                      height: 19.0,
                    )
                  : Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            )
          : ElevatedButton.icon(
              onPressed: tapEvent,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(color),
                padding: MaterialStateProperty.all(
                  EdgeInsets.symmetric(
                    horizontal: 35,
                    vertical: 15,
                  ),
                ),
              ),
              icon: Icon(iconData),
              label: isLoading != null && isLoading
                  ? Image.asset(
                      'assets/images/spinner.gif',
                      width: 19.0,
                      height: 19.0,
                    )
                  : Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
    );
  }
}
