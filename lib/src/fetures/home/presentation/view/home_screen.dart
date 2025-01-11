import 'dart:developer';

import 'package:actify/src/common_widgets/error_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../activation/data/supervisor/providers/activity_providers.dart';
import '../../../activation/presentaion/view/activation_home_supervisor.dart';
import '../../../authentication/data/user_data_state_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userStateProvider);
    final activities = ref.watch(activitiesProvider(user!.id!));
    return Scaffold(
        appBar: AppBar(
          title: const Text('Nestle Activations System'),
        ),
        body: activities.when(
            data: (data) {
              log('data for activities at home: $data');
              return ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ActivationHomeSupervisorScreen(
                                      activity: data[index],
                                    )));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13),
                            color: Colors.white),
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('  ${data[index].activityTitle}'),
                            const Icon(Icons.arrow_forward_ios_rounded)
                          ],
                        ),
                      ),
                    );
                  });
            },
            error: (error, stack){
              log('Error: $error');
              log('Stack: $stack');
            return ErrorScreen(message: error.toString());},
            loading: () => const Center(
                  child: CircularProgressIndicator(),
                )));
  }
}
