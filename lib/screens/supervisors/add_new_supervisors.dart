import 'package:farmasyst_admin_console/components/gender_selector.dart';
import 'package:farmasyst_admin_console/components/tags_feild.dart';
import 'package:farmasyst_admin_console/models/supervisor.dart';
import 'package:farmasyst_admin_console/screens/supervisors/components/supervisor_module.dart';
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

class AddNewSupervisorDialog extends StatefulWidget {
  AddNewSupervisorDialog({Key key}) : super(key: key);

  @override
  _AddNewSupervisorDialogState createState() => _AddNewSupervisorDialogState();
}

class _AddNewSupervisorDialogState extends State<AddNewSupervisorDialog> {
  List<String> _supervisorSpecializations = ['Cocao', 'Tomatoe', 'Yam'];
  String _selectedDate = '', _genderRadioGroupVal = 'value', errMsg = '';
  final _formKey = GlobalKey<FormState>();
  Supervisor supervisor = new Supervisor();
  var profileImage;
  bool showErrorMsg = false, isLoading = false;
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

  saveSupervisor() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
        showErrorMsg = false;
      });
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();

        // add supervisor specs
        supervisor.specializations = _supervisorSpecializations;
        var results = await saveNewSupervisor(
          supervisor,
          profilePic: profileImage,
          pictureName: supervisor.name.replaceAll(' ', '_'),
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
                  'Register Supervisor',
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
                                          onSaved: (value) {
                                            setState(() {
                                              supervisor.name = value;
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
                                        GenderSelector(
                                          onChanged: (value) {
                                            setState(() {
                                              supervisor.gender = value;
                                            });
                                          },
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        DatePicker(
                                          onSaved: (value) {
                                            setState(() {
                                              supervisor.dateOfBirth =
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
                                type: TextInputType.number,
                                prefixIcon: Icon(Icons.mail),
                                hintText: 'Enter Email',
                                onSaved: (value) {
                                  setState(() {
                                    supervisor.email = value;
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
                                type: TextInputType.phone,
                                onSaved: (value) {
                                  setState(() {
                                    supervisor.phone = value;
                                  });
                                },
                                onChange: (value) {
                                  setState(() {
                                    showErrorMsg = false;
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
                                onSaved: (value) {
                                  setState(() {
                                    supervisor.location = value;
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
                              // Tags
                              TagsField(
                                // key: _supervisorSpecializationsKey,
                                tagsArray: _supervisorSpecializations,
                                onRemoved: (index) {
                                  setState(() {
                                    _supervisorSpecializations.removeAt(index);
                                  });
                                },
                                onSubmitted: (value) {
                                  setState(() {
                                    _supervisorSpecializations.add(value);
                                  });
                                },
                              ),
                              SizedBox(
                                height: 20,
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
                                    tapEvent: saveSupervisor,
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
