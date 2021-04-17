import 'package:flutter/material.dart';
import 'package:flutter_web/components/top_nav_bar.dart';
import 'package:flutter_web/responsive.dart';
import 'package:flutter_web/page_routes.dart';
import 'package:flutter_web/screens/farms/farms.dart';
import 'package:flutter_web/screens/home/home.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Header extends StatelessWidget {
  // final Widget rootContainerContent;
  const Header({
    Key key,
    // this.rootContainerContent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        children: <Widget>[
          Image.asset(
            'assets/images/logo.png',
            width: 50,
          ),
          SizedBox(width: 10),
          Text(
            "Peta Beauty",
            style: GoogleFonts.reenieBeanie(fontSize: 18),
          ),
          Spacer(),
          Expanded(
            child: TopNavBar(
              navMap: [
                {
                  'title': 'Home',
                  'onTapCallback': () =>
                      context.read<PageRouter>().route(HomeScreen()),
                },
                {
                  'title': 'Farms',
                  'onTapCallback': () =>
                      context.read<PageRouter>().route(FarmScreen()),
                },
                {
                  'title': 'Investors',
                  'onTapCallback': () =>
                      context.read<PageRouter>().route(HomeScreen()),
                },
                {
                  'title': 'Supervisors',
                  'onTapCallback': () =>
                      context.read<PageRouter>().route(HomeScreen()),
                }
              ],
            ),
          ),
        ],
      ),
    );
  }
}
