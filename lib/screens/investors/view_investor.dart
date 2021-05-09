import 'package:farmasyst_admin_console/models/investor.dart';
import 'package:farmasyst_admin_console/models/investor.dart';
import 'package:farmasyst_admin_console/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:farmasyst_admin_console/services/constants.dart';
import 'package:farmasyst_admin_console/services/styles.dart';
import 'package:flutter_tags/flutter_tags.dart';

class ViewInvestor extends StatefulWidget {
  final Investor investor;
  final String investorId;
  ViewInvestor({Key key, this.investor, this.investorId}) : super(key: key);

  @override
  _ViewInvestorState createState() => _ViewInvestorState();
}

class _ViewInvestorState extends State<ViewInvestor> {
  // final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>();
  Investor investor;
  var profileImage;
  bool isLoading = false;

  @override
  void initState() {
    investor = widget.investor;
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
                  'Investor Details',
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
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: (investor.picture != null)
                                  ? Image.network(
                                      investor.picture,
                                      width: 120,
                                      height: 120,
                                      fit: BoxFit.fill,
                                    )
                                  : Image.asset(
                                      'assets/images/farmer.png',
                                      width: 120,
                                      height: 120,
                                      fit: BoxFit.fill,
                                    ),
                            ),
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
                                        text: widget.investor.name,
                                        style: Styles.kRichTextStyle,
                                      ),
                                    ],
                                  ),
                                ),
                                RichText(
                                  textAlign: TextAlign.start,
                                  text: TextSpan(
                                    style: Styles.kRichTextStyle16,
                                    children: <TextSpan>[
                                      TextSpan(text: 'Type\n'),
                                      TextSpan(
                                        text: widget.investor.type
                                                .toUpperCase() ??
                                            '',
                                        style: Styles.kRichTextStyle,
                                      ),
                                    ],
                                  ),
                                ),
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
                              TextSpan(
                                text: widget.investor.email.toString(),
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
                              TextSpan(text: 'Phone Number\n'),
                              TextSpan(
                                text: widget.investor.phone.toString(),
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
                              TextSpan(text: 'Location\n'),
                              TextSpan(
                                text: widget.investor.location,
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
                              TextSpan(text: 'Investor Interests\n'),
                            ],
                          ),
                        ),
                        Wrap(
                          spacing: 5.0, // gap between adjacent chips
                          runSpacing: 4.0, // gap between lines
                          children: List.generate(
                            investor.interests.length,
                            (index) => Chip(
                              backgroundColor: kPrimaryColor,
                              elevation: 5,
                              labelStyle: TextStyle(color: Colors.white),
                              label: Text('${investor.interests[index]}'),
                            ),
                          ),
                        ),
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
