import 'package:farmasyst_admin_console/services/constants.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final Widget prefixIcon, suffixIcon;
  final String hintText;
  const CustomTextFormField(
      {Key key, this.prefixIcon, this.suffixIcon, this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        maxLines: 1,
        minLines: 1,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          filled: true,
          suffixIcon: suffixIcon,
          fillColor: kPrimaryLight.withOpacity(0.1),
          focusColor: kPrimaryLight.withOpacity(0.2),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          hintText: hintText != null ? hintText : '',
        ),
      ),
    );
  }
}
