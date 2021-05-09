import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmasyst_admin_console/components/custom_dropdown_field.dart';
import 'package:farmasyst_admin_console/components/tags_feild.dart';
import 'package:farmasyst_admin_console/models/investor.dart';
import 'package:farmasyst_admin_console/screens/investors/components/investors_module.dart';
import 'package:farmasyst_admin_console/utils/form_validator.dart';
import 'package:flutter/material.dart';
import 'package:farmasyst_admin_console/components/cus_text_form_field.dart';
import 'package:farmasyst_admin_console/components/image_chooser.dart';
import 'package:farmasyst_admin_console/components/main_button.dart';
import 'package:farmasyst_admin_console/responsive.dart';
import 'package:farmasyst_admin_console/services/constants.dart';

class UpdateInvestor extends StatefulWidget {
  final Investor investor;
  final DocumentSnapshot investorDocSnap;
  UpdateInvestor({Key key, this.investor, this.investorDocSnap})
      : super(key: key);

  @override
  _UpdateInvestorState createState() => _UpdateInvestorState();
}

class _UpdateInvestorState extends State<UpdateInvestor> {
  final _formKey = GlobalKey<FormState>();
  Investor investor;
  var profileImage;
  String errMsg = '';
  bool isLoading = false, showErrorMsg = false;

  // Define controllers
  TextEditingController _nameFieldController;
  TextEditingController _phoneFieldController;
  TextEditingController _locationFieldController;
  TextEditingController _emailFieldController;

  @override
  void initState() {
    investor = widget.investor;
    _nameFieldController = TextEditingController(text: investor.name);
    _phoneFieldController = TextEditingController(text: investor.phone);
    _locationFieldController = TextEditingController(text: investor.location);
    _emailFieldController = TextEditingController(text: investor.email);
    // _numOfFarmsFieldController =
    //     TextEditingController(text: investor.numFarms.toString());
    super.initState();
  }

  @override
  void dispose() {
    _nameFieldController.dispose();
    _phoneFieldController.dispose();
    _locationFieldController.dispose();
    _emailFieldController.dispose();
    super.dispose();
  }

  _updateInvestor(BuildContext context) async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
        showErrorMsg = false;
      });
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();
        var results = await updateInvestor(
          widget.investorDocSnap,
          investor: investor,
          profilePic: profileImage,
          pictureName: investor.name.replaceAll(' ', '_'),
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
                  'Edit Investor Details',
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
                                    defaultNetworkImage: investor.picture,
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
                                              investor.name = value;
                                            });
                                          },
                                          validator: emptyFeildValidator,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        CustomTextFormField(
                                          controller: _emailFieldController,
                                          type: TextInputType.number,
                                          prefixIcon: Icon(Icons.mail),
                                          hintText: 'Enter Email',
                                          onSaved: (value) {
                                            setState(() {
                                              investor.email = value;
                                            });
                                          },
                                          validator: validateEmail,
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
                                              investor.phone = value;
                                            });
                                          },
                                          validator: validatePhone,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              CustomDropDownField(
                                prefixIcon: Icon(Icons.category),
                                hint: 'Select Registration Type',
                                items: [
                                  {
                                    'value': 'company',
                                    'label': 'Company',
                                  },
                                  {
                                    'value': 'croup',
                                    'label': 'Group',
                                  },
                                  {
                                    'value': 'individual',
                                    'label': 'Individual'
                                  },
                                ],
                                value: investor.type,
                                onChanged: (value) {
                                  setState(() {
                                    investor.type =
                                        value.toString().toLowerCase();
                                  });
                                },
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
                                      investor.location = value;
                                    });
                                  },
                                  validator: emptyFeildValidator),
                              SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TagsField(
                                tagsArray: investor.interests,
                                onRemoved: (index) {
                                  setState(() {
                                    investor.interests.removeAt(index);
                                  });
                                },
                                onSubmitted: (value) {
                                  setState(() {
                                    investor.interests.add(value);
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
                                      _updateInvestor(context);
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
