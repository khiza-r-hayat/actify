import 'dart:convert';
import 'dart:io';

import 'package:actify/src/constants/strings.dart';
import 'package:actify/src/models/acivity/activity.dart';
import 'package:actify/src/models/checklist/checklist_item.dart';
import 'package:actify/src/models/checklist/checklists.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SupervisorDataService {
  static final Future<SharedPreferences> _prefs =
      SharedPreferences.getInstance();

  static final baseURL = dotenv.env['BASE_URL']!;
  static final clientId = dotenv.env['CLIENT_ID']!;
  static final clientSecret = dotenv.env['CLIENT_SECRET']!;

  static Future<List<Activity>> getActivities(String supervisorId) async {
    final prefs = await _prefs;

    final token = prefs.getString(Strings.jwt);

    final url =
        '${baseURL}api/views/supervisor_activities/$supervisorId/active?_format=json';

    final response = await http
        .get(Uri.parse(url));
    final List<Activity> activities = [];
    final data = response.body;
    for(var activity in jsonDecode(data)){
     activities.add(Activity.fromJson(activity));
    }

    return activities;
  }

  static Future<Checklists> getChecklists(Map<String,bool> checklistsToGet)async {
     List<ChecklistItem> safety = [];
     List<ChecklistItem> dry = [];
     List<ChecklistItem> wet = [];

    if(checklistsToGet['safety'] == true){
      safety = await getSafetyChecklist();
    }if(checklistsToGet['wet'] == true){
      wet = await getWetSamplingChecklist();
    }if(checklistsToGet['dry'] == true){
      dry = await getDrySamplingChecklist();
    }
    Checklists checklists = Checklists(safety: safety,wet: wet,dry: dry);
    log('checklists: $checklists');

    return checklists;
  }

  static getSafetyChecklist() async {
    final url =
        '${baseURL}api/views/safety_checklist?_format=json';

    final response = await http
        .get(Uri.parse(url));

    final List<ChecklistItem> checklist = [];

    final data = response.body;

    for(var item in jsonDecode(data)){
      checklist.add(ChecklistItem.fromJson(item));
    }

    return checklist;
  }
  static getWetSamplingChecklist() async {
    final url =
        '${baseURL}api/views/wet_sampling_checklist?_format=json';

    final response = await http
        .get(Uri.parse(url));

    final List<ChecklistItem> checklist = [];

    final data = response.body;

    for(var item in jsonDecode(data)){
      checklist.add(ChecklistItem.fromJson(item));
    }

    return checklist;
  }
  static getDrySamplingChecklist() async {
    final url =
        '${baseURL}api/views/dry_sampling_checklist?_format=json';

    final response = await http
        .get(Uri.parse(url));

    final List<ChecklistItem> checklist = [];

    final data = response.body;

    for(var item in jsonDecode(data)){
      checklist.add(ChecklistItem.fromJson(item));
    }

    return checklist;
  }
}
