
import 'dart:developer';

import 'package:datetime_picker_field_platform/datetime_picker_field_platform.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../common_widgets/custom_dropdown.dart';
import '../../../../common_widgets/three_options_selector.dart';
import '../../../../models/acivity/activity.dart';
import '../../../../theme/theme.dart';
import '../../data/providers/checklists_state_provider.dart';

class DrySamplingChecklist extends ConsumerStatefulWidget{

  final Activity activity;

  const DrySamplingChecklist({super.key,required this.activity});

  @override
  ConsumerState<DrySamplingChecklist> createState() => _DrySamplingChecklistState();
}

class _DrySamplingChecklistState extends ConsumerState<DrySamplingChecklist> {
  String location = 'Lahore';

  TextEditingController selectedDate = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final checklist = ref.watch(checklistsStateProvider)!.dry;
    log('DryChecklist: $checklist');
    final startDate = DateFormat('EEE, MM/dd/yyyy - HH:mm').parse( widget.activity.activityStartDate!);
    final endDate = DateFormat('EEE, MM/dd/yyyy - HH:mm').parse( widget.activity.activityEndDate!);

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DateTimeFieldPlatform(
                onConfirm: (value) {
                  var val =
                  DateFormat('yyyy-MM-dd').format(value);
                  selectedDate.text = val;
                  debugPrint('selected date ${selectedDate.text}');
                },
                title: 'Select Date',
                mode: DateMode.date,
                controller: selectedDate,
                inputStyle: const TextStyle(fontSize: 12,),
                decoration: InputDecoration(
                    hintText: " YYYY-MM-DD",
                    contentPadding: EdgeInsets.zero,
                    constraints: BoxConstraints(maxWidth: size.width*0.3,maxHeight: size.height*0.04),
                    suffixIcon: Icon(
                      Icons.calendar_today_outlined,
                      color: lightColorScheme.onPrimary,
                      size: 15,
                    ),
                    hintStyle:
                    const TextStyle(color: Colors.grey,fontSize: 11),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                            Radius.circular(3.0)),
                        borderSide: BorderSide(
                          width: 0.2,
                          color: lightColorScheme.primary,
                        ))),
                maximumDate:endDate,
                // DateTime.now().add(const Duration(days: 720)),
                minimumDate: startDate,
              ),
              SizedBox(
                width: size.width*0.35,
                child: CustomDropDown(items: const ['Lahore','Karachi','Islamabad'],val: location,onUpdate: (value){
                  location = value;
                },constraints: BoxConstraints(maxWidth: size.width*0.3,maxHeight: size.height*0.04),),
              ),
            ],),
          const SizedBox(height: 12,),
          Expanded(
            child: ListView.builder(
                itemCount: checklist!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                            child: ThreeOptionSelector(onOptionSelected: (value){
                              log('selected value : $value');
                            },)
                        ),
                        Expanded(
                          flex: 2, child: Text('${checklist[index].value}',style: theme.textTheme.displaySmall,),)
                      ],
                    ),
                  );
                }),
          ),
          const SizedBox(height: 12,),
          GestureDetector(
            onTap: () {

            },
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11),
                  color: theme.colorScheme.primary),
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.all(8),
              child: Text(
                'Save',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: theme.colorScheme.onPrimary,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
