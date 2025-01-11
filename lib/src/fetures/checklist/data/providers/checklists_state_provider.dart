import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/checklist/checklists.dart';


class ChecklistsStateNotifier extends StateNotifier<Checklists?> {
  ChecklistsStateNotifier() : super(null);

  void setChecklists(Checklists checklists) {
    state = checklists;
  }

  void clearChecklists() {
    state = null;
  }

}

final checklistsStateProvider = StateNotifierProvider<ChecklistsStateNotifier, Checklists?>((ref) {
  return ChecklistsStateNotifier();
});