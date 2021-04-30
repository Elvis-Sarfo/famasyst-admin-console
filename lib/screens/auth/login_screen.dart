import 'package:farmasyst_admin_console/components/clickable_text.dart';
import 'package:farmasyst_admin_console/components/cus_text_form_field.dart';
import 'package:farmasyst_admin_console/components/frame_container.dart';
import 'package:farmasyst_admin_console/components/main_button.dart';
import 'package:farmasyst_admin_console/responsive.dart';
import 'package:farmasyst_admin_console/services/auth_services.dart';
import 'package:farmasyst_admin_console/services/constants.dart';
import 'package:farmasyst_admin_console/utils/form_validator.dart';
import 'package:farmasyst_admin_console/utils/helper_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key key}) : super(key: key);
  // final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  String _email;
  String _password;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // final _formKey = GlobalKey<FormState>();
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: size.width,
            height: size.height,
            color: kPrimaryLight,
            child: Center(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                elevation: 20,
                child: Container(
                  padding: EdgeInsets.all(15),
                  width: size.width * 0.5,
                  height: size.height * 0.5,
                  // decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: <Widget>[
                          if (isDesktop(context) || isTab(context))
                            Expanded(
                              flex: 1,
                              child: Image.asset(
                                'assets/images/main.png',
                                height: size.height * 0.3,
                              ),
                            ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            flex: 2,
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    right: !isMobile(context) ? 40 : 0),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      if (isMobile(context))
                                        Image.asset(
                                          'assets/images/main.png',
                                          height: size.height * 0.3,
                                        ),
                                      Text(
                                        'Login',
                                        style: TextStyle(
                                          fontSize: 32,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      CustomTextFormField(
                                        prefixIcon: Icon(Icons.mail),
                                        hintText: 'Enter Email',
                                        type: TextInputType.phone,
                                        onSaved: (value) {
                                          _email = value;
                                        },
                                        validator: validateEmail,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      CustomTextFormField(
                                        prefixIcon: Icon(Icons.lock),
                                        isPasswordFeild: true,
                                        hintText: 'Password',
                                        onSaved: (value) {
                                          _password = value;
                                        },
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Place of password must not be empty';
                                          }
                                          return null;
                                        },
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      MainButton(
                                        title: 'Login',
                                        color: kPrimaryColor,
                                        tapEvent: () async {
                                          if (_formKey.currentState
                                              .validate()) {
                                            _formKey.currentState.save();
                                            var loginResults = await Auth
                                                .loginWithEmailAndPassword(
                                              _email,
                                              _password,
                                            );
                                            if (loginResults
                                                is UserCredential) {
                                              print('success');
                                              sendToPage(
                                                  context, FrameContainer());
                                            } else {
                                              print(loginResults);
                                            }
                                          }
                                        },
                                      ),
                                      ClickableText(
                                        children: [
                                          TextSpan(
                                            text: 'Dont have an account?  ',
                                            style:
                                                TextStyle(color: kPrimaryColor),
                                          ),
                                          TextSpan(
                                            text: 'Register As Investor',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: kPrimaryDark,
                                            ),
                                          ),
                                        ],
                                        onPress: () {
                                          sendToPage(context, FrameContainer());
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Login method
  // _login(
  //   context,
  //   formKey,
  //   Map credentials,
  // ) async {
  //   if (_formKey.currentState.validate()) {
  //     Auth.login();
  //   }
  // }
}
