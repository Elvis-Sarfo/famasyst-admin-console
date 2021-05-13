import 'package:farmasyst_admin_console/components/image_chooser.dart';
import 'package:farmasyst_admin_console/screens/home/home.dart';
import 'package:farmasyst_admin_console/services/constants.dart';
import 'package:farmasyst_admin_console/services/styles.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

class PageRouter extends ChangeNotifier {
  Widget _selectedPage = HomeScreen();

  // Container(
  //   color: Colors.grey.withOpacity(0.1),
  //   child: Center(
  //     // child: Text('KantaTech'),
  //     // child: ImageChooser(),
  //     child: Container(
  //       width: 1000,
  //       height: 500,
  //       color: kPrimaryLight,
  //       child: Column(
  //         children: [
  //           Row(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               Text(
  //                 'Supervisor Details',
  //                 style: TextStyle(
  //                   fontSize: 32,
  //                 ),
  //               ),
  //               Tooltip(
  //                 message: "Close Window",
  //                 child: IconButton(
  //                     splashColor: Colors.red.withOpacity(0.3),
  //                     hoverColor: Colors.red.withOpacity(0.3),
  //                     splashRadius: 20,
  //                     highlightColor: Colors.white,
  //                     icon: Icon(
  //                       Icons.close,
  //                       color: Colors.redAccent,
  //                       size: 25,
  //                     ),
  //                     onPressed: () {
  //                       // Navigator.of(context).pop();
  //                     }),
  //               )
  //             ],
  //           ),
  //           Row(
  //             children: [
  //               Expanded(
  //                 child: SingleChildScrollView(
  //                   child: Column(
  //                     mainAxisAlignment: MainAxisAlignment.start,
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Row(
  //                         children: [
  //                           ClipRRect(
  //                             borderRadius: BorderRadius.circular(50),
  //                             child:
  //                                 // if (supervisor.picture != null)
  //                                 (false)
  //                                     ? Image.network(
  //                                         'supervisor.picture',
  //                                         width: 150,
  //                                         height: 150,
  //                                         fit: BoxFit.fill,
  //                                       )
  //                                     : Image.asset(
  //                                         'assets/images/farmer.png',
  //                                         width: 150,
  //                                         height: 150,
  //                                         fit: BoxFit.fill,
  //                                       ),
  //                           ),
  //                           Column(
  //                             mainAxisAlignment: MainAxisAlignment.start,
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               RichText(
  //                                 textAlign: TextAlign.start,
  //                                 text: TextSpan(
  //                                   style: TextStyle(
  //                                       fontSize: 16,
  //                                       height: 1.5,
  //                                       color: Colors.black54,
  //                                       fontWeight: FontWeight.w600),
  //                                   children: <TextSpan>[
  //                                     TextSpan(text: 'Name\n'),
  //                                     TextSpan(
  //                                       text: 'widget.supervisor.name',
  //                                       style: Styles.kRichTextStyle,
  //                                     ),
  //                                   ],
  //                                 ),
  //                               ),
  //                               RichText(
  //                                 textAlign: TextAlign.start,
  //                                 text: TextSpan(
  //                                   style: TextStyle(
  //                                       fontSize: 16,
  //                                       height: 1.5,
  //                                       color: Colors.black54,
  //                                       fontWeight: FontWeight.w600),
  //                                   children: <TextSpan>[
  //                                     TextSpan(text: 'Gender\n'),
  //                                     TextSpan(
  //                                       text: 'widget.supervisor.gender'
  //                                           .toUpperCase(),
  //                                       style: Styles.kRichTextStyle,
  //                                     ),
  //                                   ],
  //                                 ),
  //                               ),
  //                               RichText(
  //                                 textAlign: TextAlign.start,
  //                                 text: TextSpan(
  //                                   style: TextStyle(
  //                                       fontSize: 16,
  //                                       height: 1.5,
  //                                       color: Colors.black54,
  //                                       fontWeight: FontWeight.w600),
  //                                   children: <TextSpan>[
  //                                     TextSpan(text: 'Age\n'),
  //                                     TextSpan(
  //                                       text: '45',
  //                                       // getYears(
  //                                       //         widget.supervisor.dateOfBirth)
  //                                       //     .toString(),
  //                                       style: TextStyle(
  //                                         fontSize: 20,
  //                                         height: 1.5,
  //                                         color: kPrimaryDark,
  //                                         fontWeight: FontWeight.bold,
  //                                       ),
  //                                     ),
  //                                   ],
  //                                 ),
  //                               ),
  //                             ],
  //                           )
  //                         ],
  //                       ),
  //                       SizedBox(
  //                         height: 10,
  //                       ),
  //                       RichText(
  //                         textAlign: TextAlign.start,
  //                         text: TextSpan(
  //                           style: TextStyle(
  //                               fontSize: 16,
  //                               height: 1.5,
  //                               color: Colors.black54,
  //                               fontWeight: FontWeight.w600),
  //                           children: <TextSpan>[
  //                             TextSpan(text: 'Phone Number\n'),
  //                             TextSpan(
  //                               text: 'widget.supervisor.phone.toString()',
  //                               style: Styles.kRichTextStyle,
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                       SizedBox(
  //                         height: 10,
  //                       ),
  //                       RichText(
  //                         textAlign: TextAlign.start,
  //                         text: TextSpan(
  //                           style: TextStyle(
  //                               fontSize: 16,
  //                               height: 1.5,
  //                               color: Colors.black54,
  //                               fontWeight: FontWeight.w600),
  //                           children: <TextSpan>[
  //                             TextSpan(text: 'Location\n'),
  //                             TextSpan(
  //                               text: 'widget.supervisor.location',
  //                               style: Styles.kRichTextStyle,
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                       SizedBox(
  //                         height: 10,
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //               Expanded(child: Text('data'))
  //             ],
  //           ),
  //         ],
  //       ),
  //     ),
  //   ),
  // );

  Widget get selectedPage => _selectedPage;

  route(Widget page) {
    _selectedPage = page;
    notifyListeners();
  }
}
