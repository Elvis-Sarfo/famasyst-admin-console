import 'dart:io';

import 'package:farmasyst_admin_console/data_models/farmer.dart';
import 'package:farmasyst_admin_console/services/database_services.dart';
import 'package:flutter/material.dart';
import 'package:farmasyst_admin_console/components/cus_text_form_field.dart';
import 'package:farmasyst_admin_console/components/date_picker.dart';
import 'package:farmasyst_admin_console/components/image_chooser.dart';
import 'package:farmasyst_admin_console/components/main_button.dart';
import 'package:farmasyst_admin_console/components/labeled_radio_button.dart';
import 'package:farmasyst_admin_console/responsive.dart';
import 'package:farmasyst_admin_console/services/constants.dart';
import 'package:flutter_tags/flutter_tags.dart';

class AddNewFarmerDialog extends StatefulWidget {
  AddNewFarmerDialog({Key key}) : super(key: key);

  @override
  _AddNewFarmerDialogState createState() => _AddNewFarmerDialogState();
}

class _AddNewFarmerDialogState extends State<AddNewFarmerDialog> {
  List<String> _farmerSpecializations = ['Cocao', 'Tomatoe', 'Yam'];
  String _selectedDate = '', _genderRadioGroupVal = 'value';
  final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>();
  final _formKey = GlobalKey<FormState>();
  Farmer farmer = new Farmer();
  var profileImage;
  // Define controllers
  TextEditingController _dateFieldController;

  @override
  void initState() {
    _dateFieldController = TextEditingController(text: _selectedDate);
    super.initState();
  }

  @override
  void dispose() {
    _dateFieldController.dispose();
    super.dispose();
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
                  'Register Farmer',
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
                        'assets/images/main.png',
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
                                  'assets/images/main.png',
                                  height: size.height * 0.3,
                                ),
                              Row(
                                children: [
                                  ImageChooser(
                                    onImageSelected: (image) {
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
                                          onSaved: (value) {
                                            setState(() {
                                              farmer.name = value;
                                            });
                                          },
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'Name must not be empty';
                                            }
                                            return null;
                                          },
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 5,
                                          ),
                                          decoration: BoxDecoration(
                                              color: kPrimaryLight
                                                  .withOpacity(0.1),
                                              border: Border.all(width: 1),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30))),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.wc,
                                                color: Colors.grey,
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Text(
                                                'Gender ',
                                                style: TextStyle(
                                                  color: Colors.grey[600],
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              Expanded(
                                                child: LabeledRadioButton(
                                                  label: 'Male',
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 5.0),
                                                  value: 'male',
                                                  groupValue:
                                                      _genderRadioGroupVal,
                                                  onChanged: (String newValue) {
                                                    setState(() {
                                                      print(newValue);
                                                      _genderRadioGroupVal =
                                                          newValue;
                                                      farmer.gender = newValue;
                                                    });
                                                  },
                                                ),
                                              ),
                                              Expanded(
                                                child: LabeledRadioButton(
                                                  label: 'Female',
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 5.0),
                                                  value: 'female',
                                                  groupValue:
                                                      _genderRadioGroupVal,
                                                  onChanged: (String newValue) {
                                                    setState(() {
                                                      print(newValue);
                                                      _genderRadioGroupVal =
                                                          newValue;
                                                      farmer.gender = newValue;
                                                    });
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        DatePicker(
                                          onSaved: (value) {
                                            setState(() {
                                              farmer.name = value;
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
                                hintText: 'Telephone',
                                type: TextInputType.phone,
                                onSaved: (value) {
                                  setState(() {
                                    farmer.phone = value;
                                  });
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Phone number must not be empty';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              CustomTextFormField(
                                prefixIcon: Icon(Icons.place),
                                hintText: 'Place of Residence',
                                onSaved: (value) {
                                  setState(() {
                                    farmer.location = value;
                                  });
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Place of Residence must not be empty';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              CustomTextFormField(
                                type: TextInputType.number,
                                prefixIcon: Icon(Icons.grid_view),
                                hintText: 'Number of Farms',
                                onSaved: (value) {
                                  setState(() {
                                    farmer.location = value;
                                  });
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Number of Farms must not be empty';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              // Tags
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(12.0),
                                decoration: BoxDecoration(
                                  color: kPrimaryLight.withOpacity(0.1),
                                  border: Border.all(width: 1),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                ),
                                child: Tags(
                                  key: _tagStateKey,
                                  textField: TagsTextField(
                                    constraintSuggestion: false,
                                    suggestions: ['Cocoa', 'Yam'],
                                    helperText: 'Enter Specialiazation',
                                    hintText: 'Enter Specialiazation',
                                    //width: double.infinity, padding: EdgeInsets.symmetric(horizontal: 10),
                                    onSubmitted: (String str) {
                                      // Add item to the data source.
                                      setState(() {
                                        // required
                                        _farmerSpecializations.add(str);
                                      });
                                    },
                                  ),
                                  itemCount: _farmerSpecializations.length,
                                  itemBuilder: (int index) {
                                    final item = _farmerSpecializations[index];
                                    return Tooltip(
                                      message: item + 'farming',
                                      child: ItemTags(
                                        activeColor: kPrimaryColor,
                                        alignment: MainAxisAlignment.start,
                                        index: index,
                                        title: item,
                                        removeButton: ItemTagsRemoveButton(
                                          color: kPrimaryDark,
                                          backgroundColor: Colors.white,
                                          onRemoved: () {
                                            // Remove the item from the data source.
                                            setState(() {
                                              // required
                                              _farmerSpecializations
                                                  .removeAt(index);
                                            });
                                            //required
                                            return true;
                                          },
                                        ), // OR null,
                                        onPressed: (item) => print(item),
                                        onLongPressed: (item) => print(item),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Wrap(
                                runSpacing: 10,
                                children: <Widget>[
                                  MainButton(
                                    title: 'Save',
                                    color: kPrimaryColor,
                                    tapEvent: () async {
                                      if (_formKey.currentState.validate()) {
                                        _formKey.currentState.save();

                                        // add farmer specs
                                        farmer.specializations =
                                            _farmerSpecializations;

                                        // todo: add farmer image
                                        // var imgUrl = await DatabaseServices.uploadFile(
                                        //     file, 'farmer/');
                                        print('Saved');
                                      }
                                      print(farmer);
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
