import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmasyst_admin_console/models/farmer.dart';
import 'package:farmasyst_admin_console/modules/famer_module.dart';
import 'package:farmasyst_admin_console/services/database_services.dart';
import 'package:farmasyst_admin_console/utils/form_validator.dart';
import 'package:farmasyst_admin_console/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:farmasyst_admin_console/components/cus_text_form_field.dart';
import 'package:farmasyst_admin_console/components/date_picker.dart';
import 'package:farmasyst_admin_console/components/image_chooser.dart';
import 'package:farmasyst_admin_console/components/main_button.dart';
import 'package:farmasyst_admin_console/components/labeled_radio_button.dart';
import 'package:farmasyst_admin_console/responsive.dart';
import 'package:farmasyst_admin_console/services/constants.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:intl/intl.dart';

class ViewFarmer extends StatefulWidget {
  final Farmer farmer;
  final String farmerId;
  ViewFarmer({Key key, this.farmer, this.farmerId}) : super(key: key);

  @override
  _ViewFarmerState createState() => _ViewFarmerState();
}

class _ViewFarmerState extends State<ViewFarmer> {
  final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>();
  Farmer farmer;
  var profileImage;
  bool isLoading = false;

  // Define controllers
  TextEditingController _nameFieldController;
  TextEditingController _phoneFieldController;
  TextEditingController _locationFieldController;
  TextEditingController _numOfFarmsFieldController;

  @override
  void initState() {
    farmer = widget.farmer;
    _nameFieldController = TextEditingController(text: farmer.name);
    _phoneFieldController = TextEditingController(text: farmer.phone);
    _locationFieldController = TextEditingController(text: farmer.location);
    _numOfFarmsFieldController =
        TextEditingController(text: farmer.numFarms.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AlertDialog(
      content: Container(
        width: size.width * 0.3,
        constraints: BoxConstraints(minHeight: size.height * 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Farmer Details',
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
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (farmer.picture != null)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(
                            farmer.picture,
                            width: 150,
                            height: 150,
                            fit: BoxFit.fill,
                          ),
                        ),
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          style: TextStyle(
                              fontSize: 16,
                              height: 1.5,
                              color: Colors.black54,
                              fontWeight: FontWeight.w600),
                          children: <TextSpan>[
                            TextSpan(text: 'Name\n'),
                            TextSpan(
                              text: widget.farmer.name,
                              style: TextStyle(
                                  fontSize: 20,
                                  height: 1.5,
                                  color: kPrimaryDark,
                                  fontWeight: FontWeight.bold),
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
                          style: TextStyle(
                              fontSize: 16,
                              height: 1.5,
                              color: Colors.black54,
                              fontWeight: FontWeight.w600),
                          children: <TextSpan>[
                            TextSpan(text: 'Gender\n'),
                            TextSpan(
                              text: widget.farmer.gender.toUpperCase(),
                              style: TextStyle(
                                  fontSize: 20,
                                  height: 1.5,
                                  color: kPrimaryDark,
                                  fontWeight: FontWeight.bold),
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
                          style: TextStyle(
                              fontSize: 16,
                              height: 1.5,
                              color: Colors.black54,
                              fontWeight: FontWeight.w600),
                          children: <TextSpan>[
                            TextSpan(text: 'Age\n'),
                            TextSpan(
                              text: getYears(widget.farmer.dateOfBirth)
                                  .toString(),
                              style: TextStyle(
                                fontSize: 20,
                                height: 1.5,
                                color: kPrimaryDark,
                                fontWeight: FontWeight.bold,
                              ),
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
                          style: TextStyle(
                              fontSize: 16,
                              height: 1.5,
                              color: Colors.black54,
                              fontWeight: FontWeight.w600),
                          children: <TextSpan>[
                            TextSpan(text: 'Phone Number\n'),
                            TextSpan(
                              text: widget.farmer.phone.toString(),
                              style: TextStyle(
                                fontSize: 20,
                                height: 1.5,
                                color: kPrimaryDark,
                                fontWeight: FontWeight.bold,
                              ),
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
                          style: TextStyle(
                              fontSize: 16,
                              height: 1.5,
                              color: Colors.black54,
                              fontWeight: FontWeight.w600),
                          children: <TextSpan>[
                            TextSpan(text: 'Location\n'),
                            TextSpan(
                              text: widget.farmer.location,
                              style: TextStyle(
                                fontSize: 20,
                                height: 1.5,
                                color: kPrimaryDark,
                                fontWeight: FontWeight.bold,
                              ),
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
                          style: TextStyle(
                              fontSize: 16,
                              height: 1.5,
                              color: Colors.black54,
                              fontWeight: FontWeight.w600),
                          children: <TextSpan>[
                            TextSpan(text: 'Number of Farms\n'),
                            TextSpan(
                              text: widget.farmer.numFarms.toString(),
                              style: TextStyle(
                                fontSize: 20,
                                height: 1.5,
                                color: kPrimaryDark,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          style: TextStyle(
                              fontSize: 16,
                              height: 1.5,
                              color: Colors.black54,
                              fontWeight: FontWeight.w600),
                          children: <TextSpan>[
                            TextSpan(text: 'Farmer specializations\n'),
                          ],
                        ),
                      ),
                      Wrap(
                        spacing: 5.0, // gap between adjacent chips
                        runSpacing: 4.0, // gap between lines
                        children: List.generate(
                          farmer.specializations.length,
                          (index) => Chip(
                            backgroundColor: kPrimaryColor,
                            elevation: 5,
                            labelStyle: TextStyle(color: Colors.white),
                            label: Text('${farmer.specializations[index]}'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
