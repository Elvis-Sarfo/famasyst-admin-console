import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmasyst_admin_console/components/gender_selector.dart';
import 'package:farmasyst_admin_console/components/tags_feild.dart';
import 'package:farmasyst_admin_console/models/farmer.dart';
import 'package:farmasyst_admin_console/screens/farmers/components/famer_module.dart';
import 'package:farmasyst_admin_console/services/database_services.dart';
import 'package:farmasyst_admin_console/utils/form_validator.dart';
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

class UpdateFarmer extends StatefulWidget {
  final Farmer farmer;
  final farmerDocSnap;
  UpdateFarmer({Key key, this.farmer, this.farmerDocSnap}) : super(key: key);

  @override
  _UpdateFarmerState createState() => _UpdateFarmerState();
}

class _UpdateFarmerState extends State<UpdateFarmer> {
  final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>();
  final _formKey = GlobalKey<FormState>();
  Farmer farmer;
  var profileImage;
  String errMsg = '';
  bool isLoading = false, showErrorMsg = false;

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
  void dispose() {
    _nameFieldController.dispose();
    _phoneFieldController.dispose();
    _locationFieldController.dispose();
    _numOfFarmsFieldController.dispose();
    super.dispose();
  }

  _updateFarmer(BuildContext context) async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
        showErrorMsg = false;
      });
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();
        var results = await updateFarmer(
          widget.farmerDocSnap,
          farmer: farmer,
          profilePic: profileImage,
          pictureName: farmer.name.replaceAll(' ', '_'),
        );
        if (results != 'saved') {
          setState(() {
            isLoading = false;
            if (results != 'saved') {
              errMsg = results;
              showErrorMsg = true;
            }
          });
        } else {
          Navigator.of(context).pop();
        }
      } else {
        setState(() {
          isLoading = false;
          showErrorMsg = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AlertDialog(
      content: Container(
        width: size.width * 0.7,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Edit Farmer Details',
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
            Expanded(
              child: Row(
                children: <Widget>[
                  if (isDesktop(context) || isTab(context))
                    Expanded(
                      flex: 1,
                      child: Image.asset(
                        'assets/images/logo.png',
                        height: size.height * 0.3,
                      ),
                    ),
                  Expanded(
                    flex: 2,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding:
                            EdgeInsets.only(right: !isMobile(context) ? 40 : 0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              if (isMobile(context))
                                Image.asset(
                                  'assets/images/logo.png',
                                  height: size.height * 0.3,
                                ),
                              Row(
                                children: [
                                  ImageChooser(
                                    defaultNetworkImage: farmer.picture,
                                    onImageSelected: (image) async {
                                      profileImage = image;
                                    },
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        CustomTextFormField(
                                          prefixIcon: Icon(Icons.person),
                                          hintText: 'Enter Full Name',
                                          controller: _nameFieldController,
                                          onSaved: (value) {
                                            setState(() {
                                              farmer.name = value;
                                            });
                                          },
                                          validator: emptyFeildValidator,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        GenderSelector(
                                          groupValue: farmer.gender,
                                          onChanged: (value) {
                                            setState(() {
                                              farmer.gender = value;
                                            });
                                          },
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        DatePicker(
                                          defaultDate: farmer.dateOfBirth,
                                          onSaved: (value) {
                                            setState(() {
                                              farmer.dateOfBirth =
                                                  DateTime.parse(value);
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              CustomTextFormField(
                                prefixIcon: Icon(Icons.phone),
                                hintText: 'Phone Number',
                                controller: _phoneFieldController,
                                type: TextInputType.phone,
                                onSaved: (value) {
                                  setState(() {
                                    farmer.phone = value;
                                  });
                                },
                                validator: validatePhone,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              CustomTextFormField(
                                  prefixIcon: Icon(Icons.place),
                                  hintText: 'Place of Residence',
                                  controller: _locationFieldController,
                                  onSaved: (value) {
                                    setState(() {
                                      farmer.location = value;
                                    });
                                  },
                                  validator: emptyFeildValidator),
                              SizedBox(
                                height: 10,
                              ),
                              CustomTextFormField(
                                type: TextInputType.number,
                                prefixIcon: Icon(Icons.grid_view),
                                hintText: 'Number of Farms',
                                controller: _numOfFarmsFieldController,
                                onSaved: (value) {
                                  setState(() {
                                    farmer.numFarms = int.parse(value);
                                  });
                                },
                                validator: emptyFeildValidator,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              // Tags
                              TagsField(
                                tagsArray: farmer.specializations,
                                onRemoved: (index) {
                                  setState(() {
                                    farmer.specializations.removeAt(index);
                                  });
                                },
                                onSubmitted: (value) {
                                  setState(() {
                                    farmer.specializations.add(value);
                                  });
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              if (showErrorMsg)
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(12.0),
                                  decoration: BoxDecoration(
                                    color: Colors.red.withOpacity(0.1),
                                    border: Border.all(width: 1),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(30),
                                    ),
                                  ),
                                  child: Text(errMsg),
                                ),
                              SizedBox(
                                height: 10,
                              ),
                              Wrap(
                                runSpacing: 10,
                                children: <Widget>[
                                  MainButton(
                                    isLoading: isLoading,
                                    title: 'Save',
                                    color: kPrimaryColor,
                                    tapEvent: () {
                                      _updateFarmer(context);
                                    },
                                  ),
                                  SizedBox(width: 10),
                                  MainButton(
                                    title: 'Cancel',
                                    color: kSecondaryColor,
                                    tapEvent: () {},
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
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
