import 'package:actify/src/theme/theme.dart';
import 'package:flutter/material.dart';

import 'no_response/no_response_screen.dart';

class StartPitchScreen extends StatelessWidget {
  const StartPitchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Start Pitch'),
      ),
      body: Padding(
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
                    Text('Pitch'),
                    SizedBox(
                      height: 12,
                    ),
                    Text('This is a test pitch for activation.'),
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
                    color: theme.colorScheme.primary),
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.all(8),
                child: Text(
                  'CONTINUE',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: theme.colorScheme.onPrimary,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NoResponseScreen()));
              },
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11),
                    color: theme.colorScheme.error),
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.all(8),
                child: Text(
                  'NO RESPONSE',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: theme.colorScheme.onPrimary,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
