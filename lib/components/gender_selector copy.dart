// import 'package:farmasyst_admin_console/components/labeled_radio_button.dart';
// import 'package:farmasyst_admin_console/services/constants.dart';
// import 'package:flutter/material.dart';

// class GenderSelector extends FormField<String> {
//   // final List options
//   final Function(String value) onChanged;
//   final FormFieldSetter<String> onSaved;
//   final TextEditingController controller;
//   GenderSelector({
//     Key key,
//     this.onChanged,
//     this.controller,
//     this.onSaved,
//   }) : super(
//           key: key,
//           initialValue:
//               controller != null ? controller.text : (initialValue ?? ''),
//           onSaved: onSaved,
//           // validator: validator,
//           // enabled: enabled ?? decoration?.enabled ?? true,
//           // autovalidateMode: autovalidate
//           // ? AutovalidateMode.always
//           // : (autovalidateMode ?? AutovalidateMode.disabled),
//           builder: (FormFieldState<String> field) {
//             final _GenderSelectorState state = field as _GenderSelectorState;
//             final InputDecoration effectiveDecoration = InputDecoration()
//                 .applyDefaults(Theme.of(field.context).inputDecorationTheme);
//             void onChangedHandler(String value) {
//               field.didChange(value);
//               if (onChanged != null) {
//                 onChanged(value);
//               }
//             }

//             return TextField(
//               controller: state._effectiveController,
//             );
//           },
//         );

//   @override
//   _GenderSelectorState createState() => _GenderSelectorState();
// }

// class _GenderSelectorState extends FormFieldState<String> {
//   String groupVal;

//   _onChangedHandler(String value) {
//     widget.onSaved(value);
//     widget.onChanged(value);
//     setState(() {
//       groupVal = value;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(
//         horizontal: 10,
//         vertical: 5,
//       ),
//       decoration: BoxDecoration(
//           color: kPrimaryLight.withOpacity(0.1),
//           border: Border.all(width: 1),
//           borderRadius: BorderRadius.all(Radius.circular(30))),
//       child: Row(
//         children: [
//           Icon(
//             Icons.wc,
//             color: Colors.grey,
//           ),
//           SizedBox(
//             width: 8,
//           ),
//           Text(
//             'Gender ',
//             style: TextStyle(
//               color: Colors.grey[600],
//               fontWeight: FontWeight.w400,
//             ),
//           ),
//           Expanded(
//             child: LabeledRadioButton(
//               label: 'Male',
//               padding: const EdgeInsets.symmetric(horizontal: 5.0),
//               value: 'male',
//               groupValue: groupVal,
//               onChanged: _onChangedHandler,
//             ),
//           ),
//           Expanded(
//             child: LabeledRadioButton(
//               label: 'Female',
//               padding: const EdgeInsets.symmetric(horizontal: 5.0),
//               value: 'female',
//               groupValue: groupVal,
//               onChanged: _onChangedHandler,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
