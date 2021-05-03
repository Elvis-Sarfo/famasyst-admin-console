import 'package:farmasyst_admin_console/services/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  final Function(String value) onChange, validator, onSaved;
  DateTime defaultDate;
  DatePicker({
    Key key,
    this.onChange,
    this.onSaved,
    this.validator,
    this.defaultDate,
  }) : super(key: key);

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  TextEditingController _dateFieldController;

  @override
  void initState() {
    var defaultDateString = widget.defaultDate != null
        ? DateFormat('yyyy-MM-dd').format(widget.defaultDate)
        : '';
    _dateFieldController = TextEditingController(text: defaultDateString);
    super.initState();
  }

  @override
  void dispose() {
    _dateFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        controller: _dateFieldController,
        onChanged: widget.onChange ?? (value) {},
        validator: widget.validator ??
            (value) {
              return null;
            },
        onSaved: widget.onSaved ?? (value) {},
        readOnly: true,
        maxLines: 1,
        minLines: 1,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.today),
          filled: true,
          suffixIcon: IconButton(
            padding: EdgeInsets.all(0),
            iconSize: 26,
            splashRadius: 20,
            highlightColor: kPrimaryColor.withOpacity(0.3),
            hoverColor: kPrimaryColor.withOpacity(0.3),
            icon: Icon(
              Icons.date_range,
              color: kPrimaryColor,
            ),
            onPressed: () async {
              return await showDatePicker(
                context: context,
                initialDate: widget.defaultDate ?? DateTime.now(),
                firstDate: DateTime(1900, 1),
                lastDate: DateTime.now(),
                builder: (BuildContext context, Widget child) {
                  return Theme(
                    data: ThemeData.light().copyWith(
                      colorScheme: ColorScheme.light().copyWith(
                        primary: kPrimaryColor,
                      ),
                    ),
                    child: child,
                  );
                },
              ).then(
                (value) {
                  if (value != null) {
                    // _dateTime = value;
                    var formatter = new DateFormat('yyyy-MM-dd');
                    _dateFieldController.text = formatter.format(value);
                  }
                },
              );
            },
          ),
          fillColor: kPrimaryLight.withOpacity(0.1),
          focusColor: kPrimaryLight.withOpacity(0.2),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          hintText: 'Select Date',
        ),
      ),
    );
  }
}
