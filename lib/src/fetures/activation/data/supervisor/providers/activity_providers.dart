import 'package:actify/src/models/acivity/activity.dart';
import 'package:actify/src/services/pantheon_service/supervisor_data_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final activitiesProvider =
    FutureProvider.family<List<Activity>, String>((ref, supervisorId) async {
  return await SupervisorDataService.getActivities(supervisorId);
});
