import 'package:farmasyst_admin_console/components/top_nav_bar.dart';
import 'package:farmasyst_admin_console/page_routes.dart';
import 'package:farmasyst_admin_console/screens/farmers/farmers.dart';
import 'package:farmasyst_admin_console/screens/farms/farms.dart';
import 'package:farmasyst_admin_console/screens/home/home.dart';
import 'package:flutter/material.dart';
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
            "FarmaSyst",
            style: GoogleFonts.reenieBeanie(fontSize: 18),
          ),
          // Spacer(),
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
                  'title': 'Farmers',
                  'onTapCallback': () =>
                      context.read<PageRouter>().route(FarmerScreen()),
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
