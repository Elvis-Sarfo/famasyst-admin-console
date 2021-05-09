import 'package:farmasyst_admin_console/components/custom_dropdown_field.dart';
import 'package:farmasyst_admin_console/components/tags_feild.dart';
import 'package:farmasyst_admin_console/models/farm.dart';
import 'package:farmasyst_admin_console/screens/farms/components/farms_module.dart';
import 'package:farmasyst_admin_console/utils/form_validator.dart';
import 'package:flutter/material.dart';
import 'package:farmasyst_admin_console/components/cus_text_form_field.dart';
import 'package:farmasyst_admin_console/components/image_chooser.dart';
import 'package:farmasyst_admin_console/components/main_button.dart';
import 'package:farmasyst_admin_console/responsive.dart';
import 'package:farmasyst_admin_console/services/constants.dart';

class AddNewFarmDialog extends StatefulWidget {
  AddNewFarmDialog({Key key}) : super(key: key);

  @override
  _AddNewFarmDialogState createState() => _AddNewFarmDialogState();
}

class _AddNewFarmDialogState extends State<AddNewFarmDialog> {
  List<String> _farmInterests = ['Cocao', 'Tomatoe', 'Yam'];
  String errMsg = '';
  final _formKey = GlobalKey<FormState>();
  Farm farm = new Farm();
  String _farmer;
  var profileImage;
  bool showErrorMsg = false, isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  saveFarm() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
        showErrorMsg = false;
      });
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();

        // add farm specs
        farm.crops = _farmInterests;
        var results = await saveNewFarm(
          farm,
          profilePic: profileImage,
          pictureName: farm.farmId.replaceAll(' ', '_'),
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
                  'Register Farm',
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
                                          prefixIcon: Icon(Icons.place),
                                          hintText: 'Locaiton',
                                          onSaved: (value) {
                                            setState(() {
                                              farm.location = value;
                                            });
                                          },
                                          validator: emptyFeildValidator,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        CustomTextFormField(
                                          type: TextInputType.number,
                                          prefixIcon: Icon(Icons.tag),
                                          hintText: 'Farm Size',
                                          onSaved: (value) {
                                            setState(() {
                                              farm.farmSize =
                                                  double.parse(value);
                                            });
                                          },
                                          validator: validateEmail,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        CustomDropDownField(
                                          prefixIcon: Icon(Icons.person),
                                          hint: 'Select Farmer',
                                          items: [
                                            'Farmer 1',
                                            'Farmer 2',
                                            'Farmer 3'
                                          ],
                                          value: farm.farmerId,
                                          onChanged: (value) {
                                            setState(() {
                                              farm.farmerId = value
                                                  .toString()
                                                  .toLowerCase();
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
                              SizedBox(
                                height: 10,
                              ),
                              CustomTextFormField(
                                maxLines: 5,
                                minLines: 3,
                                prefixIcon: Icon(Icons.description),
                                hintText: 'Farm Description',
                                onSaved: (value) {
                                  setState(() {
                                    farm.description = value;
                                  });
                                },
                                validator: emptyFeildValidator,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TagsField(
                                hintText: 'Add Crops in Farm',
                                tagsArray: _farmInterests,
                                onRemoved: (index) {
                                  setState(() {
                                    _farmInterests.removeAt(index);
                                  });
                                },
                                onSubmitted: (value) {
                                  setState(() {
                                    _farmInterests.add(value);
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
                                    tapEvent: saveFarm,
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
