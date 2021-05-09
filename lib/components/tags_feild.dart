import 'package:farmasyst_admin_console/services/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';

class TagsField extends StatelessWidget {
  final List tagsArray;
  final String hintText;
  final Function(dynamic) onSubmitted;
  final Function(int) onRemoved;
  const TagsField({
    Key key,
    this.tagsArray,
    this.onSubmitted,
    this.onRemoved,
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
        key: key,
        textField: TagsTextField(
          constraintSuggestion: false,
          suggestions: ['Cocoa', 'Yam'],
          helperText: hintText,
          hintText: hintText,
          //width: double.infinity, padding: EdgeInsets.symmetric(horizontal: 10),
          onSubmitted: onSubmitted,
        ),
        itemCount: tagsArray != null ? tagsArray.length : 0,
        itemBuilder: (int index) {
          final item = tagsArray[index];
          return Tooltip(
            message: '$item',
            child: ItemTags(
              activeColor: kPrimaryColor,
              alignment: MainAxisAlignment.start,
              index: index,
              title: item,
              removeButton: ItemTagsRemoveButton(
                  color: kPrimaryDark,
                  backgroundColor: Colors.white,
                  onRemoved: () {
                    onRemoved(index);
                    return true;
                  }), // OR null,
              onPressed: (item) => print(item),
              onLongPressed: (item) => print(item),
            ),
          );
        },
      ),
    );
  }
}
