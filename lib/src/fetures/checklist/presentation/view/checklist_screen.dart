import 'dart:developer';

import 'package:actify/src/common_widgets/error_screen.dart';
import 'package:actify/src/fetures/checklist/data/providers/checklists_state_provider.dart';
import 'package:actify/src/fetures/checklist/presentation/view/dry_sampling_checklist.dart';
import 'package:actify/src/fetures/checklist/presentation/view/safety_checklist.dart';
import 'package:actify/src/fetures/checklist/presentation/view/wet_sampling_checklist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/acivity/activity.dart';
import '../../data/providers/checklist_providers.dart';

class CheckListScreen extends ConsumerStatefulWidget {
  final Activity activity;
  const CheckListScreen({super.key, required this.activity});

  @override
  ConsumerState<CheckListScreen> createState() => _CheckListScreenState();
}

class _CheckListScreenState extends ConsumerState<CheckListScreen> {
  Map<String, bool>? checklistsToGet;
  @override
  void initState() {
    super.initState();
    checklistsToGet = {
      'safety': widget.activity.safetyChecklist == '0',
      'dry': widget.activity.dryChecklist == '0',
      'wet': widget.activity.wetChecklist == '0',
    };
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final theme = Theme.of(context).colorScheme;
    final checklists = ref.watch(checklistsProvider(checklistsToGet!));

    final List<Widget> tabsContent = [];
    final List<Widget> tabs = [];
    if (checklistsToGet!['safety'] == true) {
      tabs.add(const Tab(
        child: Text('Safety'),
      ));
      tabsContent.add(const SafetyChecklist());
    }
    if (checklistsToGet!['dry'] == true) {
      tabs.add(const Tab(
        child: Text('Dry Sampling'),
      ));
      tabsContent.add(DrySamplingChecklist(activity: widget.activity,));
    }
    if (checklistsToGet!['wet'] == true) {
      tabs.add(const Tab(
        child: Text('Wet Sampling'),
      ));
      tabsContent.add(const WetSamplingChecklist());
    }

    return DefaultTabController(
        length: tabs.length,
        child: SafeArea(
            child: Scaffold(
                appBar: AppBar(
                  title: const Text('Checklists'),
                  bottom: TabBar(
                    labelColor: theme.onPrimary,
                    // labelStyle: const TextStyle(fontSize: 13),
                    unselectedLabelColor: Colors.white60,
                    dividerColor: Colors.white,
                    tabs: tabs,
                  ),
                ),
                body: checklists.when(
                    data: (data) {
                      return TabBarView(
                        children: tabsContent,
                      );
                    },
                    error: (error, stack) => ErrorScreen(message: '$error'),
                    loading: () => const Center(
                          child: CircularProgressIndicator(),
                        )))));
  }
}
