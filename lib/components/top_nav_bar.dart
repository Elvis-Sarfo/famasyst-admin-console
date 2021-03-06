import 'package:flutter/material.dart';
import 'package:farmasyst_admin_console/services/constants.dart';
import 'package:farmasyst_admin_console/responsive.dart';
import 'menu_item.dart';

class TopNavBar extends StatefulWidget {
  // final Widget rootContainerContent;

  final List<Map> navMap;

  const TopNavBar({
    Key key,
    @required this.navMap,
    // this.rootContainerContent,
  }) : super(key: key);

  @override
  _TopNavBarState createState() => _TopNavBarState();
}

class _TopNavBarState extends State<TopNavBar> {
  int selectedItem = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(40, 20, 0, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          if (!isMobile(context))
            Row(
              children: List.generate(
                widget.navMap.length,
                (index) => NavItem(
                  selectedItemColor: selectedItem == index
                      ? kPrimaryColor
                      : Colors.transparent,
                  selectedItemTextColor:
                      selectedItem == index ? Colors.white : kTextColor,
                  title: widget.navMap[index]['title'],
                  tapEvent: () {
                    setState(() {
                      selectedItem = index;
                    });
                    widget.navMap[index]['onTapCallback']();
                  },
                ),
              ),
            ),
          if (isMobile(context))
            IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                })
        ],
      ),
    );
  }
}
