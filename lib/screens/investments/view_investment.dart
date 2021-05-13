import 'package:farmasyst_admin_console/models/investment.dart';
import 'package:farmasyst_admin_console/models/investment.dart';
import 'package:farmasyst_admin_console/models/investment.dart';
import 'package:farmasyst_admin_console/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:farmasyst_admin_console/services/constants.dart';
import 'package:farmasyst_admin_console/services/styles.dart';
import 'package:flutter_tags/flutter_tags.dart';

class ViewInvestment extends StatefulWidget {
  final Investment investment;
  final String farmId;
  ViewInvestment({Key key, this.investment, this.farmId}) : super(key: key);

  @override
  _ViewInvestmentState createState() => _ViewInvestmentState();
}

class _ViewInvestmentState extends State<ViewInvestment> {
  // final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>();
  Investment investment;
  var profileImage;
  bool isLoading = false;

  @override
  void initState() {
    investment = widget.investment;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(24.0),
        width: size.width * 0.7,
        height: size.height * 0.7,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Investment Details',
                  style: TextStyle(
                    fontSize: 32,
                  ),
                ),
                Tooltip(
                  message: "Close Window",
                  child: IconButton(
                      splashColor: Colors.red.withOpacity(0.3),
                      hoverColor: Colors.red.withOpacity(0.3),
                      splashRadius: 20,
                      highlightColor: Colors.white,
                      icon: Icon(
                        Icons.close,
                        color: Colors.redAccent,
                        size: 25,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            // ClipRRect(
                            //   borderRadius: BorderRadius.circular(10),
                            //   child: (investment.picture != null)
                            //       ? Image.network(
                            //           investment.picture,
                            //           width: 120,
                            //           height: 120,
                            //           fit: BoxFit.fill,
                            //         )
                            //       : Image.asset(
                            //           'assets/images/farmer.png',
                            //           width: 120,
                            //           height: 120,
                            //           fit: BoxFit.fill,
                            //         ),
                            // ),
                            SizedBox(width: 5),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  textAlign: TextAlign.start,
                                  text: TextSpan(
                                    style: Styles.kRichTextStyle16,
                                    children: <TextSpan>[
                                      TextSpan(text: 'Name\n'),
                                      TextSpan(
                                        text: widget.investment.id.toString(),
                                        style: Styles.kRichTextStyle,
                                      ),
                                    ],
                                  ),
                                ),
                                // RichText(
                                //   textAlign: TextAlign.start,
                                //   text: TextSpan(
                                //     style: Styles.kRichTextStyle16,
                                //     children: <TextSpan>[
                                //       TextSpan(text: 'Type\n'),
                                //       TextSpan(
                                //         text: widget.investment.type.toUpperCase() ??
                                //             '',
                                //         style: Styles.kRichTextStyle,
                                //       ),
                                //     ],
                                //   ),
                                // ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        RichText(
                          textAlign: TextAlign.start,
                          text: TextSpan(
                            style: Styles.kRichTextStyle16,
                            children: <TextSpan>[
                              TextSpan(text: 'Email\n'),
                              // TextSpan(
                              //   text: widget.investment.email.toString(),
                              //   style: Styles.kRichTextStyle,
                              // ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        RichText(
                          textAlign: TextAlign.start,
                          text: TextSpan(
                            style: Styles.kRichTextStyle16,
                            children: <TextSpan>[
                              TextSpan(text: 'Phone Number\n'),
                              // TextSpan(
                              //   text: widget.investment.phone.toString(),
                              //   style: Styles.kRichTextStyle,
                              // ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        RichText(
                          textAlign: TextAlign.start,
                          text: TextSpan(
                            style: Styles.kRichTextStyle16,
                            children: <TextSpan>[
                              TextSpan(text: 'Location\n'),
                              TextSpan(
                                text: widget.investment.payback,
                                style: Styles.kRichTextStyle,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        RichText(
                          textAlign: TextAlign.start,
                          text: TextSpan(
                            style: Styles.kRichTextStyle16,
                            children: <TextSpan>[
                              TextSpan(text: 'Investment Interests\n'),
                            ],
                          ),
                        ),
                        // Wrap(
                        //   spacing: 5.0, // gap between adjacent chips
                        //   runSpacing: 4.0, // gap between lines
                        //   children: List.generate(
                        //     investment.crops.length,
                        //     (index) => Chip(
                        //       backgroundColor: kPrimaryColor,
                        //       elevation: 5,
                        //       labelStyle: TextStyle(color: Colors.white),
                        //       label: Text('${investment.crops[index]}'),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: kPrimaryColor,
                    child: Center(
                      child: Text('data'),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
