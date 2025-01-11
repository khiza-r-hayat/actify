

import 'package:flutter/material.dart';

import '../../../../../../constants/colors.dart';
import '../../../../../../theme/theme.dart';

class NoResponseScreen extends StatelessWidget{
  const NoResponseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('Submit Form'),),body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              color: lightColorScheme.onPrimary,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('No response from customer'),
                  SizedBox(height: 12,),
                  Text("Press 'submit' to save contact without customer data."),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11),
                  color: primaryColor),
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.all(8),
              child: Text('CONTINUE',textAlign: TextAlign.center,style: TextStyle(color: lightColorScheme.onPrimary,fontWeight: FontWeight.bold),),
            ),
          ),
        ],
      ),
    ),);
  }
}