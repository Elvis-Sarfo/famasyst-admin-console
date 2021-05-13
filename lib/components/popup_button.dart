import 'package:flutter/material.dart';

class PopupButton extends StatefulWidget {
  final String tooltip;
  final Widget child, icon;
  final List<Map<String, dynamic>> items;
  final Function(dynamic value) onSelected;
  const PopupButton({
    Key key,
    this.tooltip = 'Open Menu',
    this.child,
    this.items = const [],
    this.onSelected,
    this.icon,
  }) : super(key: key);

  @override
  _PopupButtonState createState() => _PopupButtonState();
}

class _PopupButtonState extends State<PopupButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: PopupMenuButton(
        padding: EdgeInsets.symmetric(horizontal: 0),
        tooltip: widget.tooltip,
        icon: widget.icon != null ? widget.icon : null,
        child: widget.icon == null
            ? widget.child != null
                ? widget.child
                : Text('Popup Menu')
            : null,
        onSelected: (result) {
          setState(() {
            widget.onSelected(result);
          });
        },
        itemBuilder: (BuildContext context) => widget.items
            .map((item) => PopupMenuItem(
                  value: item['value'],
                  child: item['child'],
                ))
            .toList(),
      ),
    );
  }
}
