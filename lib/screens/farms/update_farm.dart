import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmasyst_admin_console/components/custom_dropdown_field.dart';
import 'package:farmasyst_admin_console/components/tags_feild.dart';
import 'package:farmasyst_admin_console/models/farm.dart';
import 'package:farmasyst_admin_console/models/farmer.dart';
import 'package:farmasyst_admin_console/notifiers/farmers_state.dart';
import 'package:farmasyst_admin_console/screens/farms/components/farms_module.dart';
import 'package:farmasyst_admin_console/utils/form_validator.dart';
import 'package:flutter/material.dart';
import 'package:farmasyst_admin_console/components/cus_text_form_field.dart';
import 'package:farmasyst_admin_console/components/image_chooser.dart';
import 'package:farmasyst_admin_console/components/main_button.dart';
import 'package:farmasyst_admin_console/responsive.dart';
import 'package:farmasyst_admin_console/services/constants.dart';
import 'package:provider/provider.dart';

class UpdateFarm extends StatefulWidget {
  final Farm farm;
  final DocumentSnapshot farmDocSnap;
  UpdateFarm({Key key, this.farm, this.farmDocSnap}) : super(key: key);

  @override
  _UpdateFarmState createState() => _UpdateFarmState();
}

class _UpdateFarmState extends State<UpdateFarm> {
  final _formKey = GlobalKey<FormState>();
  Farm farm;
  var profileImage;
  String errMsg = '';
  bool isLoading = false, showErrorMsg = false;

  // Define controllers
  TextEditingController _locationFieldController;
  TextEditingController _farmSizeFieldController;
  TextEditingController _descFieldController;
  // TextEditingController _emailFieldController;

  @override
  void initState() {
    farm = widget.farm;
    _locationFieldController = TextEditingController(text: farm.location);
    _farmSizeFieldController =
        TextEditingController(text: farm.farmSize.toString());
    _descFieldController = TextEditingController(text: farm.description);
    super.initState();
  }

  @override
  void dispose() {
    _farmSizeFieldController.dispose();
    _descFieldController.dispose();
    _locationFieldController.dispose();
    // _emailFieldController.dispose();
    super.dispose();
  }

  _updateFarm(BuildContext context) async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
        showErrorMsg = false;
      });
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();

        var results = await updateFarm(
          widget.farmDocSnap,
          farm: farm,
          profilePic: profileImage,
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
                  'Edit Farm Details',
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
                                    defaultNetworkImage: farm.pictures != null
                                        ? farm.pictures.length > 0
                                            ? farm.pictures.first
                                            : null
                                        : null,
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
                                          controller: _locationFieldController,
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
                                          controller: _farmSizeFieldController,
                                          type: TextInputType.number,
                                          prefixIcon: Icon(Icons.tag),
                                          hintText: 'Farm Size',
                                          onSaved: (value) {
                                            setState(() {
                                              farm.farmSize =
                                                  double.parse(value);
                                            });
                                          },
                                          validator: validateNumberValue,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Consumer<FarmersState>(builder:
                                            (context, farmersState, child) {
                                          var _items = farmersState.getFarmers
                                              .map((farmer) {
                                            Farmer _farmer =
                                                Farmer.fromMapObject(
                                                    farmer.data());
                                            return {
                                              'value': farmer.id,
                                              'label':
                                                  '${_farmer.name} @ ${_farmer.location} -  ${_farmer.phone} '
                                            };
                                          }).toList();
                                          return CustomDropDownField(
                                            prefixIcon: Icon(Icons.person),
                                            hint: 'Select Farmer',
                                            items: _items,
                                            value: farm.farmer['id'],
                                            onChanged: (value) {
                                              // setState(() {
                                              farmersState.getFarmers
                                                  .forEach((farmer) {
                                                if (value == farmer.id) {
                                                  Farmer _farmer =
                                                      Farmer.fromMapObject(
                                                          farmer.data());
                                                  setState(() {
                                                    farm.farmer = {
                                                      'id': farmer.id,
                                                      'name': _farmer.name,
                                                      'phone': _farmer.phone,
                                                      'location':
                                                          _farmer.location,
                                                      'specializations': _farmer
                                                          .specializations
                                                    };
                                                  });
                                                }
                                              });
                                              // });
                                            },
                                          );
                                        }),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              CustomTextFormField(
                                  maxLines: 5,
                                  minLines: 2,
                                  prefixIcon: Icon(Icons.description),
                                  hintText: 'Farm Description',
                                  controller: _descFieldController,
                                  onSaved: (value) {
                                    setState(() {
                                      farm.description = value;
                                    });
                                  },
                                  validator: emptyFeildValidator),
                              SizedBox(
                                height: 10,
                              ),
                              TagsField(
                                tagsArray: farm.crops,
                                onRemoved: (index) {
                                  setState(() {
                                    farm.crops.removeAt(index);
                                  });
                                },
                                onSubmitted: (value) {
                                  setState(() {
                                    farm.crops.add(value);
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
                                      _updateFarm(context);
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
