import 'package:farmasyst_admin_console/services/constants.dart';
import 'package:flutter/material.dart';

class CustomDropDownField extends StatelessWidget {
  final String value;
  final List<String> items;
  final Color dropdownColor;
  final Function(dynamic value) onChanged;
  final String hint;
  final Widget prefixIcon;
  const CustomDropDownField({
    this.value,
    @required this.items,
    this.dropdownColor,
    this.hint,
    @required this.onChanged,
    this.prefixIcon,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      builder: (FormFieldState<String> state) {
        return InputDecorator(
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            filled: true,
            fillColor: kPrimaryLight.withOpacity(0.1),
            focusColor: kPrimaryLight.withOpacity(0.2),
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            hintText: hint != null ? hint : '',
            errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
          ),
          isEmpty: value == '',
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              value: value,
              isDense: true,
              isExpanded: true,
              onChanged: (newValue) => onChanged(newValue),
              items: items.map((value) {
                return DropdownMenuItem(
                  value: value.toLowerCase(),
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
