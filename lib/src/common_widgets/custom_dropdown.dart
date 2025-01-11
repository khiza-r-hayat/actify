import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../theme/theme.dart';

class CustomDropDown extends StatelessWidget {
  final void Function(String) onUpdate;
  List<String> items;
  String val;
  String? hintText;

  BoxConstraints? constraints;

  CustomDropDown(
      {super.key,
        required this.val,
        required this.items,
        this.hintText,
        required this.onUpdate,
        this.constraints,
      });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultConstraints = BoxConstraints( maxHeight: hintText == null ? 45 : 60,maxWidth: double.infinity);
    return Container(
      constraints: constraints ?? defaultConstraints,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.blue.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(5)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          iconStyleData: IconStyleData(
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: theme.primaryColor,
              )),
          dropdownStyleData: DropdownStyleData(
            maxHeight: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: theme.colorScheme.inversePrimary,
            ),
            elevation: 1,
            scrollbarTheme: ScrollbarThemeData(
              radius: const Radius.circular(20),
              thickness: MaterialStateProperty.all(6),
              thumbVisibility: MaterialStateProperty.all(true),
            ),
          ),
          hint: Text(
            'Select Item',
            style: TextStyle(
              fontSize: constraints != null ? 13  : 14,
              color: Theme.of(context).hintColor,
            ),
          ),
          selectedItemBuilder: (context) {
            return items.map(
                  (item) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      hintText == null
                          ? const SizedBox.shrink()
                          : Text(
                        "$hintText",
                        style: TextStyle(
                          fontSize: 9,
                          color: Theme.of(context).unselectedWidgetColor,
                        ),
                      ),
                      Text(
                        val,
                        style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: constraints != null ? 13  : 16,
                            fontWeight: FontWeight.w500,
                            color: lightColorScheme.secondary),
                        maxLines: 1,
                      ),
                    ],
                  ),
                );
              },
            ).toList();
          },
          items: items
              .map((String item) => DropdownMenuItem<String>(
            value: item,
            child: Text(item,
                style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontSize: constraints != null ? 13  : 14,
                    fontWeight: FontWeight.w500,
                    color: lightColorScheme.secondary)),
          ))
              .toList(),
          value: val,
          onChanged: (String? value) {
            onUpdate(value!);
          },
          buttonStyleData: const ButtonStyleData(
            padding: EdgeInsets.only(right: 15),
          ),
        ),
      ),
    );
  }
}
