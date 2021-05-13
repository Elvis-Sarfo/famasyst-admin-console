import 'package:farmasyst_admin_console/components/animated_widget.dart';
import 'package:flutter/material.dart';
import 'package:farmasyst_admin_console/components/main_button.dart';
import 'package:farmasyst_admin_console/responsive.dart';

import '../../../services/constants.dart';

class Jumbotron extends StatelessWidget {
  const Jumbotron({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: !isMobile(context) ? 40 : 0),
              child: Column(
                mainAxisAlignment: !isMobile(context)
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.center,
                crossAxisAlignment: !isMobile(context)
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 200,
                    height: 200,
                    child: AnimatedImage(),
                  ),
                  if (isMobile(context))
                    Image.asset(
                      'assets/images/logo.png',
                      height: size.height * 0.3,
                    ),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: 'FARM',
                        style: TextStyle(
                            fontSize: isDesktop(context) ? 64 : 32,
                            fontWeight: FontWeight.w800,
                            color: kTextColor)),
                    TextSpan(
                        text: 'ASYST',
                        style: TextStyle(
                            fontSize: isDesktop(context) ? 64 : 32,
                            fontWeight: FontWeight.w800,
                            color: kPrimaryColor)),
                  ])),
                  SizedBox(height: 50),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: 'Farmer-',
                        style: TextStyle(
                            fontSize: isDesktop(context) ? 45 : 32,
                            fontWeight: FontWeight.w800,
                            color: kSecondaryColor)),
                    TextSpan(
                        text: 'Investor',
                        style: TextStyle(
                            fontSize: isDesktop(context) ? 45 : 32,
                            fontWeight: FontWeight.w800,
                            color: kPrimaryColor)),
                    TextSpan(
                        text: ' Assembly',
                        style: TextStyle(
                            fontSize: isDesktop(context) ? 45 : 32,
                            fontWeight: FontWeight.w800,
                            color: kPrimaryDark)),
                    TextSpan(
                        text: ' Point',
                        style: TextStyle(
                          fontSize: isDesktop(context) ? 45 : 32,
                          fontWeight: FontWeight.w800,
                        )),
                  ])),
                ],
              ),
            ),
          ),
          if (isDesktop(context) || isTab(context))
            Expanded(
              child: Image.asset(
                'assets/images/farm.png',
                height: size.height * 0.7,
              ),
            )
        ],
      ),
    );
  }
}
