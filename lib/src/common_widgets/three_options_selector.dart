import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class ThreeOptionSelector extends StatefulWidget {

  final ValueChanged<String> onOptionSelected;

  const ThreeOptionSelector({super.key,required this.onOptionSelected});

  @override
  State<ThreeOptionSelector> createState() => _ThreeOptionSelectorState();
}

class _ThreeOptionSelectorState extends State<ThreeOptionSelector> {
  late List<bool> _selections;

  @override
  void initState() {
    super.initState();
    // Initialize the selections to false (none selected)
    _selections = [false, false, false];
  }

    String _getOptionText(int index) {
      switch (index) {
        case 0:
          return 'Yes';
        case 1:
          return 'No';
        case 2:
          return 'N/A';
        default:
          return '';
      }
    }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ToggleButtons(
      isSelected: _selections,
      constraints: const BoxConstraints(maxWidth: 100,maxHeight: 100),
      onPressed: (int index) {
        setState(() {
          // Toggle the selection state
          for (int buttonIndex = 0;
              buttonIndex < _selections.length;
              buttonIndex++) {
            _selections[buttonIndex] = buttonIndex == index;
          }
        });

        widget.onOptionSelected(_getOptionText(index));
      },
      selectedColor: Theme.of(context).colorScheme.onPrimary,
      color: Colors.black,
      fillColor: Theme.of(context).colorScheme.primary,
      borderColor: Colors.grey,
      selectedBorderColor: Theme.of(context).colorScheme.primary,
      borderRadius: BorderRadius.circular(5.0),
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text('Yes',style: TextStyle(fontSize: theme.textTheme.displaySmall!.fontSize)),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(' No ',style: TextStyle(fontSize: theme.textTheme.displaySmall!.fontSize)),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text('N/A',style: TextStyle(fontSize: theme.textTheme.displaySmall!.fontSize),),
        ),
      ],
    );
  }
}
