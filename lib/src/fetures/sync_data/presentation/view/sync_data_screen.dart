import 'dart:ffi';

import 'package:actify/src/theme/theme.dart';
import 'package:flutter/material.dart';

class SyncDataScreen extends StatelessWidget {
  const SyncDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Sync Data'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                width: double.infinity,
                color: lightColorScheme.onPrimary,
                child: Column(
                  children: [
                    Text('Records Saved Offline'),
                    SizedBox(height: 12,),
                    Text(
                      'No records found!',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
