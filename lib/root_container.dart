import 'package:flutter/material.dart';
import 'package:flutter_web/components/footer.dart';
import 'package:flutter_web/components/header.dart';
import 'package:flutter_web/components/side_menu.dart';
import 'package:provider/provider.dart';

import 'page_routes.dart';

// class RootContainer extends StatefulWidget {
//   Widget content = Container(
//     color: Colors.blue,
//   );

//   @override
//   RootContainerState createState() => RootContainerState();
// }

class RootContainer extends StatelessWidget {
  static void push(Widget contect) {}

  @override
  Widget build(BuildContext context) {
    // we designed this landing page on previous video, you can get base code from
    // https://github.com/gihan667/flutter-web-landing-page
    // We have overflow issue on fullscreen
    // Now we get overflow on screen width 765px, let's fix this
    // Now our menu overflow on screen width 612px, let's fix this
    // Our footer also get's overflow on smaller width which is mobile views
    // Our jumbotron get's crappy when screen width getting lower, let's add some styles :)
    // Our texts on jumbotron too small on desktop size, lets add some style to them
    // Looks good on browser on each screen size, let's check on iphone
    Size size = MediaQuery.of(context).size;

    // while (!Me.hate(You)) {
    //   Me.miss(You);
    // }

    return ChangeNotifierProvider(
      create: (context) => PageRouter(),
      child: Scaffold(
        endDrawer: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 300),
          child: SideMenu(),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              width: size.width,
              height: size.height,
              constraints: BoxConstraints(minHeight: size.height),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Header(),
                  Expanded(
                    child: Consumer<PageRouter>(
                      builder: (context, pageRoute, child) =>
                          pageRoute.selectedPage,
                    ),
                  ),
                  Footer()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
