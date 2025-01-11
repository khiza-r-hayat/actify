import 'package:actify/src/fetures/checklist/data/providers/checklists_state_provider.dart';
import 'package:actify/src/models/checklist/checklists.dart';
import 'package:actify/src/services/pantheon_service/supervisor_data_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final checklistsProvider =
FutureProvider.family<Checklists, Map<String,bool>>((ref, checklistsToGet) async {
  final data = await SupervisorDataService.getChecklists(checklistsToGet);
  ref.read(checklistsStateProvider.notifier).setChecklists(data);
  return data;
});
