import 'package:farmasyst_admin_console/models/supervisor.dart';
import 'package:farmasyst_admin_console/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:farmasyst_admin_console/services/constants.dart';
import 'package:farmasyst_admin_console/services/styles.dart';
import 'package:flutter_tags/flutter_tags.dart';

class ViewSupervisor extends StatefulWidget {
  final Supervisor supervisor;
  final String supervisorId;
  ViewSupervisor({Key key, this.supervisor, this.supervisorId})
      : super(key: key);

  @override
  _ViewSupervisorState createState() => _ViewSupervisorState();
}

class _ViewSupervisorState extends State<ViewSupervisor> {
  // final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>();
  Supervisor supervisor;
  var profileImage;
  bool isLoading = false;

  @override
  void initState() {
    supervisor = widget.supervisor;
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
                  'Supervisor Details',
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
                              child: (supervisor.picture != null)
                                  ? Image.network(
                                      supervisor.picture,
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
                                        text: widget.supervisor.name,
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
                                      TextSpan(text: 'Gender\n'),
                                      TextSpan(
                                        text: widget.supervisor.gender
                                            .toUpperCase(),
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
                                      TextSpan(text: 'Age\n'),
                                      TextSpan(
                                        text:
                                            '${getYears(widget.supervisor.dateOfBirth).toString()} yrs',
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
                              TextSpan(text: 'Phone Number\n'),
                              TextSpan(
                                text: widget.supervisor.phone.toString(),
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
                                text: widget.supervisor.location,
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
                              TextSpan(text: 'Supervisor specializations\n'),
                            ],
                          ),
                        ),
                        Wrap(
                          spacing: 5.0, // gap between adjacent chips
                          runSpacing: 4.0, // gap between lines
                          children: List.generate(
                            supervisor.specializations.length,
                            (index) => Chip(
                              backgroundColor: kPrimaryColor,
                              elevation: 5,
                              labelStyle: TextStyle(color: Colors.white),
                              label:
                                  Text('${supervisor.specializations[index]}'),
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
